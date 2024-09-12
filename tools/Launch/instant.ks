runOncePath("0:tools/PrintCorner.ks").

declare function InstantLaunch {
  wait until stage:ready.
  stage.
  PrintUpperRight("Liftoff!").
}