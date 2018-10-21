module ConfigurationSpec where

import Test.Hspec
import Test.QuickCheck
import Control.Exception(evaluate)
import Configuration
import Models.Config
import Control.Lens
import Data.Text as T

main :: IO ()
main = hspec spec

spec :: Spec
spec = do


  it "should read configuration host" $ do
    config <- getConfiguration
    view host (right config) `shouldNotBe` ""

  it "should read configuration port" $ do
    config <- getConfiguration
    view port (right config) `shouldNotBe` 0

  it "should read configuration database name" $ do
    config <- getConfiguration
    view dbname (right config) `shouldNotBe` ""

  it "should read configuration user" $ do
    config <- getConfiguration
    view user (right config) `shouldNotBe` ""

  it "should read configuration password" $ do
    config <- getConfiguration
    view password (right config) `shouldNotBe` ""

isRight :: Either a b -> Bool
isRight (Right _) = True
isRight (Left _) = False

right :: Either a b -> b
right (Right b) = b
