#include <stdio.h>
#include "sll_layout32_def.h"
int main(void) { printf("%lu %lu %lu %lu %lu\n", (unsigned long)sizeof(int), (unsigned long)sizeof(void *), (unsigned long)sizeof(struct list), (unsigned long)__builtin_offsetof(struct list,data), (unsigned long)__builtin_offsetof(struct list,next)); return 0; }
