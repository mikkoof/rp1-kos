runOncePath("0:tools/Countdown.ks").
runOncePath("0:tools/Launch/lib/RangeGravityTurn.ks").  
set LV to SHIP.
set controller to steeringManager.


lock timer to GetSecondsToLaunch().
lock shipMaxThrust to LV:maxthrust.
lock shipThrust to LV:thrust.
lock g to SHIP:BODY:MU / (SHIP:BODY:RADIUS + SHIP:ALTITUDE)^2.
lock angleError to Round(controller:angleerror,2).

lock finalPitch to GetNewPitch().

declare function Touchbase {
  set line to 0.
  print "********"+ship:name+"********" at(0, line).
  set line to line + 1.
  print "T : " + -Round(timer) + "         " at(0, line).
  set line to line + 1.
  print "Thrust / Max Thrust - " + Round(shipThrust, 2) + " / " + Round(shipMaxThrust, 2) at(0, line).
  set line to line + 1.
  print "Current flightstate - " + flightState at(0, line).
  set line to line + 1.
  print "Angle error - " + angleError at(0, line).
  set line to line + 1.
  print "G - " + Round(g,2) at(0, line).
  set line to line + 1.
  print "Pitch at flamout - " + Round(finalPitch,2) at(0, line).
}

