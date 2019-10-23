#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>

/* cubes are represented with an integer between 0 and W*W*W-1
   each digit in base W is a coordinate
*/


#define MAXS 6
#define MAXW (2*MAXS-1)
#define MAXV (MAXW*MAXW*MAXW)
#define DIM 3
#define MAXD 8
#define MAXSOL 50000
const int per[6][3] = {{0,1,2},{0,2,1},{1,0,2},{1,2,0},{2,0,1},{2,1,0}};
int vol[MAXV], use[MAXV], stack[MAXV];
int S, W, V, cur_vol;
int nsol = 0, sol[MAXSOL][20];

/* check if two cubes a and b overlap */
int block(int a, int b) {
    assert(a >= 0 && a < V && b >= 0 && b < V);
    for (int i = 0; i < 3; i++, a /= W, b /= W) {
        int x = a % W;
        int y = b % W;
        if (x % (2*S) == (y + S) % (2*S))
            return 0;
    }
    return 1;
}


/* from http://www.cplusplus.com/reference/cstdlib/qsort/ */
int int_cmp(const void* a, const void* b) {
    return *(int*) a - *(int*) b;
}

int isomorphic_recurse(int a[MAXD][DIM], int b[MAXD][DIM], int len, int d, int match[MAXD], int map[MAXW][DIM]) {
    int nmap[MAXW][DIM];
    fprintf(stderr, "AT %d\n", d);
    if (d == len) {
        /* for (int i = 0; i < len; i++) {
            fprintf (stderr, "%d %d %d    %d %d %d\n", a[i][0], a[i][1], a[i][2], b[i][0], b[i][1], b[i][2]);
        }
        for (int i = 0; i < len; i++) {
            fprintf(stderr, "match[%d] = %d\n", i, match[i]);
        }
        for (int i = 0; i < W; i++) {
            for (int j = 0; j < 3; j++) {
                fprintf(stderr, "map[%d][%d] = %d\n", i, j, map[i][j]);
            }
            } */
        return 1;
    }
    for (int i = 0; i < len; i++) {
        if (match[i] != -1) continue;
        memcpy(nmap, map, sizeof(int)*MAXW*DIM);
        int ok = 1;
        for (int j = 0; j < 3; j++) {
            if (map[a[i][j]][j] == -1) {
                for (int k = 0; k < W; k++) {
                    if (map[k][j] == b[d][j]) {
                        ok = 0;
                    }
                }
                map[a[i][j]][j] = b[d][j];
                map[(a[i][j] + S) % (2*S)][j] = (b[d][j] + S) % (2 * S);
            }
            else if (map[a[i][j]][j] != b[d][j]) {
                ok = 0;
            }
        }
        if (ok) {
            match[i] = d;
            if (isomorphic_recurse(a, b, len, d+1, match, map))
                return 1;
            match[i] = -1;
        }
        memcpy(map, nmap, sizeof(int)*MAXW*DIM);
    }
    return 0;
}

int isomorphic(int a[MAXD][DIM], int b[MAXD][DIM], int len) {
    int match[MAXD];
    for (int i = 0; i < len; i++) {
        match[i] = -1;
    }
    int map[MAXW][DIM];
    for (int i = 0; i < W; i++) {
        for (int j = 0; j < 3; j++) {
            if (i == 0 || i == S || i == S - 1) {
                map[i][j] = i;
            }
            else {
                map[i][j] = -1;
            }
        }
    }
    return isomorphic_recurse(a, b, len, 0, match, map);
}

int check_canonical(int depth) {
    int cubes[MAXD][3];
    for (int i = 0; i <= depth; i++) {
        cubes[i][0] = stack[i] % W;
        cubes[i][1] = (stack[i] / W) % W;
        cubes[i][2] = (stack[i] / W / W) % W;
    }

    for (int i = 0; i < DIM; i++) {
        int see = 0;
        for (int j = 0; j <= depth; j++) {
            if (cubes[j][i] % S == 0 || cubes[j][i] % S == S - 1)
                continue;
            int at = cubes[j][i] % S;
            if (at <= see) continue;
            if (at > see + 1) return 0;
            assert(at == see + 1);
            see++;
            if (cubes[j][i] > S) return 0;
        }
    }
    int cubes2[MAXD][3];
    for (int i = 0; i < nsol; i++) {
        if (sol[i][0] != depth + 1) continue;
        fprintf(stderr, "YOOOOOO %d\n", i);
        for (int k = 0; k < 6; k++) {
            for (int j = 0; j <= depth; j++) {
                cubes2[j][per[k][0]] = sol[i][j+1] % W;
                cubes2[j][per[k][1]] = (sol[i][j+1] / W) % W;
                cubes2[j][per[k][2]] = (sol[i][j+1] / W / W) % W;
            }
            if (isomorphic(cubes, cubes2, depth+1)) {
                return 0;
            }
        }
    }
    return 1;
}

/* add the cubes in the stack to the solution set */
void print_stack(int depth) {
    assert(depth >= 0);
    if (check_canonical(depth)) {
        fprintf (stderr, "SOLUTION\n");
    }
    else {
        fprintf (stderr, "NON-CANONICAL\n");
        return;
    }
    sol[nsol][0] = depth+1;
    for (int i = 0; i <= depth; i++) {
        sol[nsol][i + 1] = stack[i];
    }
    nsol++;
}

/* print the solutions */
void print_sol() {
    printf("%d\n\n", nsol);
    for (int i = 0; i < nsol; i++) {
        printf("%d\n", sol[i][0]);
        for (int j = 1; j <= sol[i][0]; j++) {
            printf("%d %d %d\n", sol[i][j]%W, (sol[i][j]/W)%W, (sol[i][j]/W/W)%W);
        }
        printf("\n");
    }
}

/* DFS search, try the cube "at" next*/
void go(int at, int depth) {
    assert(at >= 0 && at < V && depth >= 0);
    //  fprintf(stderr, "PUSH %d %d %d\n", at % W, (at/W)%W, (at/W/W)%W);
    stack[depth] = at;
    cur_vol -= vol[at];
    // fprintf(stderr, "VOLUME %d\n", cur_vol);
    /* complete cover */
    if (cur_vol == 0) {
        print_stack(depth);
    }
    else {
        for (int i = 0; i < V; i++) {
            use[i] += block(at, i);
        }
        /* want to look thorugh the cubes in sorted order */
        /* ignoring the first cube  */
        for (int i = (depth == 0) ? 0 : at+1; i < V; i++) {
            if (!use[i]) {
                go(i, depth+1);
            }
        }
        for (int i = 0; i < V; i++) {
            use[i] -= block(at, i);
        }
    }
    cur_vol += vol[at];
    // fprintf(stderr, "POP %d %d %d\n", at % W, (at/W)%W, (at/W/W)%W);
}


int main() {
    scanf("%d", &S);
    W = 2*S-1;
    V = W*W*W;
    cur_vol = S*S*S;

    for (int i = 0; i < V; i++) {
        int j = i;
        vol[i] = 1;
        for (int k = 0; k < DIM; k++, j /= W) {
            vol[i] *= S - abs((j % W) - (S-1));
        }
    }

    /* include the cube with coordinates S S S */
    go(S  + S * W + S * W * W, 0);

    print_sol();

    return 0;
}

