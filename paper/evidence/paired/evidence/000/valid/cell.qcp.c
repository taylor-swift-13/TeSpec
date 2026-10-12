#include "verification_stdlib.h"

void bump(int *p)
/*@ With v
    Require 0 <= v && v < 100 && data_at(p, int, v)
    Ensure data_at(p, int, v + 1)
*/
{
    *p = *p + 1;
}

int main(void)
/*@ Require emp Ensure __return == 0 */
{
    int value = 3;
    bump(&value);
    return 0;
}
