int sample(int n) /*@ Require 0 <= n && n <= 4096 && emp Ensure __return == n && emp */ { int i=0; while(i<n) i++; return i; }
