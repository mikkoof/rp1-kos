declare function GetAcceleration {
  parameter currentTime, currentMass, burnrate, thrust.
  local massAtTime is currentMass - burnrate * currentTime.
  local g is SHIP:BODY:MU / (SHIP:BODY:RADIUS + SHIP:ALTITUDE)^2.
  return thrust / massAtTime - g.
}