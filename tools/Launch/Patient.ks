runOncePath("0:tools/PrintCorner.ks").
runOncePath("0:tools/Launch/lib/LightEngines.ks").

set currentVessel to ship.
LOCK g TO SHIP:BODY:MU / (SHIP:BODY:RADIUS + SHIP:ALTITUDE)^2.
LOCK twr to (currentVessel:thrust / (g * ship:mass)).

declare local launchState is 0.

declare function PatientLaunch {
  if launchState = 0 {
    set launchState to 1.
    PrintUpperRight("Launch initiated").
  }
  // Ignite engines
  if launchState = 1 {
    if LightEngines() {
      set launchState to 2.
    }
  }

  // Wait for stable thrust and check for failures.
  if launchState = 2 {
    if (not VerifyEnginesWorking()) {
      return false.
    }
    if VerifyStableThrust() {
      set launchState to 3.
    }
  }

  // Stage launch clamps
  if launchState = 3 {
    wait until stage:ready.
    stage.
    PrintUpperRight("Liftoff!").
    return true.
  }
  return false.
}