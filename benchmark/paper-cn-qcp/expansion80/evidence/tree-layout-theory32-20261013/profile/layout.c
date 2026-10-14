#include <stdio.h>
#include <stddef.h>
struct tree { int key; int value; struct tree *left; struct tree *right; };
int main(void) { printf("%zu %zu %zu %zu %zu %zu %zu\n", sizeof(int), sizeof(void *), sizeof(struct tree), offsetof(struct tree,key), offsetof(struct tree,value), offsetof(struct tree,left), offsetof(struct tree,right)); }
