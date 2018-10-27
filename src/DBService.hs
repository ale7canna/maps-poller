{-# LANGUAGE OverloadedStrings #-}

module DBService where

import Database.PostgreSQL.Simple
import Data.Text as Text
import Data.ByteString
import Data.ByteString.Char8 as B
import Models.Config
import Control.Lens

createConnection :: String -> IO Connection
createConnection = connectPostgreSQL . B.pack

executeQuery :: Connection -> Query -> IO Int
executeQuery conn q = do
  [Only i] <- query_ conn q
  return i

buildConnectionString :: Config -> String
buildConnectionString c =
  "host='" ++ view host c ++
  "' port=" ++ show (view port c) ++
  " dbname='" ++ view dbname c ++
  "' user='" ++ view user c ++
  "' password='" ++ view password c ++ "'"
