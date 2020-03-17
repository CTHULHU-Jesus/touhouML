module KeyHandler where

import System.Process (callCommand)



pressKey :: Key -> IO ()
pressKey k = 
    callCommand $ "xdotool key " ++ (show k)

data Key = Shift
    | X
    | Z
    | Ctrl
    | UpArrow
    | LeftArrow
    | DownArrow
    | RightArrow
    deriving(Eq,Enum)

instance Show Key where
    show x = case x of
             X          -> "x"
             Z          -> "z"
             Ctrl       -> "ctrl"
             UpArrow    -> "Up" -- /Arrow"
             LeftArrow  -> "Left" -- /Arrow"
             DownArrow  -> "Down" -- /Arrow"
             RightArrow -> "Right" -- /Arrow"