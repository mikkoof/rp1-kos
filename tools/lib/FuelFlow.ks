
declare function GetEngineFuelFlow {
  parameter engine is engine.
  local t is engine:thrust.
  local isp is engine:isp.
  local g to SHIP:BODY:MU / (SHIP:BODY:RADIUS + SHIP:ALTITUDE)^2.

  return t / (g * isp).
}

declare function GetShipFuelFlow {
  list engines in EngineList.

  local fuelFlow is 0.
  for engine in EngineList {
    set fuelFlow to fuelFlow + GetEngineFuelFlow(engine).
  }
  return fuelFlow.
}