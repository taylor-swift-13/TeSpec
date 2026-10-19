int sample(int n) 
/*@ __tespec_entry Require
      (n == (16)) && 5 <= n && n <= 4096 && emp Ensure __return == 3 && emp */
/*@ Require 5 <= n && n <= 4096 && emp Ensure __return == 3 && emp */ { int i=0; int c=0; while(i<n) { i++; if(i==2) continue; if(i==5) break; c++; } return c; }
