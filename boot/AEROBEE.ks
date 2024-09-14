// Countdown.
// Activate booster and main engines and launch
// Stage when booster thrust is less than 10% of max thrust.
// Stage when main engine fuel is going to run out in 1 second.
// Stage when main engine flameout detected.

runOncePath("0:tools/Touchbase.ks").
runOncePath("0:tools/Countdown.ks"). 
runOncePath("0:tools/Launch/instant.ks").
runOncePath("0:tools/Staging/Staging.ks").  


lock timer to GetSecondsToLaunch().

clearScreen.
lock throttle to 1.

local flightState is 1.
until flightState = 0 {
  Touchbase().

  // Activate engines and launch the sounding rocket.
  if flightState = 1 and timer < 0 {
    set flightState to 2.
    InstantLaunch().
  }
  // Accelerate quickly and drop the solid booster.
  if flightState = 2 {
    if StageSolidBoosters() {
      set flightState to 3.
    }
  }

  //TODO for 2 stage rocket: 
  // Activate next engine when the previous one is about to flameout in 1 second.
  // Stage when main engine flameout detected.
  wait 0.
}