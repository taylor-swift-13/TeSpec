/* Read-only compiler profiling observation of original allocator helper exits. */
#include "native-adapter.c"

void __attribute__((no_instrument_function))
__cyg_profile_func_enter(void *function, void *caller)
{
    (void)function; (void)caller;
}

void __attribute__((no_instrument_function))
__cyg_profile_func_exit(void *function, void *caller)
{
    unsigned int index;
    (void)caller;
    if (function != (void *)__hyp_extract_page) return;
    for (index=0; index<8; ++index) {
        struct hyp_page *page = &__hyp_vmemmap[client_base_pfn+index];
        struct list_head *head, *node;
        unsigned int seen=0;
        int listed=0;
        if (page->refcount || page->order == HYP_NO_ORDER) continue;
        if (page->order >= client_pool->max_order) continue;
        head = &client_pool->free_area[page->order];
        node = head->next;
        while (node != head && seen++ < 8) {
            unsigned long address = (unsigned long)node;
            unsigned long base = (unsigned long)client_arena;
            if (address < base || address >= base + 8 * PAGE_SIZE ||
                (address-base) % PAGE_SIZE) return;
            if ((address-base)/PAGE_SIZE == index) listed=1;
            node = node->next;
        }
        if (node != head || listed) continue;
        node = (struct list_head *)((unsigned char *)client_arena+index*PAGE_SIZE);
        printf("{\"event\":\"extract_post\",\"root\":%u,\"order\":%u,"
               "\"refcount\":%u,\"pool_start\":%llu,\"pool_end\":%llu,"
               "\"header\":%lu,\"prev\":%lu,\"next\":%lu}\n",
               index,page->order,page->refcount,
               (unsigned long long)client_pool->range_start,
               (unsigned long long)client_pool->range_end,
               (unsigned long)head,(unsigned long)node->prev,(unsigned long)node->next);
    }
    fflush((void *)0);
}
