#!/bin/bash

DIR=~/Keller
#OUT=$DIR/out
OUT=/tmp

echo "TEST: $1 $2 $3"
echo "$1 $2 $3" | $DIR/symbreak4 | $DIR/cnfgen > $OUT/$1_$2_$3_four.cnf 2> $OUT/$1_$2_$3_four_gen.log
~/cadical/build/cadical --unsat $OUT/$1_$2_$3_four.cnf $OUT/$1_$2_$3_four.drat &> $OUT/$1_$2_$3_four_solve.log
#~/cadical/build/cadical -t 900 --unsat $OUT/$1_$2_$3_four.cnf $OUT/$1_$2_$3_four.drat &> $OUT/$1_$2_$3_four_solve.log
~/drat-trim/drat-trim $OUT/$1_$2_$3_four.cnf $OUT/$1_$2_$3_four.drat -c $OUT/$1_$2_$3_four_core.cnf &> $OUT/$1_$2_$3_four_check.log
cat $OUT/$1_$2_$3_four_solve.log | awk '/SATIS/ {printf "c %i %i %i %s ", '$1', '$2', '$3', $2} /total real/ {print $7}'
cat $OUT/$1_$2_$3_four_solve.log | awk '/UNK/ {printf "c %i %i %i %s ", '$1', '$2', '$3', $2} /total real/ {print $7}'
cat $OUT/$1_$2_$3_four_check.log | grep "VERIFIED"
zip $WORK/log/Keller/$1_$2_$3_four.zip $OUT/$1_$2_$3_*.log
rm $OUT/$1_$2_$3_four*.*
