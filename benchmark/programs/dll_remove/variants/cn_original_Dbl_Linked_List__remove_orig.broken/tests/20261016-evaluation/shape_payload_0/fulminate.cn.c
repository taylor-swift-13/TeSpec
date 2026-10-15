#include "./headers.h"
#include "./node_and_int.h"

// removes the given node from the list and returns another pointer 
// to somewhere in the list, or a null pointer if the list is empty.
struct node_and_int *remove(struct node *n)
{
    struct node *temp = 0;
    if (n->prev != 0) {
        n->prev->next = n->next;
        temp = n->prev;
    }
    if (n->next != 0) {
        n->next->prev = n->prev;
        temp = n->next;
    }

    struct node_and_int *pair = malloc_node_and_int();
    pair->node = temp;
    pair->data = n->data;

    free_node(n);       
    return pair;
}
int main(void) /*@ ensures return == 0i32; @*/ { struct node *n=cn_malloc(sizeof(struct node)); n->data=(-2147483647 - 1); n->prev=0; n->next=0; struct node_and_int *pair=remove(n); free_node_and_int(pair); return 0; }
