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
    removeFalse = filterR'' outr where
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
-- zip.pair(listR f, listR g) = listR(pair f g)     (1.7) map two then zip is map do two
-- listR (f.g) = (listR f).(listR g)                (1.8) map do(s) is sequentially map do
-- listR id = id                                    (1.9) map same is same
-- (cond p f g).h = cond (p.h) (f.h) (g.h)          (1.10) cond is distributive
-- h.(cond p f g) = cond p (h,f) (h.g)              (1.11) cond is distributive 2
-- f.id = f                                         (1.12) identity
-- id.f = f                                         (1.13) identity
