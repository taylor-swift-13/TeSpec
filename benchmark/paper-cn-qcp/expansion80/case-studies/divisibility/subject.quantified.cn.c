int is_multiple(int a, int b)
/*@ requires 0 < b; ensures (return == 1 && mod(a,b) == 0) || (return == 0 && mod(a,b) != 0); each(integer q; true) {return != 0 || a != q * b}; @*/
{
    if (a % b == 0) {
        return 1;
    }
    return 0;
}

int main(void) /*@ ensures return == 0; @*/ { (void)is_multiple(6,3); (void)is_multiple(7,3); return 0; }
