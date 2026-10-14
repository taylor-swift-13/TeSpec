#ifndef PKVM_ADDRESS_ARITHMETIC_CN_H
#define PKVM_ADDRESS_ARITHMETIC_CN_H
/* Numeric compatibility component. Allocation identity and ownership are
   separate obligations; this header does not replace the full pool contract. */
/*@
function (integer) pkvm_u64(integer x) {
  mod(x, 18446744073709551616)
}
function (integer) pkvm_physical_address(integer offset, integer v) {
  pkvm_u64(v + offset)
}
function (integer) pkvm_virtual_address(integer offset, integer p) {
  pkvm_u64(p - offset)
}
function (integer) pkvm_metadata_index(integer base, integer p, integer bytes) {
  pkvm_u64(p - base) / bytes
}
@*/
#endif
