#include <stdio.h>
#include <string.h>
#include <assert.h>

/* The symmetry breaking is specific for N = 7, S = 3 */
#define N 7
#define S 3
#define MAXCUBES 20
int L = 0;
char cubes[MAXCUBES][N+1];

void print_cubes() {
    assert(L <= MAXCUBES);
    printf("%d %d %d\n", N, S, L);

    for (int i = 0; i < L; i++) {
        assert(strlen(cubes[i]) == N);
        printf("%s\n", cubes[i]);
    }
}

/* check if the 4x2 grid with values in {0, 1, 2}
   is canonical with respect to the (01) swap in each column
   as well as swapping columns */
int canonical(int p[4][2]) {
    int seen0[2] = {0, 0}; /* indicator that 0 before 1 in col*/
    int order = 0; /* indicator that 1st column before 2nd */
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 2; j++) {
            if(p[i][j] == 0) {
                seen0[j] = 1;
            }
            else if (p[i][j] == 1 && !seen0[j]) {
                return 0;
            }
        }
        if (p[i][0] < p[i][1]) {
            order = 1;
        }
        else if (p[i][0] > p[i][1] && !order) {
            return 0;
        }
    }
    return 1;
}

void generate_cubes() {
    strncpy(cubes[L++], "2222222", N+1);
    strncpy(cubes[L++], "5322222", N+1);

    int index, tot;
    scanf("%d", &index);
    FILE *cubecover = fopen("cubecover3.txt", "r");
    fscanf(cubecover, "%d", &tot);
    assert(index >= 0 && index < tot);
    for (int i = 0; i < tot; i++) {
        int len;
        fscanf(cubecover, "%d", &len);
        for (int j = 0; j < len; j++) {
            char s[5];
            fscanf(cubecover, "%s", s);
            assert(strlen(s) == 3);
            if (index == i) {
                strncpy(cubes[L], "50*****", N+1);
                cubes[L][4] = s[0];
                cubes[L][5] = s[1];
                cubes[L][6] = s[2];
                L++;
            }
        }
    }

    /* Fill in the 4x2 patterns for the *s */
    assert(L >= 6);
    scanf("%d", &index);
    assert(index >= 0);
    int at = 0;
    if (index > 0) {
        int p[4][2];
        for (int i = 0; i < 6561; i++) {
            int ic = i;
            for (int j = 0; j < 4; j++) {
                for (int k = 0; k < 2; k++) {
                    p[j][k] = ic % 3;
                    ic /= 3;
                }
            }
            if (canonical(p)) {
                at++;
                if (at == index) {
                    for (int j = 0; j < 4; j++) {
                        cubes[j+2][2] = p[j][0] + '0';
                        cubes[j+2][3] = p[j][1] + '0';
                    }
                }
            }
        }
        assert(index <= at);
    }

    /* extra case handling for BIG cases*/
    scanf("%d", &index);
    assert(index >= 0 && index <= 243);
    if (index != 0) {
        index--;
        strncpy(cubes[L++], "25*****", N+1);
        for (int i = 0; i < 5; i++) {
            cubes[L-1][i+2] = '0' + index % 3;
            index /= 3;
        }
    }
}

int main() {
    generate_cubes();
    print_cubes();
}
