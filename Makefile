all: cnfgen encode symbreak3 symbreak4 cubecover6 jobs

encode: Keller-encode.c
	gcc -std=c99 -O2 -Wall Keller-encode.c -oKeller-encode

six: cnfgen6 cubecover6 symbreak6 jobs6

jobs: jobs3.py jobs4.py
	python jobs3.py > jobs3.txt
	python jobs4.py > jobs4.txt

jobs6:
	python six/jobs6.py > jobs6.txt

cnfgen: cnfgen.c
	gcc -std=c99 -O2 -Wall cnfgen.c -ocnfgen

cnfgen6: six/cnfgen6.c
	gcc -std=c99 -O2 -Wall six/cnfgen6.c -ocnfgen6

cubecover6: six/cubecover6.c
	gcc -std=c99 -O2 -Wall six/cubecover6.c -ocubecover6
	echo "3" | ./cubecover6 > cubecover3.txt 2> /dev/null
	echo "4" | ./cubecover6 > cubecover4.txt 2> /dev/null
	echo "5" | ./cubecover6 > cubecover5.txt 2> /dev/null
	echo "6" | ./cubecover6 > cubecover6.txt 2> /dev/null

table2tex6: six/table2tex6.c cubecover6
	gcc -std=c99 -O2 -Wall six/table2tex6.c -otable2tex6
	./table2tex6 < cubecover3.txt > s3.tex
	./table2tex6 < cubecover4.txt > s4.tex
	./table2tex6 < cubecover5.txt > s5.tex
	./table2tex6 < cubecover6.txt > s6.tex

symbreak6: six/symbreak6.c
	gcc -std=c99 -O2 -Wall six/symbreak6.c -osymbreak6

symbreak4: symbreak4.c
	gcc -std=c99 -O2 -Wall symbreak4.c -osymbreak4

symbreak3: symbreak3.c
	gcc -std=c99 -O2 -Wall symbreak3.c -osymbreak3

eight: cnfgen6
	./cnfgen6 < 8dim/8_2.gen > 8dim/8_2.cnf
	./cnfgen6 < 8dim/8_3.gen > 8dim/8_3.cnf
	./cnfgen6 < 8dim/8_4.gen > 8dim/8_4.cnf
	./cnfgen6 < 8dim/8_6.gen > 8dim/8_6.cnf
	-~/cadical/build/cadical 8dim/8_2.cnf > 8dim/8_2.log
	-~/cadical/build/cadical 8dim/8_3.cnf > 8dim/8_3.log
	-~/cadical/build/cadical 8dim/8_4.cnf > 8dim/8_4.log
	-~/cadical/build/cadical 8dim/8_6.cnf > 8dim/8_6.log

clean:
	rm -f v1 v2 v3 v4 gen cubecover cnfgen symbreak3 symbreak4
	rm -f cnfgen6 cubecover6 symbreak6
	rm -f cubecover3.txt cubecover4.txt jobs3.txt jobs4.txt
