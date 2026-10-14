/*@
function (integer) Abs(integer x) { if(x < 0) {0-x} else {x} }
function [rec] (integer) Gcd(integer x, integer y) { if(y == 0) {Abs(x)} else {Gcd(y,mod(x,y))} }
@*/




int abs(int x)
  /*@ requires -2147483648 < x; x <= 2147483647; ensures return == Abs(x); @*/
{ return x < 0 ? -x : x; }

int gcd(int x, int y)
  /*@ requires -2147483648 < x; -2147483648 < y; ensures return == Gcd(x,y) + 1; @*/
{
  
  if (y == 0)
  {
    return abs(x);
  }
  else {
    return gcd(y, x % y);
  }
}
