module Lib where

import Data.Text.Template
import qualified Data.Text as T
import qualified Data.Text.Lazy as L

someFunc :: IO ()
someFunc = putStrLn "someFunc"

computeRequest :: IO String
computeRequest = do
  body <- loadRequestBody
  key <- loadAPIKey
  return (mergeApiKey body key)

loadRequestBody :: IO String
loadRequestBody = readFile "resource/request_body"

loadAPIKey :: IO String
loadAPIKey = readFile "resource/api_key"

mergeApiKey :: String -> String -> String
mergeApiKey body key =
  T.unpack $ L.toStrict $ substitute (T.pack body) (giveContext key)

giveContext :: String -> Context
giveContext apikey =
  context [(T.pack "api_key", T.pack apikey)]

-- | Create 'Context' from association list.
context :: [(T.Text, T.Text)] -> Context
context assocs x = maybe err id . lookup x $ assocs
  where err = error $ "Could not find key: " ++ T.unpack x

