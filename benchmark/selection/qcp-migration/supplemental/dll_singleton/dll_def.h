struct node { int data; struct node *prev; struct node *next; };
struct node_and_int { struct node *node; int data; };
/*@ Import Coq Require Import DLLSupplement */
/*@ Extern Coq (DLLLeft: Z -> Z -> list Z -> Assertion) (DLLRight: Z -> Z -> list Z -> Assertion) (Dll: Z -> list Z -> Z -> list Z -> Assertion) (dll_tail: list Z -> list Z) */
/*@ include strategies "dll.strategies" */
struct node *malloc_node()
/*@ Require emp Ensure __return != 0 && undef_data_at(&__return->data,int) * undef_data_at(&__return->prev,struct node*) * undef_data_at(&__return->next,struct node*) */;
void free_node(struct node *p)
/*@ Require undef_data_at(&p->data,int) * undef_data_at(&p->prev,struct node*) * undef_data_at(&p->next,struct node*) Ensure emp */;
struct node_and_int *malloc_node_and_int()
/*@ Require emp Ensure __return != 0 && undef_data_at(&__return->node,struct node*) * undef_data_at(&__return->data,int) */;
