# Lambda Calculus Interpreter w/ functional programming

https://www.cs.rpi.edu/academics/courses/fall21/csci4430/pa1/pa1.html

### Contributors
Roland Rao and Jae Park

### Features
1. Ability to Beta-reduce
2. Ability to Eta-reduce
3. Ability to Alpha-rename (x -> x0' -> x0'')
4. replaceAll
    * Replaces all instances of one variable in another in a LC Expression
5. find
    * Checks if alpha renaming will rename to an already used variable
    * Avoids double calls of alpha renaming
6. convert
    * Converts element wise a list of LC Expressions to a list of Strings
7. findFreeVariables
    * finds all free variables in a LC Expression
8. findAllVariables
    * finds all variables to be matched with findFreeVariables for alpha renaming purposes

### Bugs
* No bugs found as of _9/27/2021_
* Eta-reduce is not done correctly under certain unknown circumstances as of _10/11/2021_

### Run 
Haskell compiler version
```bash
$ ghc --version
The Glorious Glasgow Haskell Compilation System, version 8.10.7
```

Try running the run.sh script which contains this line
```bash
$ runghc main.hs input.lambda
```
This will generate an output file, output.lambda.

