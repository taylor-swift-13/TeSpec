#define main original_client_main
#include "native-adapter.c"
#undef main
int main(void) { unsigned int x=0x01020304; unsigned char *b=(unsigned char *)&x; printf("%lu %lu %u %u %u %u\n", (unsigned long)sizeof(void *), (unsigned long)sizeof(struct list_head), b[0], b[1], b[2], b[3]); return 0; }
