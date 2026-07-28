/*@ Extern Coq (store_float : Z -> fp32 -> Assertion) */

void write_float_direct(float *p, float x)
/*@ Require undef_data_at(p)
    Ensure  store_float(p, x)
*/
{
    *p = x;
}
