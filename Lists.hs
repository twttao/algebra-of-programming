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

-- convert between two lists
convert:: Listl a -> Listr a
convert Nill = Nilr
convert (Snoc al a) = snocr (convert al) a where
    snocr:: Listr a -> a -> Listr a
    snocr Nilr a = Cons a Nilr
    snocr (Cons a' al) a = Cons a' (snocr al a)

-- concat
(+++):: Listl a -> Listl a -> Listl a
(+++) al Nill = al
(+++) al (Snoc al' a') = Snoc (al +++ al') a'

-- map
listR:: (a -> b) -> Listr a -> Listr b
listR f Nilr = Nilr
listR f (Cons a al) = Cons (f a) (listR f al)

-- fold / reduce
foldR:: b -> (a -> b -> b) -> Listr a -> b
foldR c h Nilr = c      -- c replaces Nilr
foldR c h (Cons b bl) = h b (foldR c h bl)      -- h replaces Cons

foldL:: b -> (b -> a -> b) -> Listl a -> b
foldL c h Nill = c      -- c replaces Nill
foldL c h (Snoc bl b) = h (foldL c h bl) b      -- h replaces Snoc

-- use fold to define concatenation
catl:: Listl a -> Listl a -> Listl a
catl la = foldL la Snoc

catR:: Listr a -> Listr a -> Listr a
catR la = \la2 -> foldR la2 Cons la

concatR:: Listr (Listr a) -> Listr a
concatR = foldR Nilr catR

-- McCarthy conditional
cond:: (a -> Bool) -> (a -> b) -> (a -> b) -> a -> b
cond p f g a = if (p a) then f a else g a

-- filter
filterR:: (a -> Bool) -> Listr a -> Listr a
filterR p = concatR.(listR (cond p wrap nilp)) where
    wrap:: a -> Listr a
    wrap a = Cons a Nilr
    nilp:: a -> Listr a
    nilp _ = Nilr

filterR':: (a -> Bool) -> Listr a -> Listr a
filterR' p = foldR Nilr (\a al -> if (p a) then (Cons a al) else al)

-- non-empty lists
data Listrp a = Wrp a | Consp a (Listrp a)
data Listlp a = Wlp a | Snocp (Listlp a) a

instance (Show a) => Show (Listrp a) where
    show (Wrp a) = "Wrp " ++ show a
    show (Consp a al) = show a ++ "," ++ show al
instance (Show a) => Show (Listlp a) where
    show (Wlp a) = "Wlp " ++ show a
    show (Snocp al a) = show al ++ "," ++ show a

-- folds
foldrp:: (a -> b) -> (a -> b -> b) -> Listrp a -> b
foldrp f g (Wrp a) = f a    -- f replaces Wrp
foldrp f g (Consp a al) = g a (foldrp f g al)       -- g replaces Consp

headp:: Listrp a -> a
headp = foldrp id (\a _ -> a)
