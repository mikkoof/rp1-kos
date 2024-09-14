set countdownStart to TimeStamp():seconds.   // 1
lock currentTime to TimeStamp():seconds.     // 2
parameter secondsToLaunch is 10.

declare function GetSecondsToLaunch {
    return countdownStart + secondsToLaunch - currentTime.
}

