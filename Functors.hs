module Functors where

-- Functors: functor is homomorphism between categories, F: A <- B
-- two mappings: objects to objects; arrows to arrows
-- properties:
-- 1. F f: F A <- F B  if  f: A <- B
-- 2.(preservation of identity) F(id_A) = id_{F A}  and  F(f.g) = (F f).(F g)
-- ex.:
-- 1.(identity functor) id: C <- C
-- 2. K_A: A <- B
--    each object in B to one and same object in A
--    each arrow of B to id_A
-- 3.(self-pairing functor) _^2: Fun <- Fun
--   A^2 = {(a, b) | a \in A, b \in A}
--   f^2(a,b) = (f a, f b)
-- 4.(product functor) X: Fun <- Fun X Fun
--   A X B = cartesian product of A, B
--   (f X g)(a, b) = (f a, g b)
-- 5.(list map) listr: Fun <- Fun
--   each set A to cons-lists over A
--   each f to listr f that applies to every element in the list
-- 6.(powerset) P: Fun <- Fun
--   P A = {x | x\subseteq A}
--   similar to listr except it is a set instead of a list

