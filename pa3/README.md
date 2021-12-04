# Family Tree explorer and Microprocessor Constraint Language w/ logic programming

http://cs.rpi.edu/academics/courses/fall21/csci4430/pa3/pa3.pdf

SWI-Prolog version 7.6.4 for amd64

### Contributors
Jae Park and Roland Rao

### Features
#### part 1
1. Parses out the information of a family tree from the given text file
2. Using constraints & rules, find Siblings, first cousins, list ancestors, list descendants, etc

#### part 2
1. read in definitions of processors and constraints on microprocessor attributes (NLP)
2.  run a constraint computation to calculate how many of each processor should 
be placed on a common chip
3. return all possible combinations of different processor copnfigurations that satisfy the constraints

### Bugs (as of Nov 16, 2021)
1. No bugs found as of submission 12/4


### Run 

```bash
$ swipl -f part1_tester.pl -g main

$ swipl -f part2.pl -g main < procSpec1.txt
$ swipl -f part2.pl -g main < procSpec2.txt
```

### Notes

