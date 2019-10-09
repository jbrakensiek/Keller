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
        for (int j = 0; j < t; j++) {
            char s[5];
            scanf ("%s", s);
            printf (" %s", s);
        }
        if (i % 2 == 0)
            printf("&");
        else if (i % 2 == 1)
            printf("\\\\\n");
    }
    printf("\\end{tabular}\n");
}
