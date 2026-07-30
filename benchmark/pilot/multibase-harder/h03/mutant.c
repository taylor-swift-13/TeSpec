typedef struct DNode {
    struct DNode *previous;
    struct DNode *next;
    int value;
    unsigned int stamp;
} DNode;

typedef struct {
    DNode *head;
    DNode *tail;
    unsigned int mutations;
} Queue;

static DNode *pop_front(Queue *queue)
{
    DNode *node = queue->head;

    queue->head = node->next;
    if (queue->head != (DNode *)0) {
        queue->head->previous = (DNode *)0;
    } else {
        queue->tail = (DNode *)0;
    }
    node->previous = (DNode *)0;
    node->next = (DNode *)0;
    return node;
}

static void push_back(Queue *queue, DNode *node)
{
    node->previous = queue->tail;
    node->next = (DNode *)0;
    if (queue->tail != (DNode *)0) {
        queue->tail->next = node;
    } else {
        queue->head = node;
    }
    queue->tail = node;
}

int rotate_queue_twice(Queue *queue)
{
    DNode *first = pop_front(queue);

    push_back(queue, first);
    queue->mutations += 2u;
    return queue->head->value + queue->tail->value;
}
