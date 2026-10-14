struct int_pair {
    int a;
    int b;
};

/*@ Extern Coq (store_int_pair : Z -> Z -> Z -> Assertion) */
/*@ include strategies "swap_simple2.strategies" */
/*@ Import Coq Require Import SimpleC.EE.QCP_demos_tutorial.swap_simple1_lib */


void swap_int_pair(struct int_pair *p)
/*@ With x y
    Require store_int_pair(p, x, y)
    Ensure store_int_pair(p, x, x)
 */
{
    int temp = p->a;
    p->a = p->b;
    p->b = temp;
}
