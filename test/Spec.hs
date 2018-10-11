import Test.Hspec
import Test.QuickCheck
import Control.Exception(evaluate)

main :: IO ()
main = hspec $ do
  it "true should be true" $ do
    True `shouldBe` True
