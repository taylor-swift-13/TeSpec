int sample(int n) 
/*@ __tespec_entry Require
      (n == (4)) && 0 <= n && n <= 4096 && emp Ensure __return == n && emp */
/*@ Require 0 <= n && n <= 4096 && emp Ensure __return == n && emp */ { int i=0; while(i<n) { if(i==n-1) { /*@ Assert i==n && emp */ } i++; } return i; }
