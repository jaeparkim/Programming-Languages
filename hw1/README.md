### Contributors
Roland Rao and Jae Park

### Features
1. Ability to Beta Reduce
2. Ability to Eta Reduce
3. Ability to Alpha Rename (x -> x0' -> x0'')


### Bugs
1. Certain lambda calculus expressions with weird spacing don't get parsed correctly by the given PA1Helper and thus don't work with our lambda calculus interpreter.
 (\x.(\y.y x) (\z.x z)) (\y.y y)