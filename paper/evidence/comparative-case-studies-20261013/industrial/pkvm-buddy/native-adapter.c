/* Native client adapter for the frozen industrial input C, not a tool backend. */
#define assert(x) ((void)0)
#ifndef ALLOCATOR_SOURCE
#define ALLOCATOR_SOURCE "../../source-snapshots/fulminate/pkvm-buddy/page_alloc.c"
#endif
#include ALLOCATOR_SOURCE

extern void *calloc(unsigned long, unsigned long);
extern void *mmap(void *, unsigned long, int, int, int, long);
extern int munmap(void *, unsigned long);
extern void free(void *);
extern int scanf(const char *, ...);
extern int printf(const char *, ...);
extern int fflush(void *);
/* The frozen snapshot declares BSD flsl; provide its portable bit-position ABI. */
long flsl(long x)
{
    unsigned long bits = (unsigned long)x;
    long position = 0;
    while (bits) { ++position; bits >>= 1; }
    return position;
}
s64 hyp_physvirt_offset;

static struct hyp_pool *client_pool;
static void *client_arena;
static void *client_handles[4096];
static unsigned int client_refs[4096];
static unsigned long client_base_pfn;

static int snapshot(long result, int zeroed)
{
    unsigned int i, order;
    int first = 1;
    printf("{\"result\":%ld,\"zeroed\":%d,\"max_order\":%u,\"free\":[", result, zeroed, client_pool->max_order);
    for (order = 0; order < client_pool->max_order; ++order) {
        struct list_head *head = &client_pool->free_area[order];
        struct list_head *previous = head;
        struct list_head *node = head->next;
        unsigned int visited = 0;
        while (node != head) {
            unsigned long address = (unsigned long)node;
            unsigned long base = (unsigned long)client_arena;
            if (++visited > 8 || address < base || address >= base + 8 * PAGE_SIZE ||
                (address - base) % PAGE_SIZE != 0) {
                printf("],\"error\":\"invalid free-list node\"}\n");
                return 42;
            }
            if (node->prev != previous) {
                printf("],\"error\":\"invalid free-list backlink\"}\n");
                return 43;
            }
            printf("%s[%lu,%u]", first ? "" : ",", (address-base)/PAGE_SIZE, order);
            first = 0;
            previous = node;
            node = node->next;
        }
        if (head->prev != previous) {
            printf("],\"error\":\"invalid free-list tail\"}\n");
            return 44;
        }
    }
    printf("],\"meta\":[");
    for (i=0; i<8; ++i) {
        struct hyp_page *page = &__hyp_vmemmap[client_base_pfn+i];
        printf("%s[%u,%u,%u]", i ? "," : "", page->refcount, page->order, page->flags);
    }
    printf("]}\n");
    fflush((void *)0);
    return 0;
}

int main(void)
{
    unsigned long base_pfn;
    unsigned int count, step;
    if (scanf("%lu %u", &base_pfn, &count) != 2 || base_pfn < 4096 || base_pfn > 4103)
        return 10;
    client_base_pfn = base_pfn;
    /* Linux MAP_FIXED_NOREPLACE avoids replacing any existing mapping.
       All vmemmap pointer arithmetic stays inside its allocated prefix+pool. */
    client_arena = mmap((void *)(base_pfn * PAGE_SIZE), 8 * PAGE_SIZE,
                        3, 0x22 | 0x100000, -1, 0);
    if (client_arena == (void *)-1 || (unsigned long)client_arena != base_pfn * PAGE_SIZE)
        return 11;
    hyp_physvirt_offset = 0;
    cn_virt_base = cn_virt_ptr = client_arena;
    __hyp_vmemmap = calloc(base_pfn + 8, sizeof(struct hyp_page));
    client_pool = calloc(1, sizeof(struct hyp_pool));
    if (!__hyp_vmemmap || !client_pool) return 12;
    client_pool->range_start = base_pfn * PAGE_SIZE;
    client_pool->range_end = (base_pfn + 8) * PAGE_SIZE;
    client_pool->max_order = 10;
    if (hyp_pool_init(client_pool, base_pfn, 8, 0) != 0) return 13;
    if (snapshot(-2, -1)) return 40;
    for (step=0; step<count; ++step) {
        char op;
        unsigned int handle, order;
        long result = -2;
        int zeroed = -1;
        if (scanf(" %c %u %u", &op, &handle, &order) != 3 || handle >= 4096) return 14;
        if (op == 'A') {
            if (client_refs[handle] || order >= 10) return 15;
            client_handles[handle] = hyp_alloc_pages(client_pool, (u8)order);
            if (client_handles[handle]) {
                unsigned long address = (unsigned long)client_handles[handle];
                unsigned long base = (unsigned long)client_arena;
                if (address < base || address >= base + 8 * PAGE_SIZE ||
                    (address-base) % PAGE_SIZE) return 16;
                result = (address-base)/PAGE_SIZE;
                if (order > 3 || (1U << order) > 8 - result) return 16;
                zeroed = 1;
                for (unsigned long byte=0; byte<((1UL << order) * PAGE_SIZE); ++byte)
                    if (((unsigned char *)client_handles[handle])[byte] != 0) zeroed = 0;
                client_refs[handle] = 1;
            } else result = -1;
        } else if (op == 'G') {
            if (client_refs[handle]) {
                if (client_refs[handle] == 65535) return 17;
                hyp_get_page(client_pool, client_handles[handle]);
                ++client_refs[handle];
            }
        } else if (op == 'P' || op == 'F') {
            if (client_refs[handle]) {
                do {
                    hyp_put_page(client_pool, client_handles[handle]);
                    --client_refs[handle];
                } while (op == 'F' && client_refs[handle]);
            }
        } else return 18;
        if (snapshot(result, zeroed)) return 41;
    }
    munmap(client_arena, 8 * PAGE_SIZE);
    free(__hyp_vmemmap);
    free(client_pool);
    return 0;
}
