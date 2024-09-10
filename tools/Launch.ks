runOncePath("./PrintCorner.ks").

declare global countdownStart is TimeStamp:SECOND.
declare global secondsToLaunch is 10.

print PrintUpperRight("Countdown initiated").

declare function CountDown {
    parameter secondsRemaining is 10.
    set secondsRemaining to (countdownStart + secondsRemaining) + TimeStamp:SECOND.
    PrintUpperLeft("T - " + secondsRemaining).
    set secondsToLaunch to secondsRemaining.
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
                litEngines.add(currentEngine).
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
        if secondsToLaunch < 1 {
            lock currentTWR to addons:ke:actualTWR.
            lock targetTWR to addons:ke:totalTWR.

            print "Current TWR: " + currentTWR.
            print "Target TWR: " + targetTWR.

            local TWROk is false.
            local EnginesOk is false.

            if currentTWR > targetTWR * 0.95 and currentTWR > 1 {
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
                        set EnginesOk to true.
                    }
                }
            }

            if TWROk and EnginesOk {
                set preflightState to 3.
            }
        }
    }
    if preflightState = 3 and secondsToLaunch < 0 {
        PrintUpperRight("All systems go").
        return true.
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
    false.
}