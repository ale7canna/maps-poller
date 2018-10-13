{-# LANGUAGE DeriveGeneric #-}

module Application (
  runApplication,
  runRequest
  ) where

import MapsRequest
import Network.HTTP.Simple
import Network.HTTP.Client
import Data.Aeson.Types
import Data.Aeson (Value)
import Data.Char
import GHC.Generics
import Models.Direction

runApplication :: IO ()
runApplication = do
  request <- computeRequest
  result <- runRequest request
  putStr $ show result

-- httpJSONEither :: (MonadIO m, FromJSON a) => Request -> m (Response (Either JSONException a))
-- httpJSON :: (MonadIO m, FromJSON a) => Request -> m (Response a) 

runRequest :: String -> IO (Integer, Integer)
runRequest x = parseRequest x >>= httpJSON >>= durationFromResponse

durationFromResponse :: Response Direction -> IO (Integer, Integer)
durationFromResponse x = return $ getDuration $ (getResponseBody x :: Direction)
