struct Cell { int padding; int value; };

/* Field ownership does not imply that its containing pointer is nonzero. */
int sample(struct Cell *p)

/*@ __tespec_entry Require
      (p == (0)) && data_at(&p->value, int, 3)
    Ensure __return == 0 && data_at(&p@pre->value, int, 3) */
/*@ Require data_at(&p->value, int, 3)
    Ensure __return == 0 && data_at(&p@pre->value, int, 3) */
{
    if (p == 0) return 0;
    return 1;
}
