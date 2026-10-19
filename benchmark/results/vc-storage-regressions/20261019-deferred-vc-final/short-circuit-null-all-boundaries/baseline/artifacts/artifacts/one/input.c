int sample(int n) 
/*@ __tespec_entry Require
      (n == (0)) && 0 <= n && n <= 4096 && emp Ensure __return == n && emp */
/*@ Require 0 <= n && n <= 4096 && emp Ensure __return == n && emp */ { int *p=0; if(n==0 || *p) return n; return 1; }
