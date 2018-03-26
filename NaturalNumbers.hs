module NaturalNumbers where

foldN:: a -> (a -> a) -> Int -> a
foldN c h 0 = c     -- c replaces Z
foldN c h n = h (foldN c h (n - 1))   -- h replaces S
