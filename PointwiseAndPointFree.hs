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

