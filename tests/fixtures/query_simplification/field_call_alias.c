struct Cell { int padding; int value; };
void step(struct Cell *q)
/*@ With v Require q->value == v Ensure q->value == v + 1 */
{ q->value += 1; }

int sample(struct Cell *p, struct Cell *q)
/*@ Require p == q && p->value == 3
    Ensure __return == 4 && p@pre->value == 4 */
{
    step(q);
    return p->value;
}
