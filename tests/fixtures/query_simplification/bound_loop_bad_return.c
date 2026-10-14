int sample(int n)
/*@ Require 0 <= n && n <= 8 && emp Ensure __return == n@pre && emp */
{
    int i = 0;
    while (i < n) { i++; }
    return i + 1;
}
