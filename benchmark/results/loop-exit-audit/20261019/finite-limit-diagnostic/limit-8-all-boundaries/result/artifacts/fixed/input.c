int sample(int n)

/*@ __tespec_entry Require
      (n == (3)) && 0 <= n && n <= 8 && emp Ensure __return == n@pre && emp */
/*@ Require 0 <= n && n <= 8 && emp Ensure __return == n@pre && emp */
{
    int i = 0;
    while (i < n) { i++; }
    return i;
}
