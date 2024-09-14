declare function GetInitialGravityTurnPitchAngleSimple {
  parameter turnEndAltitude is 1000.
  parameter turnEndAngle is 20.
  local pitchAngle to turnEndAngle * (ship:altitude / turnEndAltitude).
  if pitchAngle > turnEndAngle {
    set pitchAngle to turnEndAngle.
  }
  return pitchAngle.
}