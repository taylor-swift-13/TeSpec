int switch_in_callee(int n)
{
    switch (n) {
    case 0:
        return 10;
    case 1:
        n = 20;
        break;
    default:
        return 30;
    }
    return n;
}

int callee_switch(int n)
/*@ With (N: Z) (expected: Z)
    Require n == N && emp
    Ensure __return == expected && emp
*/
{
    return switch_in_callee(n);
}
