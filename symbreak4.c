#include <stdio.h>
#include <string.h>
#include <assert.h>

/* The symmetry breaking is specific for N = 7, S = 4 */
#define N 7
#define S 4
#define MAXCUBES 20
int L = 0;
char cubes[MAXCUBES][N+1];

void print_cubes() {
    assert(L <= MAXCUBES);
    printf("%d %d %d\n", N, S, L);

    for (int i = 0; i < L; i++) {
        assert(strlen(cubes[i]) == N);
        for (int j = 0; j < N; j++) {
            if (cubes[i][j] == '*') {
                printf("-1");
            }
            else
                printf("%c", cubes[i][j]);
            if (j < N-1) printf(" ");
            else printf("\n");
        }
    }
}

/* check if the 4x2 grid with values in {0, 1, 2, 3}
   is canonical with respect to any permutation of 012 in each column
   as well as swapping columns */
int canonical(int p[4][2]) {
    int first[3][2] = {{5, 5}, {5, 5}, {5, 5}};
    int order = 0; /* indicator that 1st column before 2nd */
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 2; j++) {
            if(p[i][j] == 3)
                continue;
            if (first[p[i][j]][j] == 5)
                first[p[i][j]][j] = i;
        }
        if (p[i][0] < p[i][1]) {
            order = 1;
        }
        else if (p[i][0] > p[i][1] && !order) {
            return 0;
        }
    }
    return first[0][0] <= first[1][0] && first[1][0] <= first[2][0] &&
        first[0][1] <= first[1][1] && first[1][1] <= first[2][1];
}

void generate_cubes() {
    strncpy(cubes[L++], "3333333", N+1);
    strncpy(cubes[L++], "7433333", N+1);

    int index, tot;
    scanf("%d", &index);
    FILE *cubecover = fopen("cubecover4.txt", "r");
    fscanf(cubecover, "%d", &tot);
    assert(index >= 0 && index < tot);
    for (int i = 0; i < tot; i++) {
        int len;
        fscanf(cubecover, "%d", &len);
        for (int j = 0; j < len; j++) {
            int s[5];
            fscanf(cubecover, "%d %d %d", &s[0], &s[1], &s[2]);
            if (index == i) {
                strncpy(cubes[L], "70*****", N+1);
                cubes[L][4] = s[0] + '0';
                cubes[L][5] = s[1] + '0';
                cubes[L][6] = s[2] + '0';
                L++;
            }
        }
    }

    assert(L >= 6);
    scanf("%d", &index);
    assert(index >= 0);
    int at = 0;
    if (index > 0) {
        int p[4][2];
        for (int i = 0; i < S*S*S*S*S*S*S*S; i++) {
            int ic = i;
            for (int j = 0; j < 4; j++) {
                for (int k = 0; k < 2; k++) {
                    p[j][k] = ic % S;
                    ic /= S;
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
    assert(index >= 0 && index <= S*S*S*S*S);
    if (index != 0) {
        index--;
        strncpy(cubes[L++], "37*****", N+1);
        for (int i = 0; i < 5; i++) {
            cubes[L-1][i+2] = '0' + index % S;
            index /= S;
        }
    }
}

int main() {
    generate_cubes();
    print_cubes();
}
