#include "verification_stdlib.h"
#include "dll_def.h"
struct node *singleton(int element)

/*@ __tespec_entry With e Require
      (element == (-2147483648)) && (e == (-2147483648)) && element == e && emp Ensure Dll(__return,nil,e,nil) */
/*@ With e Require element == e && emp Ensure Dll(__return,nil,e,nil) */
{
   struct node *n = malloc_node();
   n->data = element;
   n->prev = 0;
   n->next = 0;
   return n;
}
