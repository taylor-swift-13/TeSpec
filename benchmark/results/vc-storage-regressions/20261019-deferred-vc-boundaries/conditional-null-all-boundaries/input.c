int sample(int n) /*@ Require 0 <= n && n <= 4096 && emp Ensure __return == n && emp */ { int *p=0; return n>0 ? n : *p; }
