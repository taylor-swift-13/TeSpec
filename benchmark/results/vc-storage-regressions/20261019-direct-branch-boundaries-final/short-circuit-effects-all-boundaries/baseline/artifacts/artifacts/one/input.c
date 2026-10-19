int bump(int *p) /*@ With v Require 0 <= v && v < 10 && data_at(p, int, v) Ensure __return == v+1 && data_at(p, int, v+1) */ { *p=*p+1; return *p; } int sample(int n) 
/*@ __tespec_entry Require
      (n == (3)) && 0 <= n && n <= 4096 && emp Ensure __return == n && emp */
/*@ Require 0 <= n && n <= 4096 && emp Ensure __return == n && emp */ { int i=0; int j=0; while(i<n && bump(&j)<4) i++; return j; }
