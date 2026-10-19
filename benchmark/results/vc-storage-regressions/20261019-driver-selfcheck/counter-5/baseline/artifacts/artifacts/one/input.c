int sample(int n) 
/*@ __tespec_entry Require
      (n == (5)) && 0 <= n && n <= 4096 && emp Ensure __return == n && emp */
/*@ Require 0 <= n && n <= 4096 && emp Ensure __return == n && emp */ { int i=0; int k=7; while(i<n) { k=k+0; i++; } return i; }
