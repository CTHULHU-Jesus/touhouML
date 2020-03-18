module Main where

import Graphics.UI.Gtk.Display.Image
import Graphics.UI.Gtk
import System.Environment
import Data.Text as T
import Graphics.UI.Gtk.Gdk.PixbufData
import Data.Matrix

initilize :: IO ()
initilize = 
    do
        _ <- initGUI
        return ()

getScreen :: IO (Matrix a)
getScreen = do
    Just screen <- screenGetDefault
    window <- screenGetRootWindow screen
    size <- drawableGetSize window
    origin <- drawWindowGetOrigin window
    Just pxbuf <-
        pixbufGetFromDrawable
            window
            ((uncurry . uncurry Rectangle) origin size)
    image <- pixbufGetPixels pxbuf
    numElems <- getNumElements
    return $ fromList  $ map unsafeRead [1..numElems]



main :: IO ()
main =
    do
        initilize
        image <- getScreen
        
