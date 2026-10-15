unsigned int quadruple(unsigned int n)
/*@ requires true; ensures return == n; @*/
{ unsigned int m = n+n; return m+m; }
