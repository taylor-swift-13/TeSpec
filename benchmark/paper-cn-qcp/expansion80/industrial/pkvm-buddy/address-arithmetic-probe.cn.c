#include "address-arithmetic.cn.h"
int address_arithmetic_check(void)
/*@ requires true;
    ensures return == 0;
    pkvm_physical_address(7, 4096) == 4103;
    pkvm_virtual_address(7, 4103) == 4096;
    pkvm_u64(-1) == 18446744073709551615;
    pkvm_metadata_index(0, 4096, 4) == 1024;
    pkvm_physical_address(-7, 4096) == 4089;
    pkvm_virtual_address(-7, 4089) == 4096;
@*/
{ return 0; }
int main(void) { return address_arithmetic_check(); }
