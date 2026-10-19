int sample(int n) 
/*@ __tespec_entry Require
      (n == (3)) && 0 <= n && n <= 4096 && emp Ensure __return == n && emp */
/*@ Require 0 <= n && n <= 4096 && emp Ensure __return == n && emp */ { int x=n+1; int *p=0; return *p; }
