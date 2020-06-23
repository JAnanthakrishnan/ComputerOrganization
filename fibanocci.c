#include <stdio.h>
int F[100];
int fibanocci(int n)
{
    if (n <= 1)
    {
        F[n] = n;
        return n;
    }
    else
    {
        if (F[n - 1] == -1)
        {
            F[n - 1] = fibanocci(n - 1);
        }
        if (F[n - 2] == -1)
        {
            F[n - 2] = fibanocci(n - 2);
        }
        return F[n - 1] + F[n - 2];
    }
}
int main()
{
    for (int i = 0; i < 100; i++)
    {
        F[i] = -1;
    }
    int n;
    printf("Enter the range of fibanocci number to be printed : ");
    scanf("%d", &n);
    fibanocci(n);
    for (int i = 0; i < n; i++)
    {
        printf("%d ", F[i]);
    }
    printf("\n");
}