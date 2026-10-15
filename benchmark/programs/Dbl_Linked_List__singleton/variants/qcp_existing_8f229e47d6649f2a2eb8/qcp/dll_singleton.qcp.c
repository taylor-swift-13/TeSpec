#include "verification_stdlib.h"
#include "dll_def.h"
struct node *singleton(int element)
/*@ With e Require element == e && emp Ensure Dll(__return,nil,e,nil) */
{
   struct node *n = malloc_node();
   n->data = element;
   n->prev = 0;
   n->next = 0;
   return n;
}
