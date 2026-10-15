#define main original_client_main
#include "native-adapter.c"
#undef main
int main(void) { printf("%lu %lu %lu %lu\n", (unsigned long)sizeof(void *), (unsigned long)sizeof(struct list_head), (unsigned long)sizeof(struct hyp_page), (unsigned long)sizeof(struct hyp_pool)); return 0; }
