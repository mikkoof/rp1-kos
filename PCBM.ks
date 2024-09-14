runOncePath("0:tools/Touchbase.ks").
runOncePath("0:tools/Countdown.ks"). 
runOncePath("0:tools/Launch/Patient.ks").
runOncePath("0:tools/Staging/Staging.ks").  
runOncePath("0:tools/lib/Mach.ks").
runOncePath("0:tools/Launch/lib/SimpleGravityTurn.ks").
clearScreen.
set LV to SHIP.


lock timer to GetSecondsToLaunch().

clearScreen.
lock throttle to 1.

set controller to steeringManager.
SET STEERINGMANAGER:SHOWFACINGVECTORS TO false.

local direction to 90.
local pitchAngle to 0.
lock steering to lookdirup(heading(direction,90-pitchAngle):vector,ship:facing:upvector).

global flightState is 1.
when abort = true then {
  set flightState to 0.
}.

until flightState = 0 {
  Touchbase().

  // Activate engines and launch the rocket. 
  if flightState = 1 and timer < 1 {
    if PatientLaunch() {
      set flightState to 2.
    }
  }

  // Activate gravity turn.
  if flightState = 2 {

  }

  if flightState =3 {
    if LV:thrust = 0 {
      set flightState to 0.
    }
  }
}