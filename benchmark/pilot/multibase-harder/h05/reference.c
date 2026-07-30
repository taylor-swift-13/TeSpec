#include <stddef.h>

typedef struct Item {
    int key;
    int payload[2];
    unsigned int origin;
    unsigned int serial;
    struct Item *next;
} Item;

typedef struct {
    Item *left;
    Item *right;
    Item *merged;
    unsigned char *trace;
    size_t trace_capacity;
    size_t used;
} MergeContext;

static Item *take_front(Item **list)
{
    Item *item = *list;

    *list = item->next;
    item->next = (Item *)0;
    return item;
}

static void append_item(Item **head, Item **tail, Item *item)
{
    if (*tail == (Item *)0) {
        *head = item;
    } else {
        (*tail)->next = item;
    }
    *tail = item;
}

int stable_merge(MergeContext *context)
{
    Item *left = context->left;
    Item *right = context->right;
    Item *head = (Item *)0;
    Item *tail = (Item *)0;
    size_t used = 0;
    int key_sum = 0;

    while (left != (Item *)0 || right != (Item *)0) {
        Item *selected;
        if (right == (Item *)0 ||
            (left != (Item *)0 && left->key <= right->key)) {
            selected = take_front(&left);
        } else {
            selected = take_front(&right);
        }
        context->trace[used] = (unsigned char)selected->origin;
        ++used;
        key_sum += selected->key;
        append_item(&head, &tail, selected);
    }

    context->left = (Item *)0;
    context->right = (Item *)0;
    context->merged = head;
    context->used = used;
    return key_sum;
}
