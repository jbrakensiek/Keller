all: cnfgen cubecover symbreak3 symbreak4 jobs

jobs: jobs3.py jobs4.py
	python jobs3.py > jobs3.txt
	python jobs4.py > jobs4.txt

cnfgen: cnfgen.c
	gcc -O2 -Wall cnfgen.c -ocnfgen

cubecover: cubecover.c
	gcc -O2 -Wall cubecover.c -ocubecover
	echo "3" | ./cubecover > cubecover3.txt 2> /dev/null
	echo "4" | ./cubecover > cubecover4.txt 2> /dev/null

symbreak4: symbreak4.c
	gcc -O2 -Wall symbreak4.c -osymbreak4

symbreak3: symbreak3.c
	gcc -O2 -Wall symbreak3.c -osymbreak3

check_8_2: cnfgen
	./cnfgen < 8dim/8_2.gen > 8dim/8_2.cnf
	~/cadical/build/cadical 8dim/8_2.cnf > 8dim/8_2.log

check_8_3: cnfgen
	./cnfgen < 8dim/8_3.gen > 8dim/8_3.cnf
	~/cadical/build/cadical 8dim/8_3.cnf > 8dim/8_3.log

check_8_4: cnfgen
	./cnfgen < 8dim/8_4.gen > 8dim/8_4.cnf
	~/cadical/build/cadical 8dim/8_4.cnf > 8dim/8_4.log

clean:
	rm -f v1 v2 v3 v4 gen cubecover cnfgen symbreak3 symbreak4
	rm -f cubecover3.txt cubecover4.txt jobs3.txt jobs4.txt
