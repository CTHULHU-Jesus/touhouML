module ScreenHandler (initilize,saveScreen,getScreen) where
{-# LANGUAGE OverloadedStrings #-}

-- import Graphics.Gloss.Interface.Environment (getScreenSize)
-- import Graphics.Rendering.OpenGL (readPixels,Position(..),Size(..),PixelData(..),PixelFormat(..),DataType(..))
-- import Graphics.UI.GLUT hiding (Matrix(..))-- (getArgsAndInitialize)
import Data.Matrix
import Codec.Picture
import Data.Word
import Data.Bits
import Foreign
-- import Graphics.UI.Gtk.Gdk.PixbufData
import Data.Array.MArray 
import Data.Array.Storable -- .Internals -- (getNumElements,unsafeRead)
import Graphics.UI.Gtk.Display.Image
import Graphics.UI.Gtk.Gdk.Pixbuf
import Graphics.UI.Gtk.Gdk.Screen (screenGetWidth,screenGetHeight)

import Graphics.UI.Gtk
import System.Environment
-- import Data.Text () as T

initilize :: IO ()
initilize = 
    do
        _ <- initGUI
        return ()

getScreen :: IO (Matrix Word32)
getScreen = do
    Just screen <- screenGetDefault
    window <- screenGetRootWindow screen
    size   <- drawableGetSize window
    origin <- drawWindowGetOrigin window
    Just pxbuf <-
        pixbufGetFromDrawable
            window
            ((uncurry . uncurry Rectangle) origin size)
    pxbuf1 <- pixbufAddAlpha pxbuf Nothing 
    image  <- pixbufGetPixels pxbuf1
    list   <-  getElems image
    width  <- screenGetWidth screen
    height <- screenGetHeight screen
    return $ transpose $ fromList height width   list

getScreenSize :: IO (Int,Int)
getScreenSize = 
    do
        Just screen <- screenGetDefault
        width  <- screenGetWidth screen
        height <- screenGetHeight screen
        return (width,height)

toOctets :: Word32 -> (Word8,Word8,Word8,Word8)
toOctets w =
    ( 
        fromIntegral w,
        fromIntegral (w `shiftR` 8), 
        fromIntegral (w `shiftR` 16),
        fromIntegral (w `shiftR` 24) 
    )


saveScreen :: String -> IO ()
saveScreen x =
    let
        fileName :: String
        fileName =  (Prelude.filter (/=' ') x)
                    ++".png"
    in
    let
        helper :: Matrix Word32 -> Int -> Int -> PixelRGB8
        helper m x y =
            let
                (r,g,b,a) = toOctets $ getElem (x+1) (y+1) m
            in
                PixelRGB8 r g b
    in
        do
            (width,height) <- getScreenSize
            screen <- getScreen
            let image = generateImage (helper screen) width height 
            savePngImage fileName $ ImageRGB8 image 

