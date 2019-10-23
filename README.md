# Keller

This is the code we used to prove Keller's conjecture in dimension 7. Please see our [paper](https://arxiv.org/abs/1910.03740) to understand the theoretical justifications.

## Getting started

To clone the repo, run

`git clone --recursive https://github.com/jbrakensiek/Keller.git`

Run `make all` to get the essential files. You should also configure [CaDiCaL](https://github.com/arminbiere/cadical) and [DRAT-trim](https://github.com/marijnheule/drat-trim) and [ACL2](https://www.cs.utexas.edu/users/moore/acl2/).

## Codebase overview

### Scripts

#### `jobs3.py` 

Creates a list of jobs of the form `X Y 0`, where X ranges from 0 to 66 (the list of tilings for S=3) and Y ranges from 1 to 861 (inequivalent 4x2 patterns). These correspond the cases analyzed for G_{7,3}.

`python jobs3.py > jobs3.txt`

#### `jobs4.py`

Creates a list of jobs of the form `X Y 0`, where X ranges from 0 to 87 (the list of tilings for S=4) and Y ranges from 1 to 1326 (inequivalent 4x2 patterns). These correspond the cases analyzed for G_{7,4}.

`python jobs4.py > jobs4.txt`

#### `jobs6.py`

Creates a list of jobs of the form `X Y 0`, where X ranges from 0 to 89 (the list of tilings for S=4) and Y ranges from 1 to 1378 (inequivalent 4x2 patterns). These correspond the cases analyzed for G_{7,4}.

`python jobs6.py > jobs6.txt`

#### `test3.sh`

Solves a formula with s = 3 and produces a proof of unsatisfiability (in case of UNSAT). This proof is verified using the DRAT-trim proof checker. The $WORK parameter specifies the directory in which the logs files are stored. 

`bash test3.sh X Y 0`

#### `test4.sh`

Solves a formula with s = 4 and produces a proof of unsatisfiability (in case of UNSAT). This proof is verified using the DRAT-trim proof checker. The $WORK parameter specifies the directory in which the logs files are stored.

`bash test4.sh X Y 0`

#### `test7.sh`

Solves a formula with s = 7 and produces a proof of unsatisfiability (in case of UNSAT). This proof is verified using the DRAT-trim proof checker. The $WORK parameter specifies the directory in which the logs files are stored.

`bash test7.sh X Y 0`

#### `loop-test.sh`

This script runs multiple test3.sh or test4.sh runs (depending on $4) on a single CPU. Its first three arguments are 1) a jobs file, 2) the starting line in that file and 3) a number of other cores working on the same files. The number of lines that are skipped equals the number of other cores.

#### `par-loop-test.sh`

This script launches multiples loop-test.sh calls with the same jobs files, the same number of other cores, but with a different starting line for each core.

### C

#### `six/cnfgen6.c`

Generates the CNF files

`make cnfgen6`

`echo "N S T cube1 ... cubeT" | ./cnfgen6`

`cubei` is N space-separated numbers in {-1, 0, 1, ... 2S-1}, where `-1` denotes an undetermined value in the set `{0, 1, ... S-1}`. Note that to keep things nonnegative, all coordinates in the paper are translated by S-1.

The output is a CNF file which can be directly read by CaDiCaL.

#### `six/cubecover6.c`

Generates the 67 inequivalent coverings for S=3

Generates the 88 inequivalent coverings for S=4

Generates the 90 inequivalent coverings for S=6

`make cubecover6`

#### `symbreak3.c` 

Generates the list of cubes corresponding to the case "X Y 0" as generated by `jobs3.py`.

`make symbreak3`
`echo "X Y 0" | ./symbreak3`

#### `symbreak4.c`

Has the same function as `symbreak3.c`, but for S=4.

`make symbreak4`
`echo "X Y 0" | ./symbreak4`

#### `six/symbreak6.c`

Has the same function as `symbreak3.c`, but for S=6.

`make symbreak6`
`echo "X Y 0" | ./symbreak6`

#### `six/table2tex6.c`

Creates Tables 1-3 in the paper.

`make table2tex`  
`echo "S" | ./cubecover 2> /dev/null | ./table2tex`

where S=3 for Table 1 and S=4 for Table 2 and S=6 for Table 3

### Fortran

Much of the C code is double-checked in Fortran. Recommended usage is

`f77 filename.f`  
`./a.out`

Brief descriptions:

#### `theorem1.f` and `theorem3.f`

Verifies Theorem 2.1 in the paper for s=3 and s=4, respectively.

#### `theorem2a.f` and `theorem2b.f`

For S=3. The former generates the 455 non-identical coverings of \[1/2,7/2)^3 that contain the cube (3,3,3). The latter distills the 455 non-identical coverings into 67 non-equivalent coverings using coordinate permutation and swapping 1 and 4.

#### `theorem4a.f` and `theorem4b.f`

For S=4. The former generates the 1819 non-identical coverings of \[1,5)^3 that contain the cube (4,4,4). The latter distills the 1819 non-identical coverings into 88 non-equivalent coverings using coordinate permutation and permutations in columns
that fix {0,3,4,7}.

#### `3cov.txt`, `3covtest.f` and `3covtest2.f`

`3cov.txt` contains the 455 non-identical covers that `theorem2a.f` generates + `cubecover.c`'s 67 inequivalent covers for S=3.

`3covtest.f` checks all 522 covers for equivalence and gets a total of 67 inequivalent covers.

`3covtest2.f` checks `cubecover.c`'s 67 covers and gets a total of 67 inequivalent covers.

#### `4cov.txt`, `4covtest.f` and `4covtest2.f`

`4cov.txt` contains the 1819 non-identical covers that `theorem4a.f` generates + `cubecover.c`'s 88 inequivalent covers for S=4.

`4covtest.f` checks all 1907 covers for equivalence and gets a total of 88 inequivalent covers.

`4covtest2.f` checks `cubecover.c`'s 88 covers and gets a total of 88 inequivalent covers.

## Attribution

You are welcome to adapt this codebase for other projects. If you do so, please cite

Joshua Brakensiek, Marijn Heule, John Mackey. _The Resolution of Keller's Conjecture._ Manuscript.

## Acknowledgments

The authors acknowledge the [Texas Advanced Computing Center](http://www.tacc.utexas.edu) (TACC)  at The University of Texas at Austin for providing HPC resources that have contributed to the research results reported within this paper. We thank Andrzej Kisielewicz for valuable comments on an earlier version of the manuscript. We thank William Cooperman for helpful discussions on a previous attempt at programming simulations to study the half-integral case. We thank Xinyu Wu for making this collaboration possible.
