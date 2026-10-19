int sample(int n) 
/*@ __tespec_entry Require
      (n == (0)) && 0 <= n && n <= 4096 && emp Ensure __return == n && emp */
/*@ Require 0 <= n && n <= 4096 && emp Ensure __return == n && emp */ { int i=-3; while(i<0) i++; return i; }
