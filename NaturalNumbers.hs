module NaturalNumbers where

-- foldN = homomorphism over Nat
foldN:: a -> (a -> a) -> Int -> a
foldN c h 0 = c     -- c replaces Z
foldN c h n = h (foldN c h (n - 1))   -- h replaces S

plus:: Int -> Int -> Int
plus m n = foldN m (+1) n

mult:: Int -> Int -> Int
mult m n = foldN 0 (plus n) m

expn:: Int -> Int -> Int
expn m n = foldN 1 (mult m) n
