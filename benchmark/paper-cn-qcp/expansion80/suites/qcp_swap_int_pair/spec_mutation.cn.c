struct int_pair {
    int a;
    int b;
};






void swap_int_pair(struct int_pair *p)
/*@ requires take P = RW<struct int_pair>(p); ensures take Q = RW<struct int_pair>(p); Q.a == P.a; Q.b == P.a; @*/
{
    int temp = p->a;
    p->a = p->b;
    p->b = temp;
}
