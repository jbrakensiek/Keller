JOBS=$1
NODE=$2
NMAX=$3
PRLL=$4
SABS=$5
SUBJ=/tmp/jobs.txt

awk 'NR % '$NMAX' == '$NODE'' $JOBS > $SUBJ

for (( i=0; i<$PRLL; i++ ))
do
  ~/Keller-private/loop-test.sh $SUBJ $i $PRLL $SABS &
done
wait
