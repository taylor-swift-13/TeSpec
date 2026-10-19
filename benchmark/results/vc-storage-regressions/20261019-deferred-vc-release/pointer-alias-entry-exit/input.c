int sample(int n) /*@ Require 0 <= n && n <= 4096 && emp Ensure __return == n && emp */ { int a=n; int *p=&a; if(p==&a) return *p; return 0; }
