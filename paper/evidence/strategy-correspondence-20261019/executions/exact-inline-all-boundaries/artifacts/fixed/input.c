int choose(void)
/*@ Require emp
    Ensure __return == 1 && emp */
{ return 1; }

int demo(void)
/*@ Require emp
    Ensure __return == 1 && emp */
{ int r = choose(); return r; }
