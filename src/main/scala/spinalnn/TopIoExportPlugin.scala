package spinalnn

import spinal.core._
import spinal.core.fiber._
import spinal.lib._
import spinal.lib.misc.plugin._
import spinalnn.types._
import scala.util.Try

// Single IO wiring hub. Two-phase discipline:
//   Phase 1: all .load() calls  (non-blocking -- feed pad inputs to plugins)
//   Phase 2: all .await() calls (blocking  -- read plugin outputs, drive pads)
// Never call .await before all .load calls are done -- Fiber deadlock results.
case class TopIoExportPlugin() extends FiberPlugin {

  val logic = during build new Area {
    val top = Component.current.asInstanceOf[SpinalNNTop]

    // ── Phase 1: load inputs ─────────────────────────────────────────────
    Try(host[InferenceInput]).toOption.foreach { inp =>
      inp.activationIn.load(top.io.activationIn)
    }

    // ── Phase 2: await outputs ───────────────────────────────────────────
    Try(host[NetworkOutput]).toOption match {
      case Some(out) =>
        top.io.activationOut << out.networkOut.await
      case None =>
        top.io.activationOut.valid         := False
        top.io.activationOut.payload.value := 0
    }
  }
}
