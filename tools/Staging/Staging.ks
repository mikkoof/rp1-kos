runOncePath("0:tools/PrintCorner.ks").

set currentShip to ship.

list engines in shipEngines.
set activeEngines to list().
set solidBoosters to list().
updateEngines().

declare function updateEngines {
  set shipEngines to currentShip:engines.
  for engine in shipEngines {
      if engine:ignition {
          activeEngines:add(engine).
      }
  }
  for engine in activeEngines {
      if engine:allowShutdown = false {
          solidBoosters:add(engine).
      }
  }
}



declare function StageSolidBoosters {
  for engine in solidBoosters {
    if (engine:maxThrust * 0.1) > engine:thrust {
      wait until stage:ready.
      stage.
      updateEngines().
      PrintUpperRight("Booster separation").

      return true.
    }
  }
  return false.
}