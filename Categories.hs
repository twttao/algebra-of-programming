module Categories where

-- a category is a class of objects (ex. A, B, C) and a class of arrows (ex. f, g, h)

-- compositions of arrows are associative: f.(g.h) = (f.g).h

-- the identity law: forall f: A <- B, (id A).f = f = f.(id B)

-- category 'Fun' consists of sets and total functions
-- a total function is a triple (f, A, B); A is the range, and B is the domain

-- category 'Par' consists of sets and partial functions
-- 'Fun' is a subcategory of 'Par'

-- category 'Rel' consists of sets and relations
-- a relation is a triple (R, A, B); R is the subset of A X B
-- the composition of relation (R, A, B) and (S, B, C) is (T, A, C) if
-- aTc = exists b, aRb && bSc

-- combining categories C1 and C2 yields category C1 X C2 (the product cateogry of C1 and C2)
-- it consists of objects (C1, C2), where C1 is an object of C1, C2 is an object of C2
-- the arrows are (f, g), where f is an arrow in C1, g is an arrow in C2
-- composition of arrows is defined as (f, g).(h, k) = (f.h, g.k)
-- identity is ((id C1), (id C2))

-- m: A <- B is 'monic' if f = g <-> m.f = m.g (left-cancellable)
-- if m and n are monic, m.n is monic
-- * an equation compositing a monic function on both sides remains equal
-- in category Fun, m is monic if and only if m is injective

-- e: B <- C is 'epic' if f = g <-> f.e = g.e (right-cancellable)
-- if m and n are epic, m.n is epic
-- in category Fun, m is epic if and only if m is surjective

-- the opposite category of C is C^op; it is obtained by reversing all arrows in C
-- hence, f.g \in C^op <-> g.f \in C
-- (C^op)^op = C

-- S(C) is a statement about category C; S^op(C) = S(C^op) is a statement where all arrows are reversed
-- \forall C, S(C) <-> \forall C, S^op(C)
-- ex. epics are dual to monics

-- isomorphism: there exists an arrow i: A <- B, such that there exists an opposite arrow of j: B <- A
-- j.i = id_B, i.j = id_A
-- in Fun, an arrow is isomorphic iff. it is bijective
