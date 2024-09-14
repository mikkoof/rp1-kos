runOncePath("0:tools/lib/Acceleration.ks").
runOncePath("0:tools/lib/FuelFlow.ks").

// Correct pitch to finish burn at 45 degrees.
set LV to SHIP.

// Locks
lock stageBurnTime to LV:burntime.
lock shipMass to LV:mass.
lock thrust to LV:thrust.
lock burnrate to GetShipFuelFlow().
lock g to SHIP:BODY:MU / (SHIP:BODY:RADIUS + SHIP:ALTITUDE)^2.
lock vx0 to velocity:surface:x.
lock vy0 to velocity:surface:y.

declare function GetNewPitch {
  //Constants
  // parameter pitchTarget is constant:degtorad * 45.
  parameter t1 is stageBurnTime. // Time at which we want to achieve the pitch target.  
  // local intialAcceleration to GetAcceleration(t[0], mass, burnrate, thrust).

  // Time step and array setup
  local dT is 1. // Time step for the simulation.
  local t is {
    set timeSteps to list().
    for i in range(0, t1, dT) {
      timeSteps.add(i).
    }
    return timeSteps.
  }.

  // Arrays to store the results
  local vx is list().
  local vy is list(). 
  local pitch is list().

  // Simulate the path
  from { local i is 1 .} until i = t:length step { set i to i + 1 .} do {
    local acceleration is GetAcceleration(t[i], shipMass, burnrate, thrust).
    set vx[i] to vx[i-1] + acceleration * cos(pitch[i-1]) * dT.
    set vy[i] to vy[i-1] + (acceleration * sin(pitch[i-1]) - g) * dT.

    set pitch[i] to arcTan2(vy[i], vx[i]).
  }.

  return pitch[pitch:length-1].
}