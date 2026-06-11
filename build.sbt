val spinalVersion = "1.14.0"

lazy val root = (project in file("."))
  .configs(IntegrationTest)
  .settings(
    Defaults.itSettings,
    name         := "spinalnn",
    version      := "0.1.0",
    scalaVersion := "2.13.16",
    libraryDependencies ++= Seq(
      "com.github.spinalhdl" %% "spinalhdl-core" % spinalVersion,
      "com.github.spinalhdl" %% "spinalhdl-lib"  % spinalVersion,
      "com.github.spinalhdl" %% "spinalhdl-sim"  % spinalVersion,
      "com.thesamet.scalapb" %% "scalapb-runtime" % "0.11.15" % "protobuf",
      compilerPlugin("com.github.spinalhdl" %% "spinalhdl-idsl-plugin" % spinalVersion),
      "com.lihaoyi"           %% "upickle"         % "3.3.1",
      "org.scalatest" %% "scalatest" % "3.2.18" % "test,it"
    ),
    Compile / PB.targets := Seq(
      scalapb.gen() -> (Compile / sourceManaged).value / "scalapb"
    ),
    Compile / scalaSource := baseDirectory.value / "src" / "main" / "scala",
    Test    / scalaSource := baseDirectory.value / "src" / "test" / "scala",
    IntegrationTest / scalaSource := baseDirectory.value / "src" / "it" / "scala",
    fork                       := true,
    // Large pre-quantized models (e.g. SqueezeNet, ~1.2M weight literals across 26 convs)
    // need more elaboration heap than the JVM default. -Xmx is a ceiling, not a
    // reservation, so the small unit tests pay nothing for it.
    Test / javaOptions += "-Xmx4g",
    Test / parallelExecution   := false,
    IntegrationTest / parallelExecution := false
  )
