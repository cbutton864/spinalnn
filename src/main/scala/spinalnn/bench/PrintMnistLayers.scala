package spinalnn.bench

import spinalnn.compiler._

object PrintMnistLayers extends App {
  val model = OnnxCompiler.loadModel("models/mnist-8.onnx")
  val specs = OnnxFrontend.lower(model, OnnxFrontend.MnistCalibration, emitLogits = false)
  specs.foreach {
    case c: LayerSpec.Conv    =>
      println(f"Conv     ${c.name}%-40s C_in=${c.inputShape.channels}%3d  C_out=${c.shape.channels}%3d  k=${c.kernelH}x${c.kernelW}")
    case p: LayerSpec.MaxPool =>
      println(f"MaxPool  ${p.name}%-40s")
    case s                    =>
      println(f"${s.getClass.getSimpleName}%-10s ${s.name}")
  }
  println()
  println(ModelCycleEstimator.sweep(specs))
}
