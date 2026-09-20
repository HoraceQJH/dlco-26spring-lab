#include <bits/stdc++.h>
using namespace std;
int main()
{
    int x = 1;
    for (int i = 1; i <= 256; i++)
    {
        printf("%d ", x);
        if (i % 16 == 0)
            printf("\n");
        int Cin = ((x >> 4) & 1) ^ ((x >> 3) & 1) ^ ((x >> 2) & 1) ^ ((x >> 0) & 1);
        x = (x >> 1) | (Cin << 7);
    }
    return 0;
}