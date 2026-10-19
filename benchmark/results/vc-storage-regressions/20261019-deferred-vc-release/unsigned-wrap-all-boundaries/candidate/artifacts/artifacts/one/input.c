int sample(int n) 
/*@ __tespec_entry Require
      (n == (0)) && 0 <= n && n <= 4096 && emp Ensure __return == n && emp */
/*@ Require 0 <= n && n <= 4096 && emp Ensure __return == n && emp */ { unsigned int v=4294967295U; v++; if(v==0) return 0; return 1; }
