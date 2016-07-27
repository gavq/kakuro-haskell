-- Example.hs  --  Examples from HUnit user's guide
--
-- For more examples, check out the tests directory.  It contains unit tests
-- for HUnit.

-- This example file will be the basis for Kakuro tests.

module KakuroTest where

import Test.HUnit
import Kakuro

foo :: Int -> (Int, Int)
foo x = (1, x)

partA :: Int -> IO (Int, Int)
partA v = return (v+2, v+3)

partB :: Int -> IO Bool
partB v = return (v > 5)

test1 :: Test
test1 = TestCase (assertEqual "for (foo 3)," (1,2) (foo 3))

test2 :: Test
test2 = TestCase (do (x,y) <- partA 3
                     assertEqual "for the first result of partA," 5 x
                     b <- partB y
                     assertBool ("(partB " ++ show y ++ ") failed") b)

tests :: Test
tests = TestList [TestLabel "test1" test1, TestLabel "test2" test2]

tests' :: Test
tests' = test [ "test1" ~: "(foo 3)" ~: (1,2) ~=? (foo 3),
                "test2" ~: do (x, y) <- partA 3
                              assertEqual "for the first result of partA," 5 x
                              partB y @? "(partB " ++ show y ++ ") failed" ]

main :: IO Counts
main = do
  putStrLn $ show $ permuteAll [v, v] 6
  putStrLn (draw Empty)
  putStrLn (draw (Across 9))
  putStrLn (draw (DownAcross 9 9))
  putStrLn (draw v)
  putStrLn (draw (vv [1, 3, 5, 9]))
  putStrLn (drawGrid grid1)
  putStrLn (drawGrid (solveGrid grid1))
  putStrLn $ drawGrid $ solver grid1
  do _ <- runTestTT tests
     runTestTT tests'
