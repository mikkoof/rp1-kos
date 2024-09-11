clearScreen.

runOncePath("0:tools/Launch.ks").
runOncePath("0:tools/Staging.ks").

local flightState is 1.
lock steering to R(0,0,-90) + HEADING(90,90).
lock throttle to 1.

until flightState = 0 {
  if flightState >= 2 {
    StagingManager().
  }


  // Preflight check
  if flightState = 1 {
      if Launch() {
          set flightState to 2.
      }
      wait 0.
  }
  // Gather initial speed and altitude before gravity turn.
  if flightState = 2 {
    //run InitialGuidance().
    if addons:ke:actualTWR = 0 {
      set flightState to 0.
    }
  }

  wait 0.
}