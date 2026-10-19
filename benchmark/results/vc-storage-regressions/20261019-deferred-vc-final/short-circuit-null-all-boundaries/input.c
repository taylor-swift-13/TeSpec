int sample(int n) /*@ Require 0 <= n && n <= 4096 && emp Ensure __return == n && emp */ { int *p=0; if(n==0 || *p) return n; return 1; }
