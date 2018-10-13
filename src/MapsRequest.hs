module MapsRequest (
  computeRequest,
  loadRequestBody,
  loadAPIKey,
  mergeApiKey
  ) where

import Data.Text.Template
import qualified Data.Text as T
import qualified Data.Text.IO as T
import qualified Data.Text.Lazy as L

computeRequest :: IO String
computeRequest = do
  body <- loadRequestBody
  key <- loadAPIKey
  return $ T.unpack $ mergeApiKey (T.strip body) (T.strip key)

loadRequestBody :: IO T.Text
loadRequestBody = T.readFile "resource/request_body"

loadAPIKey :: IO T.Text
loadAPIKey = T.readFile "resource/api_key"

mergeApiKey :: T.Text -> T.Text -> T.Text
mergeApiKey body key =
 L.toStrict $ substitute (body) (giveContext key)

giveContext :: T.Text -> Context
giveContext apikey =
  context [(T.pack "api_key", apikey)]

-- | Create 'Context' from association list.
context :: [(T.Text, T.Text)] -> Context
context assocs x = maybe err id . lookup x $ assocs
  where err = error $ "Could not find key: " ++ T.unpack x
