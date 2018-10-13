{-# LANGUAGE DeriveGeneric #-}
module Models.Direction where

import GHC.Generics
import Data.Aeson

data Duration = Duration {text :: String, value :: String} deriving Generic
instance FromJSON Duration

data Leg = Leg {duration :: Duration, durationInTraffic :: Duration} deriving Generic
instance FromJSON Leg

data Route = Route {legs :: [Leg]} deriving Generic
instance FromJSON Route

data Direction = Direction {routes :: [Route]} deriving Generic
instance FromJSON Direction
