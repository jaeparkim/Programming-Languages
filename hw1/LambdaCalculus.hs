import PA1Helper

startEval :: Lexp -> Lexp
startEval lexp = etaConvert (betaReduce lexp)

etaConvert :: Lexp -> Lexp
etaConvert x@(Atom _) = x
etaConvert expr@(Apply expr1 expr2) = Apply (etaConvert expr1) (etaConvert expr2)
etaConvert lexp@(Lambda x (Apply f y))
    | (not (x `elem` (findFreeVariables f))) && (x == y) = etaConvert f -- reapply etaConvert on f: safe?
    | otherwise = lexp
etaConvert (Lambda x e) =  (Lambda x (etaConvert e))

betaReduce :: Lexp -> Lexp
betaReduce v@(Atom _) = v
betaReduce lexp@(Lambda (Atom x) expr) = Lambda (Atom x) (betaReduce expr)
betaReduce lexp@(Apply expr1 expr2) =
    let
    expr5 = betaReduce expr1
    expr3 = betaReduce expr2
    expr4 = alphaRename expr5 ((findAllVariables expr5) ++ findFreeVariables expr3)
    in
    case expr4 of (Lambda (Atom x) expr) -> betaReduce (replaceAll (Atom x) expr3 expr)
                  otherwise -> (Apply expr4 expr3)

alphaRename :: Lexp -> [Lexp] -> Lexp
alphaRename v@(Atom _) _ = v
alphaRename lexp@(Apply expr1 expr2) _ = (Apply expr1 expr2)
alphaRename lexp@(Lambda x expr) avoidList =
    let
    x1 = find x avoidList
    in
    Lambda x1 (alphaRename (replaceAll x x1 expr) (avoidList ++ [x1]))

replaceAll :: Lexp -> Lexp -> Lexp -> Lexp
replaceAll (Atom arg) value expr@(Atom e)
    | e == arg = value
    | otherwise = Atom e
replaceAll (Atom arg) value expr@(Lambda (Atom x) e) = Lambda (Atom x) (replaceAll (Atom arg) value e)
replaceAll (Atom arg) value expr@(Apply e1 e2) = Apply (replaceAll (Atom arg) value e1) (replaceAll (Atom arg) value e2)

find :: Lexp -> [Lexp] -> Lexp
find (Atom x) list
    | not ((Atom x) `elem` list) = (Atom x)
    | otherwise =  find (Atom (x ++ "'")) list

findFreeVariables :: Lexp -> [Lexp]
findFreeVariables x@(Atom _) = [x]
findFreeVariables lexp@(Lambda x expr) = (findFreeVariables expr) `minus` x
findFreeVariables lexp@(Apply expr1 expr2) = (findFreeVariables expr1) ++ (findFreeVariables expr2)

findAllVariables :: Lexp -> [Lexp]
findAllVariables v@(Atom _) = [v]
findAllVariables lexp@(Lambda x expr) = [x] ++ (findAllVariables expr)
findAllVariables lexp@(Apply expr1 expr2) = (findAllVariables expr1) ++ (findAllVariables expr2)

foldr' :: (a->b->b) -> b -> [a] -> b
foldr' _ u []    = u
foldr' f u (h:t) = f h (foldr' f u t)

filter' :: (a-> Bool) -> [a] -> [a]
filter' p = foldr'
            (\h t ->  if p h
                      then h:t
                      else t) []


remove' :: (Eq a) => a -> [a] -> [a]
remove' x = filter' (/=x)

minus :: (Eq a) => [a] -> a -> [a]
minus [] _ = []
minus list@(listHead:listTail) x
  | x == listHead = (minus listTail x)
  | otherwise = (listHead:(minus listTail x))

main = do
    putStrLn "Please enter a filename containing lambda expressions:"
    fileName <- getLine
    -- id' simply returns its input, so runProgram will result
    -- in printing each lambda expression twice. 
    putStrLn "\nThe reduction results are:\n(Variable renaming will be in the form as x', x'', y', y'', etc.)\n"
    runProgram fileName startEval

