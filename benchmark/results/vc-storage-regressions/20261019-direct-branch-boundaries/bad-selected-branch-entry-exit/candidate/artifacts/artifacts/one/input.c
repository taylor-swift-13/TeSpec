int sample(int n) 
/*@ __tespec_entry Require
      (n == (3)) && 0 <= n && n <= 4096 && emp Ensure __return == n && emp */
/*@ Require 0 <= n && n <= 4096 && emp Ensure __return == n && emp */ { if(n<5) return n+1; return n; }
