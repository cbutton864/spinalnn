package spinalnn.compiler

import org.scalatest.funsuite.AnyFunSuite
import spinalnn.target._

class CompileConfigTest extends AnyFunSuite {

  // ── macParallelism / macParallelismOverrides ──────────────────────────────

  test("macParallelism=auto with no overrides parses to MacParAuto") {
    val cfg = CompileConfig.fromJson("""{"macParallelism":"auto"}""")
    assert(cfg.toTargetConfig.options.macParallelism == MacParAuto)
  }

  test("macParallelism=fixed integer parses to MacParFixed") {
    val cfg = CompileConfig.fromJson("""{"macParallelism":"16"}""")
    assert(cfg.toTargetConfig.options.macParallelism == MacParFixed(16))
  }

  test("macParallelismOverrides with integer default produces MacParPerLayer") {
    val json = """{
      "macParallelism": "16",
      "macParallelismOverrides": {
        "conv10_1_quantized": 32,
        "fire9_squeeze1x1_1_quantized": 32
      }
    }"""
    val tc = CompileConfig.fromJson(json).toTargetConfig
    tc.options.macParallelism match {
      case MacParPerLayer(overrides, default) =>
        assert(default == 16)
        assert(overrides("conv10_1_quantized") == 32)
        assert(overrides("fire9_squeeze1x1_1_quantized") == 32)
        assert(overrides.size == 2)
      case other => fail(s"Expected MacParPerLayer, got $other")
    }
  }

  test("macParallelismOverrides with auto default uses default=1") {
    val json = """{
      "macParallelism": "auto",
      "macParallelismOverrides": { "conv10_1_quantized": 32 }
    }"""
    val tc = CompileConfig.fromJson(json).toTargetConfig
    tc.options.macParallelism match {
      case MacParPerLayer(overrides, default) =>
        assert(default == 1)
        assert(overrides("conv10_1_quantized") == 32)
      case other => fail(s"Expected MacParPerLayer, got $other")
    }
  }

  // ── macParByChannels ──────────────────────────────────────────────────────

  test("macParByChannels produces MacParByChannels with correct channelMap and default") {
    val json = """{
      "macParallelism": "16",
      "macParByChannels": { "48": 48, "96": 32, "192": 32 }
    }"""
    val tc = CompileConfig.fromJson(json).toTargetConfig
    tc.options.macParallelism match {
      case MacParByChannels(cm, dflt, lo) =>
        assert(dflt == 16)
        assert(cm == Map(48 -> 48, 96 -> 32, 192 -> 32))
        assert(lo.isEmpty)
      case other => fail(s"Expected MacParByChannels, got $other")
    }
  }

  test("macParByChannels with auto default uses default=1") {
    val json = """{"macParByChannels": { "3": 3, "48": 16 }}"""
    val tc = CompileConfig.fromJson(json).toTargetConfig
    tc.options.macParallelism match {
      case MacParByChannels(cm, dflt, lo) =>
        assert(dflt == 1)
        assert(cm == Map(3 -> 3, 48 -> 16))
        assert(lo.isEmpty)
      case other => fail(s"Expected MacParByChannels, got $other")
    }
  }

  test("macParByChannels with layerOverrides populates MacParByChannels.layerOverrides") {
    val json = """{
      "macParallelism": "16",
      "macParByChannels": { "48": 48 },
      "macParallelismOverrides": { "special_layer": 1 }
    }"""
    val tc = CompileConfig.fromJson(json).toTargetConfig
    tc.options.macParallelism match {
      case MacParByChannels(cm, dflt, lo) =>
        assert(cm == Map(48 -> 48))
        assert(dflt == 16)
        assert(lo == Map("special_layer" -> 1))
      case other => fail(s"Expected MacParByChannels, got $other")
    }
  }

  test("macParByChannels round-trip through JSON serialisation") {
    val original = CompileConfig(
      macParallelism  = "16",
      macParByChannels = Map("3" -> 3, "48" -> 48, "96" -> 32)
    )
    val roundTripped = CompileConfig.fromJson(CompileConfig.toJson(original))
    assert(roundTripped == original)
    roundTripped.toTargetConfig.options.macParallelism match {
      case MacParByChannels(cm, dflt, _) =>
        assert(cm == Map(3 -> 3, 48 -> 48, 96 -> 32))
        assert(dflt == 16)
      case other => fail(s"Expected MacParByChannels, got $other")
    }
  }

  // ── Full per-layer config matching squeezenet_ti180_perLayer.json ─────────

  test("squeezenet_ti180_perLayer.json parses to correct MacParPerLayer") {
    val jsonFile = new java.io.File("examples/squeezenet_ti180_perLayer.json")
    assume(jsonFile.exists(), "examples/squeezenet_ti180_perLayer.json not present; skipping")
    val tc = CompileConfig.fromFile(jsonFile.getPath).toTargetConfig
    tc.options.macParallelism match {
      case MacParPerLayer(overrides, default) =>
        assert(default == 16)
        assert(overrides("conv1_1_quantized") == 3)
        assert(overrides.size == 1)
      case other => fail(s"Expected MacParPerLayer, got $other")
    }
    assert(tc.options.weightMode == WeightStream)
  }

  // ── JSON serialization round-trip ────────────────────────────────────────

  test("CompileConfig serialises and deserialises without loss") {
    val original = CompileConfig(
      macParallelism          = "16",
      macParallelismOverrides = Map("conv10_1_quantized" -> 32, "fire8_squeeze1x1_1_quantized" -> 32),
      weightMode              = "stream"
    )
    val roundTripped = CompileConfig.fromJson(CompileConfig.toJson(original))
    assert(roundTripped == original)
  }
}
