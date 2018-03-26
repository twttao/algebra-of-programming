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

-- factorial
fact:: Int -> Int
fact n = snd (foldN (0, 1) f n) where
    f:: (Int, Int) -> (Int, Int)
    f (m, n) = (m + 1, (m + 1) * n)
-- (0, 1) -> (1, 1 * 1) -> (2, 2 * 1 * 1) -> (3, 3 * 2 * 1 * 1) -> ...
-- fact 0 ->   fact 1   ->     fact 2     ->        fact 3      -> ...

-- Fibonacci
fib:: Int -> Int
fib n = snd (foldN (0, 1) f n) where
    f:: (Int, Int) -> (Int, Int)
    f (m, n) = (n, m + n)
