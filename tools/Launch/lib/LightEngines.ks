runOncePath("0:tools/PrintCorner.ks").

set LV to SHIP.
LOCK g TO SHIP:BODY:MU / (SHIP:BODY:RADIUS + SHIP:ALTITUDE)^2.
LOCK twr to (LV:thrust / (g * ship:mass)).


list engines in allEngines.

declare function LightEngines {
  PrintUpperRight("Lighting engines").
  set enginesLit to false.
  wait until stage:ready.
  stage.
  set litEngines to list().

  for currentEngine in allEngines {
    if currentEngine:ignition {
      litEngines:add(currentEngine).
    }
  }

  if litEngines:length > 0 {
    set enginesLit to true.
  }

  return enginesLit. 
}

declare function VerifyEnginesWorking {
  set litEngines to activeEngines.  
  for currentEngine in litEngines {
    if currentEngine:flameout {
      PrintUpperRight("Engine failure detected").
      set abort to true.
      return false.
    }
  }
  return true.
}

declare function VerifyStableThrust {
  if ship:maxThrust * 0.9 < ship:thrust and twr > 1 {
    PrintUpperRight("Thrust stable").
    return true.
  }
  return false.
}