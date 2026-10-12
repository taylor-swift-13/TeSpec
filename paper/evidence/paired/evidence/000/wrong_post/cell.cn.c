void bump(int *p)
/*@ requires take v = RW<int>(p); 0 <= v; v < 100;
    ensures take w = RW<int>(p); w == v + 2; @*/
{
    *p = *p + 1;
}

int main(void)
/*@ ensures return == 0; @*/
{
    int value = 3;
    bump(&value);
    return 0;
}
