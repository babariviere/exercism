module SpaceAge (Planet(..), ageOn) where

data Planet = Mercury
            | Venus
            | Earth
            | Mars
            | Jupiter
            | Saturn
            | Uranus
            | Neptune

orbitalPeriod :: Planet -> Float
orbitalPeriod Earth   = 1.0
orbitalPeriod Mercury = 0.2408467
orbitalPeriod Venus   = 0.61519726
orbitalPeriod Mars    = 1.8808158
orbitalPeriod Jupiter = 11.862615
orbitalPeriod Saturn  = 29.447498
orbitalPeriod Uranus  = 84.016846
orbitalPeriod Neptune = 164.79132

earthYears :: Float
earthYears = 31557600

ageOn :: Planet -> Float -> Float
ageOn planet seconds = seconds / (earthYears * period)
  where period = orbitalPeriod planet
