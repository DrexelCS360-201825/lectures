module Examples where

import Prelude hiding (Maybe(..), Either(..), mapM, filterM)

import Control.Monad (ap)
import Data.Complex
import System.Random

-- map :: (a -> b) -> [a] -> [b]

--
-- Functors
--
data Maybe a = Nothing
             | Just a
  deriving (Eq, Ord, Show, Read)

data Tree a = Leaf a
            | Node (Tree a) (Tree a)
  deriving (Eq, Ord, Show, Read)

{-
instance Functor [] where
    fmap = undefined
-}

instance Functor Maybe where
    fmap = undefined

instance Functor Tree where
    fmap = undefined

data Either a b = Left a
                | Right b
  deriving (Eq, Ord, Show, Read)

-- instance Functor Either... where

--
-- Applicatives
--

instance Applicative Maybe where
    -- pure :: a -> Maybe a
    pure = undefined

    -- (<*>) :: Maybe (a -> b) -> Maybe a -> Maybe b
    (<*>) = undefined

{-
instance Applicative [] where
    -- pure :: a -> [x]
    pure x = [x]

    -- (<*>) :: [a -> b] -> [a] -> [b]
    gs <*> xs = [g x | g <- gs, x <- xs]
-}

--
-- Abstracting over computation
--

instance Monad Maybe where
  -- return :: a -> Maybe a
  return = undefined

  -- (>>=) :: Maybe a -> (a -> Maybe b) -> Maybe b
  (>>=) = undefined

--
-- Interpreter
--
data Exp = Val Int | Div Exp Exp

eval :: Exp -> Int
eval (Val n)   = n
eval (Div x y) = eval x `div` eval y

safediv :: Int -> Int -> Maybe Int
safediv _ 0 = Nothing
safediv n m = Just (n `div` m)

eval' :: Exp -> Maybe Int
eval' (Val n)   = Just n
eval' (Div x y) = case eval' x of
                    Nothing -> Nothing
                    Just n  -> case eval' y of
                                 Nothing -> Nothing
                                 Just m  -> safediv n m

eval'' :: Exp -> Maybe Int
eval'' (Val n)   = Just n
eval'' (Div x y) = eval'' x >>= \n ->
                   eval'' y >>= \m ->
                   safediv n m

--
-- Functions that use random numbers
--

newtype Randomized a = R { unR :: StdGen -> (a, StdGen) }

instance Functor Randomized where
    -- fmap :: (a -> b) -> R a -> R b
    fmap f g = R $ \s ->
        let (x, s') = unR g s
        in
          (f x, s')

instance Applicative Randomized where
    pure x = R $ \s -> (x, s)

    mf <*> mx = R $ \s -> let (f, s')  = unR mf s
                              (x, s'') = unR mx s'
                          in
                            (f x, s'')

instance Monad Randomized where
    mx >>= f = R $ \s -> let (y, s') = unR mx s
                         in
                           unR (f y) s'

--
-- Generic functions
--

mapM :: Monad m => (a -> m b) -> [a] -> m [b]
mapM _ []     = return []
mapM f (x:xs) = do y  <- f x
                   ys <- mapM f xs
                   return (y:ys)

filterM :: Monad m => (a -> m Bool) -> [a] -> m [a]
filterM = undefined
