module NaturalTransformations where

-- Let F,G: C <- D be functors from category D to C.
-- A "transformation" is a set of arrows \phi_B: F d <- G d,
-- one for each object in D.
-- Each arrow in \phi is called a "component" of \phi.

-- A "natural transformation" is a transformation that satisfies
-- the diagram:
--
--                            h
--                    a <---------- b
--
--          |           in category D          |
--  --------|----------------------------------|-----------
--        F |           in category C          | G
--          v                 |                v
--    functor A images        |         functor G images
--                            |
--                          \phi_B
--                   F b <--------- G b
--                    |       |      |
--                F h |       |      | G h
--                    |       |      |
--                    v       |      v
--                   F a <--------- G a
--                          \phi_A
--                            |
--                            |
--                            |
--
-- That is, if (F h).\phi_B = \phi_A.(G h)
