#define main original_client_main
#include "native-adapter.c"
#undef main
int main(void) {
printf("list_head size %lu align %lu\n", (unsigned long)sizeof(struct list_head), (unsigned long)_Alignof(struct list_head));
printf("list_head next %lu %lu\n", (unsigned long)__builtin_offsetof(struct list_head, next), (unsigned long)sizeof(((struct list_head *)0)->next));
printf("list_head prev %lu %lu\n", (unsigned long)__builtin_offsetof(struct list_head, prev), (unsigned long)sizeof(((struct list_head *)0)->prev));
printf("hyp_page size %lu align %lu\n", (unsigned long)sizeof(struct hyp_page), (unsigned long)_Alignof(struct hyp_page));
printf("hyp_page refcount %lu %lu\n", (unsigned long)__builtin_offsetof(struct hyp_page, refcount), (unsigned long)sizeof(((struct hyp_page *)0)->refcount));
printf("hyp_page order %lu %lu\n", (unsigned long)__builtin_offsetof(struct hyp_page, order), (unsigned long)sizeof(((struct hyp_page *)0)->order));
printf("hyp_page flags %lu %lu\n", (unsigned long)__builtin_offsetof(struct hyp_page, flags), (unsigned long)sizeof(((struct hyp_page *)0)->flags));
printf("hyp_pool size %lu align %lu\n", (unsigned long)sizeof(struct hyp_pool), (unsigned long)_Alignof(struct hyp_pool));
printf("hyp_pool free_area %lu %lu\n", (unsigned long)__builtin_offsetof(struct hyp_pool, free_area), (unsigned long)sizeof(((struct hyp_pool *)0)->free_area));
printf("hyp_pool range_start %lu %lu\n", (unsigned long)__builtin_offsetof(struct hyp_pool, range_start), (unsigned long)sizeof(((struct hyp_pool *)0)->range_start));
printf("hyp_pool range_end %lu %lu\n", (unsigned long)__builtin_offsetof(struct hyp_pool, range_end), (unsigned long)sizeof(((struct hyp_pool *)0)->range_end));
printf("hyp_pool max_order %lu %lu\n", (unsigned long)__builtin_offsetof(struct hyp_pool, max_order), (unsigned long)sizeof(((struct hyp_pool *)0)->max_order));
return 0;
}
