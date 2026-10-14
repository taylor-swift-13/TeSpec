
int example(int x, int y) 
/*@ requires x < 50; ensures (x == y && return == 1) || (x != y && return == 0); @*/
{
  

  
  return x == y;
}
