    /*@ function (i32) cn_CONST () { 1i32 } @*/
    // static int c_CONST() /*@ cn_function CONST; @*/ { return CONST; }
int foo (int x)
/*@
  requires true;
  ensures return == cn_CONST();
@*/
{
  return 1;
}
int main(void) /*@ ensures return == 0i32; @*/ { foo(2147483647); return 0; }
