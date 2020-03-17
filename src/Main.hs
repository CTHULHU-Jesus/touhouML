{-# LANGUAGE OverloadedStrings #-}
import Prelude
import Control.Concurrent (threadDelay)
import System.Process (callCommand)
import ScreenHandler
import KeyHandler


-- dt in miliSec
-- 0.5s = 500ms
dt :: Int
dt = 500

mainLoop :: Int -> IO (Int) -- [Matrix Float] -> IO ([Matrix Float])
mainLoop x | x > 0 =
        let
            k = (cycle [X,Z]) !! x :: Key
        in
        do
            threadDelay dt
            saveScreen $ "Screen-" ++ show x
            mainLoop $ x-1

mainLoop _ = return 0


main :: IO ()
main =
    do 
        initilize
        file <- return 4 :: IO Int --  readFile "matrix.saved" 
        out <- mainLoop  file -- (read file :: Int)
        writeFile "matrix.saved" (show out) 