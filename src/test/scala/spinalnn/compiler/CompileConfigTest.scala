package spinalnn.compiler

import org.scalatest.funsuite.AnyFunSuite
import spinalnn.target._

class CompileConfigTest extends AnyFunSuite {

  // ── macParallelismOverrides round-trip ────────────────────────────────────

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

  // ── dmaFreqMhz round-trip ────────────────────────────────────────────────

  test("dmaFreqMhz absent defaults to None") {
    val cfg = CompileConfig.fromJson("""{}""")
    assert(cfg.toTargetConfig.options.dmaFreqMhz == None)
  }

  test("dmaFreqMhz present wires through to CompilerOptions") {
    val cfg = CompileConfig.fromJson("""{"dmaFreqMhz": 300}""")
    assert(cfg.toTargetConfig.options.dmaFreqMhz == Some(300))
  }

  // ── Full per-layer config matching squeezenet_ti180_perLayer.json ─────────

  test("squeezenet_ti180_perLayer.json parses to correct MacParPerLayer + dmaFreqMhz") {
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
    assert(tc.options.dmaFreqMhz == None)
    assert(tc.options.weightMode  == WeightStream)
  }

  // ── JSON serialization round-trip ────────────────────────────────────────

  test("CompileConfig serialises and deserialises without loss") {
    val original = CompileConfig(
      macParallelism          = "16",
      macParallelismOverrides = Map("conv10_1_quantized" -> 32, "fire8_squeeze1x1_1_quantized" -> 32),
      dmaFreqMhz              = Some(300),
      weightMode              = "stream"
    )
    val roundTripped = CompileConfig.fromJson(CompileConfig.toJson(original))
    assert(roundTripped == original)
  }
}
