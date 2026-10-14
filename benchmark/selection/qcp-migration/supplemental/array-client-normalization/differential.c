#include <assert.h>
#include <stdio.h>
int read (int *p, int n, int i)
{
  return p[i];
}
int original_main()
{
    int a[3] = { 0, 1, 2 };

    int zero = read(a, 3, 0);
    assert(zero == 0);
    int *first = a;
    assert(*first == 0);

    int one = read(a, 3, 1);
    assert(one == 1);
    int *second = a + 1;
    assert(*second == 1);

    int two = read(a, 3, 2);
    assert(two == 2);
    int *third = a + 2;
    assert(*third == 2);
return 0;
}





int normalized_read (int *p, int n, int i)

{
  return p[i];
}

int normalized_main()

{
    int a[3] = { 0, 1, 2 };
    int zero = normalized_read((int*)&a, 3, 0);assert(zero==0);

    int *first = a;assert(*first==0);

    int one = normalized_read((int*)&a, 3, 1);assert(one==1);

    int *second = a + 1;assert(*second==1);

    int two = normalized_read((int*)&a, 3, 2);assert(two==2);

    int *third = a + 2;assert(*third==2);

  return 0;
}

int main(void){assert(original_main()==0);assert(normalized_main()==0);puts("Original and cast-normalized main: all six physical assertions passed");return 0;}
