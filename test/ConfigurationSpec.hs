module ConfigurationSpec where

import Test.Hspec
import Test.QuickCheck
import Control.Exception(evaluate)
import Configuration
import Data.Text as T

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  it "should read configuration file" $ do
    result <- readConfigurationHost
    isRight result `shouldBe` True

isRight :: Either a b -> Bool
isRight (Right _) = True
isRight (Left _) = False
