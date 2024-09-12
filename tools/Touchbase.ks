runOncePath("0:tools/Countdown.ks").
lock timer to GetSecondsToLaunch().

declare function Touchbase {
  set line to 0.
  print "********"+ship:name+"********" at(0, line).
  set line to line + 1.
  print "T - " + -timer at(0, line).
}

