{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_touhouML (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/dagon/.cabal/bin"
libdir     = "/home/dagon/.cabal/lib/x86_64-linux-ghc-8.6.5/touhouML-0.1.0.0-inplace-touhouML"
dynlibdir  = "/home/dagon/.cabal/lib/x86_64-linux-ghc-8.6.5"
datadir    = "/home/dagon/.cabal/share/x86_64-linux-ghc-8.6.5/touhouML-0.1.0.0"
libexecdir = "/home/dagon/.cabal/libexec/x86_64-linux-ghc-8.6.5/touhouML-0.1.0.0"
sysconfdir = "/home/dagon/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "touhouML_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "touhouML_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "touhouML_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "touhouML_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "touhouML_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "touhouML_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
