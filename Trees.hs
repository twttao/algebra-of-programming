module Trees where

-- tree data structure
data Tree a = Tip a | Bin (Tree a) (Tree a)

foldt:: (a -> b) -> (b -> b -> b) -> Tree a -> b
foldt f g (Tip a) = f a
foldt f g (Bin x y) = g (foldt f g x) (foldt f g y)

-- map
tree:: (a -> b) -> Tree a -> Tree b
tree f = foldt (\x -> Tip (f x)) Bin

-- size and depth
size = foldt one (+) where one a = 1
depth = foldt zero (\x y -> succ (max x y)) where zero a = 0

-- forests?
-- data Tree' a = Fork a (Forest a)
-- data Forest a = Null | Grow (tree' a) (Forest a)
