float float_sub(float x, float y)
/*@ Require emp && fp32_isFinite(x) && fp32_isFinite(y) &&
              fp32_isFinite(fp32_sub(x, y))
    Ensure __return == fp32_sub(x, y) && emp
  */
{
  return x - y;
}

float float_div(float x, float y)
/*@ Require emp && fp32_isFinite(x) && fp32_isFinite(y) &&
              fp32_ne(y, fp32(0.0)) &&
              fp32_isFinite(fp32_div(x, y))
    Ensure __return == fp32_div(x, y) && emp
  */
{
  return x / y;
}

double double_mixed_expression(double x, double y)
/*@ Require emp && fp64_isFinite(x) && fp64_isFinite(y) &&
            fp64_isFinite(fp64_add(x, y)) &&
            fp64_isFinite(fp64_sub(x, y)) &&
            fp64_isFinite(fp64_mul(fp64_add(x, y), fp64_sub(x, y)))
    Ensure __return == fp64_mul(fp64_add(x, y), fp64_sub(x, y)) && emp
  */
{
  return (x + y) * (x - y);
}

double double_mul_add_chain(double x, double y, double z)
/*@ Require emp && fp64_isFinite(x) && fp64_isFinite(y) && fp64_isFinite(z) &&
              fp64_isFinite(fp64_mul(x, y)) &&
              fp64_isFinite(fp64_add(fp64_mul(x, y), z))
    Ensure __return == fp64_add(fp64_mul(x, y), z) && emp
  */
{
  return x * y + z;
}

int float_neg_involution_branch(float x)
/*@ Require emp && fp32_isFinite(x) &&
              fp32_isFinite(fp32_neg(x)) &&
              fp32_isFinite(fp32_neg(fp32_neg(x)))
    Ensure __return == 1 && emp
  */
{
  if (-(-x) == x) {
    return 1;
  }
  return 0;
}

int float_lt_branch(float x, float y)
/*@ Require emp && fp32_isFinite(x) && fp32_isFinite(y)
    Ensure fp32_lt(x, y) && __return == 1 && emp ||
           fp32_ge(x, y) && __return == 0 && emp
  */
{
  if (x < y) {
    return 1;
  }
  return 0;
}

int float_ne_branch(float x, float y)
/*@ Require emp && fp32_isFinite(x) && fp32_isFinite(y)
    Ensure fp32_ne(x, y) && __return == 1 && emp ||
           fp32_eq(x, y) && __return == 0 && emp
  */
{
  if (x != y) {
    return 1;
  }
  return 0;
}

int double_eq_branch(double x, double y)
/*@ Require emp && fp64_isFinite(x) && fp64_isFinite(y)
    Ensure fp64_eq(x, y) && __return == 1 && emp ||
           fp64_ne(x, y) && __return == 0 && emp
  */
{
  if (x == y) {
    return 1;
  }
  return 0;
}

int double_ge_branch(double x, double y)
/*@ Require emp && fp64_isFinite(x) && fp64_isFinite(y)
    Ensure fp64_ge(x, y) && __return == 1 && emp ||
           fp64_lt(x, y) && __return == 0 && emp
  */
{
  if (x >= y) {
    return 1;
  }
  return 0;
}
