module MapsRequestSpec where

import Test.Hspec
import Test.QuickCheck
import Control.Exception(evaluate)
import Data.Text as T
import MapsRequest

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  it "should load request body from file" $ do
    result <- loadRequestBody
    result `shouldNotBe` T.pack ""

  it "should load API key from file" $ do
    result <- loadAPIKey
    result `shouldNotBe` T.pack ""

  it "should replace placeholder in string" $ do
    T.unpack (mergeApiKey (T.pack "this is a body with this $api_key placheholder") (T.pack "key_to_substitute")) `shouldContain` "key_to_substitute"

  it "should use api key in request" $ do
    result <- computeRequest
    apikey <- loadAPIKey
    result `shouldContain` (T.unpack $ T.strip apikey)
