JOBS=$1
INIT=$2
STEP=$3
SABS=$4

DIR=/tmp

awk 'NR % '$STEP' == '$INIT'' $JOBS > $DIR/Keller-$INIT-$STEP
cd ~/Keller-private
xargs -n 3 bash ./test$SABS.sh < $DIR/Keller-$INIT-$STEP
