#include <stdlib.h>

unsigned int val_rand (unsigned int n)
/*@ requires n > 0u32;
    ensures 0u32 <= return && return < n;
@*/
{
    return rand() % n;
}

unsigned int two_dice ()
/*@ ensures 2u32 <= return && return <= 12u32; @*/
{
  unsigned int n1 = val_rand (6);
  unsigned int n2 = val_rand (6);
  unsigned int s = n1 + n2;
  return s + 2;
}

int main(void) /*@ ensures return == 0i32; @*/ { unsigned int result=two_dice(); return 0; }
