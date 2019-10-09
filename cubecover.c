#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

/* cubes are represented with an integer between 0 and W*W*W-1
   each digit in base W is a coordinate
*/


#define MAXS 4
#define MAXW (2*MAXS-1)
#define MAXV (MAXW*MAXW*MAXW)
#define DIM 3
const int per[6][3] = {{0,1,2},{0,2,1},{1,0,2},{1,2,0},{2,0,1},{2,1,0}};
const int NUM_SYM = 48;
const int NUM_SYM4 = 8 * 8 * 8 * 6;
#define MAXSOL 50000
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

/* THIS METHOD IS ONLY WRITTEN FOR S = 3

cube is the index of the cube
sym is a number from 0 to 47
    the first 3 bits of sym are indicators of applying
        the (14) permutation
    the remaining 3 bits describe which permutation group
        is to be applied on the columns (out of 6)

These are all the symmetries which fix 000 and 222
 */
int apply_symmetry_three(int cube, int sym) {
    assert(S==3);
    assert(cube >= 0 && cube < V);
    assert(sym >= 0 && sym < NUM_SYM);
    int c[3] = {cube%W, (cube/W)%W, (cube/W/W)%W}, d[3];
    for (int i = 0; i < DIM; i++) {
        if (sym & (1 << i)) {
            if (c[i] == 1 || c[i] == 4) {
                c[i] = 5 - c[i];
            }
        }
    }

    int p = sym / 8;
    for (int i = 0; i < DIM; i++) {
        d[i] = c[per[p][i]];
    }
    return d[2]*W*W + d[1]*W + d[0];
}

/* THIS METHOD IS ONLY WRITTEN FOR S = 4

cube is the index of the cube
sym is a number from 0 to 8 * 8 * 8 * 6
    the first 3 bits of sym are indicators of applying
        the group generatored by <(15), (26), (16)(52)>
        to the first coordinate
    the next two packets of 3 bits are the same for the 2nd
        and 3rd coordinates
    the remaining 3 bits describe which permutation group
        is to be applied on the columns (out of 6)

These are all the symmetries which fix 000 and 222
 */
int apply_symmetry_four(int cube, int sym) {
    assert(S==4);
    assert(cube >= 0 && cube < V);
    assert(sym >= 0 && sym < NUM_SYM4);
    int c[3] = {cube%W, (cube/W)%W, (cube/W/W)%W}, d[3];
    for (int i = 0; i < DIM; i++) {
        for (int j = 0; j < DIM; j++) {
            if (sym & (1 << (DIM*i + j))) {
                if (j == 0 && (c[i] == 1 || c[i] == 5)) {
                    c[i] = 6 - c[i];
                }
                if (j == 1 && (c[i] == 2 || c[i] == 6)) {
                    c[i] = 8 - c[i];
                }
                if (j == 2 && (c[i] == 1 || c[i] == 2 || c[i] == 5 || c[i] == 6)) {
                    c[i] = 7 - c[i];
                }
            }
        }
    }

    int p = sym / 512;
    for (int i = 0; i < DIM; i++) {
        d[i] = c[per[p][i]];
    }
    return d[2]*W*W + d[1]*W + d[0];
}

/* from http://www.cplusplus.com/reference/cstdlib/qsort/ */
int int_cmp(const void* a, const void* b) {
    return *(int*) a - *(int*) b;
}

int check_canonical(int depth) {
    int s1[depth+1];
    for (int i = 0; i <= depth; i++) {
        s1[i] = stack[i];
    }
    qsort(s1, depth+1, sizeof(int), int_cmp);
    int s2[depth+1];
    int NS = (S == 3) ? NUM_SYM : NUM_SYM4;
    for (int sym = 0; sym < NS; sym++) {
        for (int i = 0; i <= depth; i++) {
            if (S == 3) {
                s2[i] = apply_symmetry_three(stack[i], sym);
            }
            else {
                s2[i] = apply_symmetry_four(stack[i], sym);
            }
        }
        qsort(s2, depth+1, sizeof(int), int_cmp);
        /* check that when applying the symmetry, the thing hasn't gotten worse */
        for (int i = 0; i <= depth; i++) {
            if (s2[i] < s1[i]) {
                return 0;
            }
            else if (s2[i] > s1[i]) {
                break;
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
            printf("%d%d%d\n", sol[i][j]%W, (sol[i][j]/W)%W, (sol[i][j]/W/W)%W);
        }
        printf("\n");
    }
}

/* DFS search, try the cube "at" next*/
void go(int at, int depth) {
    assert(at >= 0 && at < V && depth >= 0);
    fprintf(stderr, "PUSH %d%d%d\n", at % W, (at/W)%W, (at/W/W)%W);
    stack[depth] = at;
    cur_vol -= vol[at];
    fprintf(stderr, "VOLUME %d\n", cur_vol);
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
    fprintf(stderr, "POP %d%d%d\n", at % W, (at/W)%W, (at/W/W)%W);
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
