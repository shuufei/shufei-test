module RLE where

import Data.List ( group )

-- | ラングレス圧縮
--
-- >>> rle ""
-- ""
-- >>> rle "A"
-- "A1"
-- >>> rle "AAABBCCCCAAA"
-- "A3B2C4A3"
--

rle :: String -> String
rle = concatMap (\s -> head s : show (length s)) . group
