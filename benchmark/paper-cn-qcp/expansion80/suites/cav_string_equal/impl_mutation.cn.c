/*@
function [rec] (integer) Same(map<integer,integer> a, map<integer,integer> b, integer n) { if(n <= 0) {1} else { if(a[n-1] == b[n-1]) {Same(a,b,n-1)} else {0} } }
@*/
int string_equal(char *a, char *b)
/*@ requires cn_ghost integer na, integer nb; 0 <= na; na < 2147483647; 0 <= nb; nb < 2147483647; take A = each(integer i; 0 <= i && i <= na) {RW<char>(array_shift<char>(a,i))}; take B = each(integer i; 0 <= i && i <= nb) {RW<char>(array_shift<char>(b,i))}; A[na] == 0; B[nb] == 0; each(integer i; 0 <= i && i < na) {A[i] != 0}; each(integer i; 0 <= i && i < nb) {B[i] != 0}; ensures take A2 = each(integer i; 0 <= i && i <= na) {RW<char>(array_shift<char>(a,i))}; take B2 = each(integer i; 0 <= i && i <= nb) {RW<char>(array_shift<char>(b,i))}; A2 == A; B2 == B; (return == 1 && na == nb && Same(A,B,na) == 1) || (return == 0 && (na != nb || Same(A,B,na) == 0)); @*/
{
    int i = 0;

    while (1) {
        if (a[i] == 0) {
            break;
        }
        if (b[i] == 0) {
            break;
        }
        if (a[i] != b[i]) {
            return 1;
        }
        i++;
    }

    if (a[i] == 0 && b[i] == 0) {
        return 1;
    }
    return 0;
}
