int sample(int n) /*@ Require 0 <= n && n <= 4096 && emp Ensure __return == n && emp */ { int i=0; do { i++; } while(i<n); return i; }
