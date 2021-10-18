import PA1Helper
import System.Environment


-- Kicks off the Lambda Calculus Reduction by using Beta Reduction recursively followed by
-- Eta Conversion recursively with Alpha Renaming being done as needed
startEval :: Lexp -> Lexp
startEval lexp = etaConvert (betaReduce lexp)


-- Performs Alpha Renaming of a Lambda Calculus Expression by pattern matching
--    For variables no alpha renaming is done
--    For applications no renaming is done
--    For abstraction alpha renaming is done by the definition of alpha renaming
alphaRename :: Lexp -> [Lexp] -> Lexp
alphaRename v@(Atom _) _ = v
alphaRename lexp@(Apply expr1 expr2) _ = (Apply expr1 expr2)
alphaRename lexp@(Lambda x expr) avoidList =
    let
    x1 = find (Atom x) avoidList
    in
    Lambda (show x1) (alphaRename (replaceAll (Atom x) x1 expr) (avoidList ++ [x1]))


-- Performs Beta Reduction on a Lambda Calculus Expression by pattern matching
--    For variables no beta reduction is done
--    For abstractions you beta reduce second argument
--    For applications you beta reduce both arguments and check for alpha renaming
betaReduce :: Lexp -> Lexp
betaReduce v@(Atom _) = v
betaReduce lexp@(Lambda x expr) = Lambda x (betaReduce expr)
betaReduce lexp@(Apply expr1 expr2) =
    let
    expr5 = betaReduce expr1
    expr3 = betaReduce expr2
    expr4 = alphaRename expr5 ((findAllVariables expr5) ++ findFreeVariables expr3)
    in
    case expr4 of (Lambda x expr) -> betaReduce (replaceAll (Atom x) expr3 expr)
                  otherwise -> (Apply expr4 expr3)


-- Performs Eta conversion on a Lambda Calculus Expression by pattern matching
--    For variables no eta conversion is done
--    For application you eta convert both the first and second LC expressions
--    For abstraction of application you convert using the defintion of Eta conversion
etaConvert :: Lexp -> Lexp
etaConvert x@(Atom _) = x
etaConvert expr@(Apply expr1 expr2) = Apply (etaConvert expr1) (etaConvert expr2)
etaConvert lexp@(Lambda x (Apply f y))
    | (not (x `elem` (convert (findFreeVariables f)))) && (x == (show y)) = etaConvert f 
    | otherwise = lexp
etaConvert (Lambda x e) =  (Lambda x (etaConvert e))


-- Utility Function
--    replaces all occurences of 'arg' with 'value' in expression 'e'
replaceAll :: Lexp -> Lexp -> Lexp -> Lexp
replaceAll (Atom arg) value expr@(Atom e)
    | e == arg = value
    | otherwise = Atom e
replaceAll (Atom arg) value expr@(Lambda x e) = Lambda x (replaceAll (Atom arg) value e)
replaceAll (Atom arg) value expr@(Apply e1 e2) = Apply (replaceAll (Atom arg) value e1) (replaceAll (Atom arg) value e2)

-- Utility Function
--    checks if alpha renaming will rename to an already used variable name
--    and avoids double calls
find :: Lexp -> [Lexp] -> Lexp
find (Atom x) list
    | not ((Atom x) `elem` list) = (Atom x)
    | otherwise =  find (Atom (x ++ "'")) list

-- Utility Function
--    recursively converts a list of Lambda Expressions into a list of Strings
--    required for type-matching purposes
convert :: [Lexp] -> [String]
convert [] = []
convert [x] = [show x]
convert (h:t) = ((show h) : convert t)

-- Utility Function
--    recurses through a Lambda Calculus Expression and finds all the free
--    variables that we don't want to capture
findFreeVariables :: Lexp -> [Lexp]
findFreeVariables x@(Atom _) = [x]
findFreeVariables lexp@(Lambda x expr) = (findFreeVariables expr) `removeFromList` (Atom x)
findFreeVariables lexp@(Apply expr1 expr2) = (findFreeVariables expr1) ++ (findFreeVariables expr2)

-- Utility Function
--    recurses through a Lambda Calculus Expression and finds all the variables
--    to be matched with the results from findFreeVariables to determine which
--    free variables might be captured
findAllVariables :: Lexp -> [Lexp]
findAllVariables v@(Atom _) = [v]
findAllVariables lexp@(Lambda x expr) = [(Atom x)] ++ (findAllVariables expr)
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


-- Utility Function
--     Recurses down a list and removes all occurences of an item from the list
removeFromList :: (Eq a) => [a] -> a -> [a]
removeFromList [] _ = []
removeFromList list@(head:tail) x
  | x == head = (removeFromList tail x)
  | otherwise = (head:(removeFromList tail x))


-- Utility Function
-- Grabs the first item from the list
firstItem :: [a] -> a
firstItem [x] = x
firstItem (head:_) = head


main = do
    args <- getArgs
    let filename = firstItem args
    let outfile = "output.lambda"
    runProgram filename outfile startEval

