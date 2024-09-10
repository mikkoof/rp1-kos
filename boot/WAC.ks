runOncePath("../tools/Launch.ks").
// runOncePath("../tools/Guidance.ks").

local flightState is 1.
lock steering to R(0,0,-90) + HEADING(90,90).
lock throttle to 1.

until flightState = 0 {
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
    wait until addons:ke:actualTWR = 0.
  }

}