package spinalnn

import spinal.core._
import spinalnn.target.CompileConfig

/**
 * CLI entry point: compile an ONNX model to Verilog using a JSON config file.
 *
 * Usage:
 *   sbt "runMain spinalnn.Compile examples/mnist_ti180.json"
 *
 * The JSON config file drives all compilation options — see CompileConfig for the
 * full field reference. The model path in the config is resolved relative to the
 * current working directory (typically the repo root when launched via sbt).
 *
 * Exit codes: 0 = success, 1 = bad arguments, 2 = config parse error, 3 = compile error.
 */
object Compile extends App {

  if (args.length < 1) {
    System.err.println("Usage: Compile <config.json> [<config.json> ...]")
    System.err.println("  Each JSON file specifies one model to compile.")
    System.exit(1)
  }

  args.foreach { path =>
    val cfg = try {
      CompileConfig.fromFile(path)
    } catch {
      case e: Exception =>
        System.err.println(s"[Compile] Failed to parse '$path': ${e.getMessage}")
        System.exit(2)
        null  // unreachable, but satisfies the type checker
    }

    val target = try {
      cfg.toTargetConfig
    } catch {
      case e: IllegalArgumentException =>
        System.err.println(s"[Compile] Invalid config in '$path': ${e.getMessage}")
        System.exit(2)
        null
    }

    println(s"[Compile] $path")
    println(s"  model  : ${cfg.model}")
    println(s"  target : $target")
    println(s"  output : ${cfg.outputDir}")

    val spinalCfg = SpinalConfig(
      defaultClockDomainFrequency  = FixedFrequency(target.options.targetFreqMhz MHz),
      defaultConfigForClockDomains = ClockDomainConfig(
        resetKind        = ASYNC,
        resetActiveLevel = HIGH
      ),
      targetDirectory = cfg.outputDir
    )

    try {
      spinalCfg.generateVerilog {
        val params = Params(
          target  = target,
          profile = OnnxPathProfile(cfg.model, cfg.emitLogits)
        )
        val top = new SpinalNNTop(params)
        top.clockDomain.clock.setName("clk")
        top.clockDomain.reset.setName("reset")
        top
      }
      println(s"[Compile] Done -> ${cfg.outputDir}/")
    } catch {
      case e: Exception =>
        System.err.println(s"[Compile] RTL generation failed: ${e.getMessage}")
        e.printStackTrace()
        System.exit(3)
    }
  }
}
