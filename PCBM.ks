runOncePath("0:tools/Touchbase.ks").
runOncePath("0:tools/Countdown.ks"). 
runOncePath("0:tools/Launch/Patient.ks").
runOncePath("0:tools/Staging/Staging.ks").  


parameter pitchAngle is 8.

lock timer to GetSecondsToLaunch().

clearScreen.
lock throttle to 1.

set steer to heading(90,90).
lock steering to steer.

local flightState is 1.
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

  // Gather initial velocity and altitude. roll to desired heading.
  if flightState = 2 {
    set steer to heading(90,90).
    if (vessel:airspeed > 100 or vessel:altitude > 100) {
      set flightState to 3.
    }
  }

  // Activate gravity turn.
  if flightState = 3 {
    set desiredPitch to 90 - pitchAngle.

    set steer to heading(90,90 - pitchAngle).
    if vessel:heading():pitch < desiredPitch + 1 and vessel:heading():pitch > desiredPitch - 1 {
      set flightState to 4.
    }
  }

  // point prograde until q < 0.1
  if flightState = 4 {
    set steer to prograde.
    if vessel:dynamicpressure < 0.1 {
      set flightState to 5.
    }
  }

  if flightState = 5 {
    if vessel:thrust = 0 {
      set flightState to 0.
    }
  }
}