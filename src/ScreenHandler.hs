module ScreenHandler (initilize,saveScreen) where
{-# LANGUAGE OverloadedStrings #-}

-- import Graphics.Gloss.Interface.Environment (getScreenSize)
-- import Graphics.Rendering.OpenGL (readPixels,Position(..),Size(..),PixelData(..),PixelFormat(..),DataType(..))
-- import Graphics.UI.GLUT hiding (Matrix(..))-- (getArgsAndInitialize)
import Data.Matrix
import Codec.Picture
import Data.Word
import Data.Bits
import Foreign


display :: DisplayCallback
display = do
  clear [ ColorBuffer ]
  flush

initilize :: IO ()
initilize = 
    do 
        (_progName, _args) <- getArgsAndInitialize
        print 1
        _window <- createWindow "touhouML"
        print 2
        displayCallback $= display
        print "did init\n"
        -- return ()

readPixelArray :: Int -> Int -> Int -> Int -> IO [Word32]
readPixelArray x y w h = do
    let arraySize = w * h
    array <- mallocForeignPtrArray arraySize :: IO (ForeignPtr Word32)
    withForeignPtr array $ \ptr -> do
        -- ptr :: Ptr Word32
        -- fromIntegral is needed because Position and Size store GLints not Ints
        let position = Position (fromIntegral x) (fromIntegral y)
        let size = Size (fromIntegral w) (fromIntegral h)
        readPixels position size $ PixelData RGBA UnsignedInt ptr
        w32List <- peekArray arraySize ptr
        return $ w32List

toOctets :: Word32 -> (Word8,Word8,Word8,Word8)
toOctets w =( fromIntegral (w `shiftR` 24), fromIntegral (w `shiftR` 16), fromIntegral (w `shiftR` 8), fromIntegral w)
    


saveScreen :: String -> IO ()
saveScreen x =
    let
        fileName :: String
        fileName =  (Prelude.filter (/=' ') x)
                    ++".png"
    in
    let
        helper :: Matrix Word32 -> Int -> Int -> Pixel32
        helper m x y =
            let
                color = getElem (x+1) (y+1) m
            in
                (color :: Pixel32)
    in
        do
            (width,height) <- getScreenSize
            screen <- getScreen
            let image = generateImage (helper screen) height width 
            savePngImage fileName $ ImageY32 image 


getScreen :: IO (Matrix Word32)
getScreen = 
    do 
        (width,height) <- getScreenSize
        pixelList <- readPixelArray 0 0 width height
        return $ (height `fromList` width) pixelList




-- getScreenVector :: IO (Vector Word8)
-- getScreenVector =
--     do 
--         screen <- getScreen
--         pixels <- pixbufGetPixels screen
--         return $ (unsafeCastGObject . toGObject $ screen)
