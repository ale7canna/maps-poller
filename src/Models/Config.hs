{-# LANGUAGE TemplateHaskell #-}

module Models.Config where

import Control.Lens
import Data.Ini
import Data.Text as T

data Config = Config {_host :: String, _port :: Integer,  _dbname :: String, _user :: String, _password :: String}
  deriving (Show, Eq)
makeLenses ''Config

setConfigHost :: String -> Config -> Config
setConfigHost h = set host h

setConfigPort :: Integer -> Config -> Config
setConfigPort p = set port p

setConfigUsername :: String -> Config -> Config
setConfigUsername un = set user un

setConfigPassword :: String -> Config -> Config
setConfigPassword pwd = set password pwd

setConfigDbname :: String -> Config -> Config
setConfigDbname db = set dbname db
