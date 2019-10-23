#!/bin/bash

DIR=~/Keller-private
#DIR=`pwd`
OUT=/tmp
POST=four

echo "TEST: $1 $2 $3"
echo "$1 $2 $3" | $DIR/symbreak4 | $DIR/cnfgen6 > $OUT/$1_$2_$3_$POST.cnf 2> $OUT/$1_$2_$3_gen_$POST.log
~/cadical/build/cadical --unsat $OUT/$1_$2_$3_$POST.cnf $OUT/$1_$2_$3_$POST.drat &> $OUT/$1_$2_$3_solve_$POST.log
~/drat-trim/drat-trim $OUT/$1_$2_$3_$POST.cnf $OUT/$1_$2_$3_$POST.drat -L $OUT/$1_$2_$3_$POST.clrat -C -D &> $OUT/$1_$2_$3_check_$POST.log

# start ACL2 PART
 ~/acl2/books/projects/sat/lrat/cube/run.sh $OUT/$1_$2_$3_$POST.cnf $OUT/$1_$2_$3_$POST.clrat $OUT/copy$$.cnf >> $OUT/$1_$2_$3_check_$POST.log
 diff -b $OUT/$1_$2_$3_$POST.cnf $OUT/copy$$.cnf
 echo " "
 rm $OUT/copy$$.cnf
# end ACL2 PART

cat $OUT/$1_$2_$3_solve_$POST.log | awk '/SATIS/ {printf "c %i %i %i %s ", '$1', '$2', '$3', $2} /total real/ {print $7}'
cat $OUT/$1_$2_$3_solve_$POST.log | awk '/UNK/ {printf "c %i %i %i %s ", '$1', '$2', '$3', $2} /total real/ {print $7}'
cat $OUT/$1_$2_$3_check_$POST.log | grep "VERIFIED"
zip $WORK/log/Keller/$1_$2_$3_$POST.zip $OUT/$1_$2_$3_*.log
rm $OUT/$1_$2_$3_*_$POST.* $OUT/$1_$2_$3_$POST.*

