module PointwiseAndPointFree where

import Lists

-- filterR identity
filterR'':: (a -> Bool) -> Listr a -> Listr a
filterR'' p = getLeft.removeFalse.zip.(genTrueFalse p) where
    genTrueFalse:: (a -> Bool) -> Listr a -> (Listr a, Listr Bool)
    genTrueFalse p = pair id (listR p) where
        pair:: (a -> b) -> (a -> c) -> a -> (b, c)
        pair f g a = (f a, g a)
    removeFalse:: Listr (a, Bool) -> Listr (a, Bool)
    removeFalse = filterR outr where
        outr:: (a, b) -> b
        outr (_, b) = b
    getLeft:: Listr (a, b) -> Listr a
    getLeft = listR outl where
        outl:: (a, b) -> a
        outl (a, _) = a
    zip:: (Listr a, Listr b) -> Listr (a, b)
    zip (Nilr, _) = Nilr
    zip (_, Nilr) = Nilr
    zip (Cons a al, Cons b bl) = Cons (a, b) (zip (al, bl))

-- some other useful(and obvious) identities
-- outl.(pair f g) = f                              (1.1) do two pick left is pick left
-- outr.(pair f g) = g                              (1.2) do two pick right is pick right
-- nilp.f = nilp                                    (1.3) do then empty is empty
-- (listR f).nilp = nilp                            (1.4) map empty is empty
-- (listR f).wrap = wrap.f                          (1.5) map singleton is do then wrap
-- (listR f).concat = concat.(listR (listR f))      (1.6) concat then map is map then concat
-- zip.pair(listR f, listR g) = listR (pair f g)    (1.7) map two then zip is map do two
-- listR (f.g) = (listR f).(listR g)                (1.8) map do(s) is sequentially map do
-- listR id = id                                    (1.9) map same is same
-- (cond p f g).h = cond (p.h) (f.h) (g.h)          (1.10) cond is distributive
-- h.(cond p f g) = cond p (h,f) (h.g)              (1.11) cond is distributive 2
-- f.id = f                                         (1.12) identity
-- id.f = f                                         (1.13) identity

-- proof that filterR'' is correct
-- removeFalse = filterR outr
--              {definition of (filterR p)}
--             = concatR.(listR (cond outr wrap nilp))
-- getLeft.removeFalse = (listR outl).concatR.(listR (cond outr wrap nilp))
--                      {(1.6)}
--                     = concatR.(listR (listR outl)).(listR (cond outr wrap nilp))
--                      {(1.8)}
--                     = concatR.(listR (listR outl).(cond outr wrap nilp))
--                      {(1.11)}
--                     = concatR.(listR (cond outr (listR outl).wrap (listR outl).nilp))
--                      {(1.5), (1.4)}
--                     = concatR.(listR (cond outr wrap.outl nilp))
--
-- zip.(genTrueFalse p) = zip.(pair id (listR p))
--                      {1.9}
--                      = zip.(pair (listR id) (listR p))
--                      {(1.7)}
--                      = listR (pair id p)
--
-- filterR'' p = getLeft.removeFalse.zip.(genTrueFalse p)
--             = concatR.(listR (cond outr wrap.outl nilp)).(listR (pair id p))
--              {(1.8)}
--             = concatR.(listR (cond outr wrap.outl nilp).(pair id p))
--              {(1.10)}
--             = concatR.(listR (cond outr.(pair id p) wrap.outl.(pair id p) nilp.(pair id p)))
--              {(1.2), (1.1), (1.3), (1.12)}
--             = concatR.(listR (cond p wrap nilp))
--              {definition of (filterR p)}
--             = filterR p
