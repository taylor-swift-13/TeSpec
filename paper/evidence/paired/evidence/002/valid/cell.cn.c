struct pair { int x; int y; };
void sample(struct pair *p)
/*@ requires take v = RW<struct pair>(p); 0 <= v.x; v.x < 100; ensures take w = RW<struct pair>(p); w.x == v.x + 1; w.y == v.y; @*/
{ p->x = p->x + 1; }
int main(void)
/*@ ensures return == 0; @*/
{ struct pair a = {3, 5}; sample(&a); return 0; }
