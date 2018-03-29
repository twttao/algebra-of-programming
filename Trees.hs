module Trees where

-- tree data structure
data Tree a = Tip a | Bin (Tree a) (Tree a)

foldt:: (a -> b) -> (b -> b -> b) -> Tree a -> b
foldt f g (Tip a) = f a
foldt f g (Bin x y) = g (foldt f g x) (foldt f g y)

-- map
tree:: (a -> b) -> Tree a -> Tree b
tree f = foldt (\x -> Tip (f x)) Bin
