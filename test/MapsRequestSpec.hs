module MapsRequestSpec where

import Test.Hspec
import Test.QuickCheck
import Control.Exception(evaluate)
import MapsRequest

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  it "should load request body from file" $ do
    result <- loadRequestBody
    result `shouldNotBe` ""

  it "should load API key from file" $ do
    result <- loadAPIKey
    result `shouldNotBe` ""

  it "should replace placeholder in string" $ do
    mergeApiKey "this is a body with this $api_key placheholder" "key_to_substitute" `shouldContain` "key_to_substitute"

  it "should use api key in request" $ do
    result <- computeRequest
    apikey <- loadAPIKey
    result `shouldContain` apikey
