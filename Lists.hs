module Lists where

data Listr a = Nilr | Cons a (Listr a)      -- right list
data Listl a = Nill | Snoc (Listl a) a      -- left list

-- show methods
instance (Show a) => Show (Listr a) where
    show Nilr = "Nilr"
    show (Cons a al) = show a ++ "," ++ show al
instance (Show a) => Show (Listl a) where
    show Nill = "Nill"
    show (Snoc al a) = show al ++ "," ++ show a
