#include <stdio.h>
void sieve(int a, int b)
{
    int P[1000];
    P[0] = P[1] = 0;
    for (int p = 2; p < b; p++)
    {
        P[p] = p;
    }
    for (int p = 2; p * p < b; p++)
    {
        if (P[p] != 0)
        {
            int j = p * p;
            while (j < b)
            {
                P[j] = 0;
                j += p;
            }
        }
    }
    static int Q[1000] = {0};
    int q = 0;
    for (int i = a; i < b; i++)
    {
        if (P[i] != 0)
        {
            Q[q] = P[i];
            q++;
        }
    }
    for (int i = 0; i < q; i++)
    {
        printf("%d ", Q[i]);
    }
}
int main()
{
    int a, b;
    int *Q;
    printf("Enter the first number : ");
    scanf("%d", &a);
    printf("Enter the second number : ");
    scanf("%d", &b);
    sieve(a, b);
    printf("\n");
}