int sample(int n) 
/*@ __tespec_entry Require
      (n == (3)) && 0 <= n && n <= 4096 && emp Ensure __return == n && emp */
/*@ Require 0 <= n && n <= 4096 && emp Ensure __return == n && emp */ { switch(n) { case 0: return 0; case 3: return 3; default: return n; } }
