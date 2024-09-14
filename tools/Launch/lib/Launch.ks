runOncePath("0:tools/PrintCorner.ks").

declare global countdownStart is TimeStamp():second.
declare global secondsToLaunch is 10.

set LV to SHIP.
set abort to false. 

LOCK g TO SHIP:BODY:MU / (SHIP:BODY:RADIUS + SHIP:ALTITUDE)^2.
LOCK twr to (LV:thrust / (g * ship:mass)).

print PrintUpperRight("Countdown initiated" + countdownStart).

declare function CountDown {
    set secondsToLaunch to (countdownStart + secondsToLaunch) - TimeStamp():second.
    set upperLeftRow to 0.
    PrintUpperLeft("T - " + secondsToLaunch).
}

set litEngines to list().

declare function LightEngines {
    set enginesActive to false.
    until enginesActive {
        wait until stage:ready.
        stage.
        list engines in allEngines.
        for currentEngine in allEngines {
            if currentEngine:ignition {
                litEngines:add(currentEngine).
            }
        }
        if litEngines:length > 0 {
            set enginesActive to true.
        }
    }
    return enginesActive.
}

declare function LiftOff {
    wait until stage:ready.
    stage.
    PrintUpperRight("Liftoff!").
}

declare function HandleEnginesNotAllowingShutdown {
    for currentEngine in litEngines {
        if currentEngine:allowShutdown = false {
            PrintUpperRight("Solid booster(s) active").
            return true.
        }
    }
}

declare local preflightState is 0.


declare function PreflightCheck {
    if preflightState = 0 {
        set preflightState to 1.
        PrintUpperRight("Preflight check initiated").
    }
    if preflightState = 1 {
        if secondsToLaunch < 2 {
            if (LightEngines()) {
                set preflightState to 2.
                PrintUpperRight("Engines activated").
            }
        }
    }
    if preflightState = 2 {
        if (litEngines:length = 0) {
            set preflightState to 1.
            PrintUpperRight("No engines detected").
        }

        // Handle solids in first stage
        if (HandleEnginesNotAllowingShutdown()) {
            set secondsToLaunch to 0.
            PrintUpperRight("Lift-off imminent!").
            wait 0.
        }

        if secondsToLaunch < 1 {
            set currentTWR to twr.

            PrintUpperRight("Current TWR: " + currentTWR).

            local TWROk is false.
            local EnginesOk is false.

            if currentTWR > 1 {
                PrintUpperRight("TWR nominal").
                set TWROk to true.
            }

            // engines are active and none are failing
            if litEngines:length > 0 {
                for currentEngine in litEngines {
                    if currentEngine:flameout {
                        PrintUpperRight("Engine failure detected").
                        set EnginesOk to false.
                        break.
                    }
                    else {
                        PrintUpperRight("Engines nominal").
                        set EnginesOk to true.
                    }
                }
            }

            if not EnginesOk {
                set preflightState to -1.
            }

            if TWROk {
                set preflightState to 3.
            }
        }
    }
    if preflightState = 3 and secondsToLaunch < 0 {
        PrintUpperRight("All systems go").
        return true.
    }
    if preflightState = -1 {
        PrintUpperRight("Preflight check failed").
        set abort to true.
    }
    return false.
}



declare function Launch {
    CountDown().
    set readyToLaunch to PreflightCheck().
    if readyToLaunch {
        LiftOff().
        return true.
    }
    if abort {
        return true.
    }
    return false.
}