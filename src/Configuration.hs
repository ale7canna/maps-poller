module Configuration where

import Data.Text as T
import Data.Ini
import Models.Config

getConfiguration :: IO (Either String Config)
getConfiguration = do
  ini <- readConfigurationIni
  let host = ini >>= getParam "host"
  let port = ini >>= getParam "port"
  let username = ini >>= getParam "username"
  let password = ini >>= getParam "password"
  let dbname = ini >>= getParam "dbname"
  let config1 = fmap (\h -> setConfigHost (T.unpack h) empty) (host)
  let config2 = config1 >>= (\c -> fmap (\p -> setConfigPort (read (T.unpack p) :: Integer) c) (port))
  let config3 = config2 >>= (\c -> fmap (\un -> setConfigUsername (T.unpack un) c) (username))
  let config4 = config3 >>= (\c -> fmap (\pwd -> setConfigPassword (T.unpack pwd) c) (password))
  let config5 = config4 >>= (\c -> fmap (\db -> setConfigDbname (T.unpack db) c) (dbname))
  return config5
  where empty = Config "" 0 "" "" ""

getParam :: String -> Ini -> Either String Text
getParam param ini = lookupValue (T.pack "DEFAULT") (T.pack param) ini

readConfigurationIni :: IO (Either String Ini)
readConfigurationIni =
  readIniFile "resource/app.ini"
