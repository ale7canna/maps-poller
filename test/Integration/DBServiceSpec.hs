{-# LANGUAGE OverloadedStrings #-}
module Integration.DBServiceSpec where

import Test.Hspec
import Test.QuickCheck
import Control.Exception(evaluate)
import Models.Config
import Configuration
import Database.PostgreSQL.Simple

import DBService

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  it "should build connection string from Config" $ do
    buildConnectionString (Config "somehost" 123 "some db" "user" "pwd") `shouldBe`
      "host='somehost' port=123 dbname='some db' user='user' password='pwd'"

  it "should connect to database and exec query" $ do
    config <- getConfiguration
    conn <- getConnection $ fmap (createConnection . buildConnectionString) config
    res <- executeQuery conn ("SELECT 2 + 2")
    res `shouldBe` (4 :: Int)

getConnection :: Either (String) (IO Connection) -> IO Connection
getConnection (Right x) = x
