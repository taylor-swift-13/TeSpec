int sample(int n) 
/*@ __tespec_entry Require
      (n == (4)) && 0 <= n && n <= 4096 && emp Ensure __return == n && emp */
/*@ Require 0 <= n && n <= 4096 && emp Ensure __return == n && emp */ { int i=0; /*@ Inv 0 <= i && i <= n && emp */ while(i<n) { i++; } return i; }
