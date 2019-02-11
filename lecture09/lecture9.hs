{-# OPTIONS_GHC -Wall #-}

module Lecture9 where

data Nat = Zero | Succ Nat

nat2int :: Nat -> Int
nat2int = error "nat2int: not yet defined"

int2nat :: Int -> Nat
int2nat = error "int2nat: not yet defined"

addCheat :: Nat -> Nat -> Nat
addCheat m n = int2nat (nat2int m + nat2int n)

add :: Nat -> Nat -> Nat
add = error "add: not yet defined"

data Exp = Val Int
         | Add Exp Exp
         | Mul Exp Exp

-- The representation of the expression tree from lecture
e :: Exp
e = Add (Val 1) (Mul (Val 2) (Val 3))

-- Return the "size" of the expression, which is the number of constants it
-- contains.
size :: Exp -> Int
size = error "size: not yet defined"

-- Evaluate an expression
eval :: Exp -> Int
eval = error "eval: not yet defined"

-- Define a data type for binary trees
-- data Tree a

-- The representation of the tree from lecture
-- t :: Tree Int

-- Decide if a given value occurs in a binary tree
occurs = error "occurs: not yet defined"

-- Flatten a tree into a list of its values
flatten = error "flatten: not yet defined"

-- Search for a value in an *ordered* tree (values in left subtree are <, values
-- in right subtree are >).
search = error "search: not yet defined"
