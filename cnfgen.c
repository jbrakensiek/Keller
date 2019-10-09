#include <stdio.h>
#include <assert.h>
#include <string.h>

/* N is the dimension, S is the number of different shifts (modulo 1) */
/* In the paper, N = 7 and S = {3,4} */
int N, S;

/* data which clauses are stored in */
#define MAXBUFFERLEN 40000000
int nvar = 0, nclause = 0, bufferpos = 0;;
int clause_buffer[MAXBUFFERLEN];

/* converts indicator for index w, coordinate i, shift c
   to a CNF variable (x_{w,i,c} notation in paper) */
int convert(int w, int i, int c) {
    assert(w >= 0 && w < (1 << N));
    assert(i >= 0 && i < N);
    assert(c >= 0 && c < S);
    /* add 1 because 1-indexed for DIMACS */
    int ans = S*N*w+S*i+c+1;
    if (ans > nvar) nvar = ans;
    return ans;
}

void add_clause(int* c, int len) {
    assert(bufferpos + len + 1 < MAXBUFFERLEN);
    nclause++;
    clause_buffer[bufferpos++] = len;
    for (int i = 0; i < len; i++) {
        clause_buffer[bufferpos++] = c[i];
    }
}

void print_cnf() {
    printf("p cnf %d %d\n", nvar, nclause);
    int p = 0;
    for (int i = 0; i < nclause; i++) {
        int len = clause_buffer[p++];
        for (int j = 0; j < len; j++) {
            printf("%d ", clause_buffer[p++]);
        }
        printf ("0\n");
    }
}

/* encode v = (a != b)
   v is a new variable, so returns the id */
int eqne(int a, int b) {
  int v = ++nvar;
  int w1[3] = { a,  b, -v};
  int w2[3] = {-a, -b, -v};
  int w3[3] = { a, -b,  v};
  int w4[3] = {-a,  b,  v};
  add_clause(w1, 3);
  add_clause(w2, 3);
  add_clause(w3, 3);
  add_clause(w4, 3);
  return v;
}

/* Assert that for all cubes w and coordinates i
   exactly one of x_{w,i,0}, ..., x_{w,i,S-1} is true */
void gen_cubes() {
    int cl[S];
    for (int w = 0; w < (1 << N); w++) {
        for (int i = 0; i < N; i++) {
            /* at least one true */
            for (int c = 0; c < S; c++) {
                cl[c] = convert(w, i, c);
            }
            add_clause(cl, S);
            /* at most one true */
            for (int c = 0; c < S; c++) {
                for (int cc = c+1; cc < S; cc++) {
                    cl[0] = -convert(w, i, c);
                    cl[1] = -convert(w, i, cc);
                    add_clause(cl, 2);
                }
            }
        }
    }
}

/* Assert for every pair of cubes w, ww that they do not intersect
   and do not faceshare */
void gen_edges() {
    for (int w = 0; w < (1 << N); w++) {
        for (int ww = w+1; ww < (1 << N); ww++) {
            int ylist[N*S];
            for (int i = 0; i < N; i++) {
                /* do w and ww differ in the ith coordinate ? */
                for (int c = 0; c < S; c++) {
                    int v = eqne(convert(w, i, c), convert(ww, i, c));
                    ylist[i*S + c] = v;
                }
            }
            /* check if w and ww differ in a single bit,
               if so, they are a faceshare risk, so some coordinate needs to diff */
            int xor = w ^ ww;
            if (__builtin_popcount(xor) == 1) {
                add_clause(ylist, N*S);
            }

            /* of the bits which w and ww differ in,
               they must be EXACTLY the same in one place */
            int zneg[N], zneglen = 0;
            for (int i = 0; i < N; i++) {
                if (xor & (1 << i)) {
                    /* the final cur corresponds to
                       z_{w,ww,i} <- x_{w, i, 0} != x_{ww, i, 0} OR ... OR x_{w, i, S-1} != x_{ww, i, S-1}
                       which we want to be FALSE
                    */
                    int znew = ++nvar, zbin[2];
                    for (int c = 0; c < S; c++) {
                        zbin[0] = znew;
                        zbin[1] = -ylist[S*i + c];
                        add_clause(zbin, 2);
                    }
                    zneg[zneglen++] = -znew;
                }
            }
            add_clause(zneg, zneglen);
        }
    }
}

/* THIS PART ONLY WORKS FOR S <= 5
  Here we encode that a particular cube is added (for symmetry breaking)
   c is a string, written in the alphabet {'0', '1', ..., '2S-1', '*'}
   The '*' denotes can be any of {'0', '1', '2', ... 'S-1'} */
void add_cube(char* c) {
    assert(S <= 5);
    assert(strlen(c) == N);
    fprintf(stderr, "%s\n", c);
    int w = 0;
    for (int i = 0; i < N; i++) {
        if (c[i] >= '0' && c[i] <= '0' + 2*S-1) {
            c[i] -= '0';
        }
        else if (c[i] == '*') {
            continue;
        }
        else {
            assert(0);
        }
        w += (1 << i) * (c[i] / S);
    }
    int pt[1];
    for (int i = 0; i < N; i++) {
        if (c[i] != '*') {
            pt[0] =  convert(w, i, c[i] % S);
            add_clause(pt, 1);
        }
    }
}

/* Read in cubes from input to add for symmetry breaking */
void sym_break() {
    int L;
    scanf ("%d", &L);
    char c[N+1];
    for (int i = 0; i < L; i++) {
        scanf("%s", c);
        add_cube(c);
    }
}

int main() {
    scanf("%d %d", &N, &S);
    gen_cubes();
    gen_edges();
    sym_break();
    print_cnf();
}
