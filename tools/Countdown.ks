lock countdownStart to TimeStamp():second.
parameter secondsToLaunch is 10.

declare function GetSecondsToLaunch {
    set secondsToLaunch to (countdownStart + secondsToLaunch) - countdownStart.
    return secondsToLaunch.
}

