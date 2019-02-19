module Compiler where

data Exp = Val Int
         | Add Exp Exp
  deriving(Eq, Ord, Show, Read)

-- | The value of an expression
eval :: Exp -> Int
eval (Val n)   = n
eval (Add x y) = eval x + eval y

type Stack = [Int]

type Code = [Op]

data Op = PUSH Int | ADD
  deriving (Eq, Ord, Show, Read)

exec :: Code -> Stack -> Stack
exec []           s       = s
exec (PUSH n : c) s       = exec c (n:s)
exec (ADD : c)    (m:n:s) = exec c (n+m:s)

comp :: Exp -> Code
comp (Val n)   = [PUSH n]
comp (Add x y) = comp x ++ comp y ++ [ADD]

comp' :: Exp -> Code -> Code
comp' (Val n)   c = PUSH n : c
comp' (Add x y) c = comp' x (comp' y (ADD : c))

e :: Exp
e = Add (Add (Val 2) (Val 3)) (Val 4)
