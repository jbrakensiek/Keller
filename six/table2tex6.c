#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    printf("\\begin{tabular}{lll|lll}\n");
    printf("Index & Size & Cubes & Index & Size & Cubes\\\\\\hline\n");
    for (int i = 0; i < n; i++) {
        printf("%d &", i);
        int t;
        scanf("%d", &t);
        printf("%d &", t);
        int S = 0;
        for (int j = 0; j < t; j++) {
            int s[5];
            scanf ("%d %d %d", &s[0], &s[1], &s[2]);
            if (j == 0) S = s[0];
            printf(" $");
            for (int k = 0; k < 3; k++){
                s[k] -= S-1;
                if (s[k] >= 0) {
                    printf("%d", s[k]);
                }
                else {
                    printf("\\bar{%d}", -s[k]);
                }
            }
            printf("$");
        }
        if (i % 2 == 0)
            printf("&");
        else if (i % 2 == 1)
            printf("\\\\\n");
    }
    printf("\\end{tabular}\n");
}
