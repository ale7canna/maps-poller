module Configuration where

import Data.Text as T
import Data.Ini

readConfigurationHost :: IO (Either String Text)
readConfigurationHost = do
  config <- readConfiguration
  return (config >>= lookupValue (T.pack "DEFAULT") (T.pack "host"))

readConfiguration :: IO (Either String Ini)
readConfiguration =
  readIniFile "resource/app.ini"
