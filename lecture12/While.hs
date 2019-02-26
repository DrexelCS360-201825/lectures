{-# OPTIONS_GHC -Wall #-}

import Prelude hiding (lookup)

--
-- While language
--

type Z = Integer

type Var = String

data Aexp = Const Z | Var Var
          | Add Aexp Aexp | Sub Aexp Aexp | Mul Aexp Aexp
  deriving (Show)

data Bexp = BTrue | BFalse
          | Eq Aexp Aexp | Le Aexp Aexp
          | Not Bexp | And Bexp Bexp
  deriving (Show)

data Stm  = Assign Var Aexp | Skip | Seq Stm Stm
          | If Bexp Stm Stm
          | While Bexp Stm
  deriving (Show)
