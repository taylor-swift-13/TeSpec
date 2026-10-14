int is_multiple(int a, int b)
/*@ requires 0 < b; ensures (return == 1 && mod(a,b) == 0) || (return == 0 && mod(a,b) != 0); @*/
{
    if (a % b != 0) {
        return 1;
    }
    return 0;
}
