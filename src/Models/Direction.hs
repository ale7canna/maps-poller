{-# LANGUAGE DeriveGeneric #-}

module Models.Direction where

import GHC.Generics
import Data.Aeson

data Duration = Duration {text :: String, value :: Integer} deriving Generic
instance FromJSON Duration

data Leg = Leg {duration :: Duration, duration_in_traffic :: Duration} deriving Generic
instance FromJSON Leg

data Route = Route {legs :: [Leg]} deriving Generic
instance FromJSON Route

data Direction = Direction {routes :: [Route]} deriving Generic
instance FromJSON Direction

getDuration :: Direction -> (Integer, Integer)
getDuration (Direction ((Route ((Leg d dit):_)):_) ) = (parseDuration d, parseDuration dit)

parseDuration :: Duration -> Integer
parseDuration (Duration text value) = value
