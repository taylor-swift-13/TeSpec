#include "char_array_def.h"

typedef unsigned char unint08;
typedef unsigned int unint32;

typedef struct TAG_STS_TRAN
{
    unint32 lenTotal;
    unint32 len;
    unint32 no;
    unint32 ptr;
    unint32 start;
    unint08 paraBuf[14];
    unint08 dataBuf[256];
} STS_TRAN;

STS_TRAN sSTSTran;

void Memcpyx(unint08 *dst, unint08 *src, unint32 n)
/*@ With bytes old_dst
    Require n == 248 && Zlength(bytes) == 248 && Zlength(old_dst) == 248 &&
            0 <= n && n < INT_MAX &&
            CharArray::full(dst, 248, old_dst) * CharArray::full(src, 248, bytes)
    Ensure CharArray::full(dst, 248, bytes) * CharArray::full(src, 248, bytes)
*/;
