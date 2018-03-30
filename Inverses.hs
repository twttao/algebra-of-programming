module Inverses where

import Lists

unzip:: Listr (a, b) -> (Listr a, Listr b)
unzip = foldR nils conss where
    nils = (Nilr, Nilr)
    conss (a, b) (al, bl) = (Cons a al, Cons b bl)

zip:: (Listr a, Listr b) -> Listr (a, b)
zip (Nilr, Nilr) = Nilr
zip (Cons a al) (Cons b bl) = Cons (a, b) (zip al bl)

-- zip.unzip = id
