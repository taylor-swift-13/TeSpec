int sample(int n) /*@ Require 0 <= n && n <= 4096 && emp Ensure __return == n && emp */ { int c=0; for(int i=0;i<6;i++) { if(i%2==0) continue; c++; } return c; }
