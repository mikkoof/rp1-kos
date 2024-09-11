runOncePath("0:tools/PrintCorner.ks").

set boosters to ship:partsdubbed("Booster").

declare function StagingManager {
  if stage:nextDecoupler<>"None" {
    if boosters:length > 0 {
      for booster in boosters {
        if (booster:maxthrust * 0.1) > booster:thrust {
            wait until stage:ready.
            stage.
            set boosters to SHIP:PARTSDUBBED("Booster").
            PrintUpperRight("Booster separation").
        }
      }
    }
  }
}.