#define CONST 1
/*@ function (i32) cn_CONST () { 1i32 } @*/

int main(void) /*@ ensures return == 0; @*/ { /*@ assert (cn_CONST() == 1i32); @*/ return 0; }
