module Machine where

data Exp = Val Int
         | Add Exp Exp
  deriving(Eq, Ord, Show, Read)

-- | The value of an expression
value :: Exp -> Int
value (Val n)   = n
value (Add x y) = value x + value y

-- | A control stack
type Cont = [Op]

-- | Operations in a control stack
data Op = EVAL Exp | ADD Int

-- | Evaluate an expression in the context of a control stack
eval :: Exp -> Cont -> Int
eval (Val n)   c = exec c n
eval (Add x y) c = eval x (EVAL y : c)

-- | Execute a control stack in the context of an integer argument
exec :: Cont -> Int -> Int
exec []           n = n
exec (EVAL y : c) n = eval y (ADD n : c)
exec (ADD n : c)  m = exec c (n+m)

-- | Use eval to evaluate an expression
value' :: Exp -> Int
value' e = eval e []
