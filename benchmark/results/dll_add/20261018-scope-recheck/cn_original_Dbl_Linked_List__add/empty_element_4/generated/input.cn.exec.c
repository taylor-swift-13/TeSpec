#define __CN_INSTRUMENT
#include <cn-executable/utils.h>
#include <cn-executable/cerb_types.h>
typedef __cerbty_intptr_t intptr_t;
typedef __cerbty_uintptr_t uintptr_t;
typedef __cerbty_intmax_t intmax_t;
typedef __cerbty_uintmax_t uintmax_t;
_Noreturn void abort(void);
/* ORIGINAL C STRUCTS AND UNIONS */

struct int_list {
  signed int head;
  struct int_list* tail;
};

struct node {
  signed int data;
  struct node* prev;
  struct node* next;
};


/* CN VERSIONS OF C STRUCTS */

struct int_list_cn {
  cn_integer* head;
  cn_pointer* tail;
};

struct node_cn {
  cn_integer* data;
  cn_pointer* prev;
  cn_pointer* next;
};

/* CN DATATYPES */enum seq_tag {
  SEQ_NIL,
  SEQ_CONS
};

struct cn_datatype {
  signed int tag;
  struct cntype* cntype;
};

struct cntype {
  ;
};

struct seq_nil {
  ;
};

struct seq_cons {
  struct seq* tail;
  cn_integer* head;
};

union seq_union {
  struct seq_nil* seq_nil;
  struct seq_cons* seq_cons;
};

struct seq {
  enum seq_tag tag;
  struct cntype* cntype;
  union seq_union u;
};

enum Dll_tag {
  EMPTY_DLL,
  DLL
};

struct empty_dll {
  ;
};

struct dll {
  struct seq* right;
  struct node_cn* curr;
  struct seq* left;
};

union Dll_union {
  struct empty_dll* empty_dll;
  struct dll* dll;
};

struct Dll {
  enum Dll_tag tag;
  struct cntype* cntype;
  union Dll_union u;
};



/* OWNERSHIP FUNCTIONS */

static struct int_list_cn* deref_struct_int_list(cn_pointer*, enum spec_mode, struct loop_ownership*);
static struct node_cn* deref_struct_node(cn_pointer*, enum spec_mode, struct loop_ownership*);
static struct int_list_cn* owned_struct_int_list(cn_pointer*, enum spec_mode, struct loop_ownership*);
static struct node_cn* owned_struct_node(cn_pointer*, enum spec_mode, struct loop_ownership*);
/* CONVERSION FUNCTIONS */

/* GENERATED STRUCT FUNCTIONS */

static struct Dll* default_struct_Dll();
static struct seq* default_struct_seq();
static void* cn_map_get_struct_Dll(cn_map*, cn_integer*);
static void* cn_map_get_struct_seq(cn_map*, cn_integer*);
static struct node_cn* default_struct_node_cn();
static struct int_list_cn* default_struct_int_list_cn();
static void* cn_map_get_struct_node_cn(cn_map*, cn_integer*);
static void* cn_map_get_struct_int_list_cn(cn_map*, cn_integer*);
static cn_bool* struct_Dll_equality(struct Dll*, struct Dll*);
static cn_bool* struct_seq_equality(struct seq*, struct seq*);
static cn_bool* struct_node_cn_equality(void*, void*);
static cn_bool* struct_int_list_cn_equality(void*, void*);
static struct node convert_from_struct_node_cn(struct node_cn*);
static struct int_list convert_from_struct_int_list_cn(struct int_list_cn*);
static struct node_cn* convert_to_struct_node_cn(struct node);
static struct int_list_cn* convert_to_struct_int_list_cn(struct int_list);
/* RECORD FUNCTIONS */

/* CN FUNCTIONS */

static struct node_cn* Node(struct Dll*);
static struct seq* Left(struct Dll*);
static struct seq* Right(struct Dll*);
static struct seq* rev(struct seq*);
static struct seq* snoc(struct seq*, cn_integer*);
static struct seq* append(struct seq*, struct seq*);
static struct seq* tl(struct seq*);
static cn_integer* hd(struct seq*);
static cn_bool* addr_eq(cn_pointer*, cn_pointer*);
static cn_bool* prov_eq(cn_pointer*, cn_pointer*);
static cn_bool* ptr_eq(cn_pointer*, cn_pointer*);
static cn_bool* is_null(cn_pointer*);
static cn_bool* not(cn_bool*);
static cn_integer* MINu8();
static cn_integer* MAXu8();
static cn_integer* MINu16();
static cn_integer* MAXu16();
static cn_integer* MINu32();
static cn_integer* MAXu32();
static cn_integer* MINu64();
static cn_integer* MAXu64();
static cn_integer* MINi8();
static cn_integer* MAXi8();
static cn_integer* MINi16();
static cn_integer* MAXi16();
static cn_integer* MINi32();
static cn_integer* MAXi32();
static cn_integer* MINi64();
static cn_integer* MAXi64();

static struct Dll* Dll_at(cn_pointer*, enum spec_mode, struct loop_ownership*);
static struct seq* Own_Backwards(cn_pointer*, cn_pointer*, struct node_cn*, enum spec_mode, struct loop_ownership*);
static struct seq* Own_Forwards(cn_pointer*, cn_pointer*, struct node_cn*, enum spec_mode, struct loop_ownership*);
static struct seq* IntList(cn_pointer*, enum spec_mode, struct loop_ownership*);
enum CN_GHOST_ENUM {
  CLEARED,
  EMPTY
};
#ifndef offsetof
#define offsetof(st, m) ((__cerbty_size_t)__builtin_offsetof(st, m))
#endif
#pragma GCC diagnostic ignored "-Wattributes"

/* GLOBAL ACCESSORS */
void* memcpy(void* dest, const void* src, __cerbty_size_t count );

// Some gcc builtins we support
[[ cerb::hidden ]] int __builtin_ffs (int x);
[[ cerb::hidden ]] int __builtin_ffsl (long x);
[[ cerb::hidden ]] int __builtin_ffsll (long long x);
[[ cerb::hidden ]] int __builtin_ctz (unsigned int x);
[[ cerb::hidden ]] int __builtin_ctzl (unsigned long x);
[[ cerb::hidden ]] int __builtin_ctzll (unsigned long long x);
[[ cerb::hidden ]] __cerbty_uint16_t __builtin_bswap16 (__cerbty_uint16_t x);
[[ cerb::hidden ]] __cerbty_uint32_t __builtin_bswap32 (__cerbty_uint32_t x);
[[ cerb::hidden ]] __cerbty_uint64_t __builtin_bswap64 (__cerbty_uint64_t x);
[[ cerb::hidden ]] void __builtin_unreachable(void);
// this is an optimisation hint that we can erase
struct int_list;
extern struct int_list *mallocIntList();
/*@ spec mallocIntList();
    requires true;
    ensures take u = Block<struct int_list>(return);
@*/
extern void freeIntList (struct int_list *p);
/*@ spec freeIntList(pointer p);
    requires take u = Block<struct int_list>(p);
    ensures true;
@*/

/*@
function (integer) hd (datatype seq xs) {
  match xs {
    Seq_Nil {} => {
      0
    }
    Seq_Cons {head : h, tail : _} => {
      h
    }
  }
}

function (datatype seq) tl (datatype seq xs) {
  match xs {
    Seq_Nil {} => {
      Seq_Nil {}
    }
    Seq_Cons {head : _, tail : tail} => {
      tail
    }
  }
}
@*/
struct int_list* IntList_nil()
/*@ ensures take ret = IntList(return);
            ret == Seq_Nil{};
 @*/
{
  /* EXECUTABLE CN PRECONDITION */
  struct int_list* __cn_ret;
  cn_bump_frame_id __cn_bump_count_a_830 = cn_bump_get_frame_id();
  ghost_stack_depth_incr();
  enum CN_GHOST_ENUM ghost_spec = EMPTY;
  if (ghost_spec != (enum CN_GHOST_ENUM) top_ghost_frame_tag())
  cn_ghost_arg_failure();
else
  ;
  pop_ghost_frame();
  
  { __cn_ret = 0; goto __cn_epilogue; }

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

{
  cn_pointer* return_cn = convert_to_cn_pointer(__cn_ret);
  update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/dll_add/20261018-scope-recheck/cn_original_Dbl_Linked_List__add/empty_element_4/input.cn.c:67:18:");
  struct seq* ret_cn = IntList(return_cn, POST, 0);
  cn_pop_msg_info();
  update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/dll_add/20261018-scope-recheck/cn_original_Dbl_Linked_List__add/empty_element_4/input.cn.c:68:13-30");
  struct seq* a_816 = (struct seq*) cn_bump_malloc(sizeof(struct seq));
  a_816->tag = SEQ_NIL;
  cn_assert(struct_seq_equality(ret_cn, a_816), POST);
  cn_pop_msg_info();
  ghost_stack_depth_decr();
  update_cn_error_message_info(0);
  cn_postcondition_leak_check();
  cn_pop_msg_info();
}

  cn_bump_free_after(__cn_bump_count_a_830);

return __cn_ret;

}
struct int_list* IntList_cons(int h, struct int_list* t)
/*@ requires take l = IntList(t);
    ensures take ret = IntList(return);
            ret == Seq_Cons{ head: h, tail: l};
 @*/
{
  /* EXECUTABLE CN PRECONDITION */
  struct int_list* __cn_ret;
  cn_bump_frame_id __cn_bump_count_a_877 = cn_bump_get_frame_id();
  ghost_stack_depth_incr();
  enum CN_GHOST_ENUM ghost_spec = EMPTY;
  if (ghost_spec != (enum CN_GHOST_ENUM) top_ghost_frame_tag())
  cn_ghost_arg_failure();
else
  ;
  cn_integer* h_cn = convert_to_cn_integer(h);
  cn_pointer* t_cn = convert_to_cn_pointer(t);
  pop_ghost_frame();
  update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/dll_add/20261018-scope-recheck/cn_original_Dbl_Linked_List__add/empty_element_4/input.cn.c:74:19:");
  struct seq* l_cn = IntList(t_cn, PRE, 0);
  cn_pop_msg_info();
  
	/* C OWNERSHIP */

  c_add_to_ghost_state((&h), sizeof(signed int), get_cn_stack_depth());
  cn_pointer* h_addr_cn = convert_to_cn_pointer((&h));
  c_add_to_ghost_state((&t), sizeof(struct int_list*), get_cn_stack_depth());
  cn_pointer* t_addr_cn = convert_to_cn_pointer((&t));
  
  struct int_list *p = (
({
  push_ghost_frame(EMPTY, 0);
  (void) 0;
})
, mallocIntList());
c_add_to_ghost_state((&p), sizeof(struct int_list*), get_cn_stack_depth());


cn_pointer* p_addr_cn = convert_to_cn_pointer((&p));

  CN_STORE(CN_LOAD(p)->head, CN_LOAD(h));
  CN_STORE(CN_LOAD(p)->tail, CN_LOAD(t));
  { __cn_ret = CN_LOAD(p); 
c_remove_from_ghost_state((&p), sizeof(struct int_list*));
goto __cn_epilogue; }

c_remove_from_ghost_state((&p), sizeof(struct int_list*));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  
	/* C OWNERSHIP */


  c_remove_from_ghost_state((&h), sizeof(signed int));

  c_remove_from_ghost_state((&t), sizeof(struct int_list*));

{
  cn_pointer* return_cn = convert_to_cn_pointer(__cn_ret);
  update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/dll_add/20261018-scope-recheck/cn_original_Dbl_Linked_List__add/empty_element_4/input.cn.c:75:18:");
  struct seq* ret_cn = IntList(return_cn, POST, 0);
  cn_pop_msg_info();
  update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/dll_add/20261018-scope-recheck/cn_original_Dbl_Linked_List__add/empty_element_4/input.cn.c:76:13-48");
  struct seq* a_863 = (struct seq*) cn_bump_malloc(sizeof(struct seq));
  a_863->tag = SEQ_CONS;
  a_863->u.seq_cons = (struct seq_cons*) cn_bump_malloc(sizeof(struct seq_cons));
  a_863->u.seq_cons->head = h_cn;
  a_863->u.seq_cons->tail = l_cn;
  cn_assert(struct_seq_equality(ret_cn, a_863), POST);
  cn_pop_msg_info();
  ghost_stack_depth_decr();
  update_cn_error_message_info(0);
  cn_postcondition_leak_check();
  cn_pop_msg_info();
}

  cn_bump_free_after(__cn_bump_count_a_877);

return __cn_ret;

}
// append.h
/*@
function [rec] (datatype seq) append(datatype seq xs, datatype seq ys) {
  match xs {
    Seq_Nil {} => {
      ys
    }
    Seq_Cons {head : h, tail : zs}  => {
      Seq_Cons {head: h, tail: append(zs, ys)}
    }
  }
}
@*/
/*@
function [rec] (datatype seq) snoc(datatype seq xs, integer y) {
  match xs {
    Seq_Nil {} => {
      Seq_Cons {head: y, tail: Seq_Nil{}}
    }
    Seq_Cons {head: x, tail: zs}  => {
      Seq_Cons{head: x, tail: snoc (zs, y)}
    }
  }
}
@*/
/*@
function [rec] (datatype seq) rev(datatype seq xs) {
  match xs {
    Seq_Nil {} => {
      Seq_Nil {}
    }
    Seq_Cons {head : h, tail : zs}  => {
      snoc (rev(zs), h)
    }
  }
}
@*/
struct node;

/*@
function (datatype seq) Right (datatype Dll L) {
    match L {
        Empty_Dll {} => { Seq_Nil{} }
        Dll {left: _, curr: _, right: r} => { r }
    }
}

function (datatype seq) Left (datatype Dll L) {
    match L {
        Empty_Dll {} => { Seq_Nil {} }
        Dll {left: l, curr: _, right: _} => { l }
    }
}

function (struct node) Node (datatype Dll L) {
    match L {
        Empty_Dll {} => {  default<struct node> }
        Dll {left: _, curr: n, right: _} => { n }
    }
}
@*/
extern struct node *malloc_node();
/*@ spec malloc_node();
    requires true;
    ensures take u = Block<struct node>(return);
            !ptr_eq(return,NULL);
@*/
extern void free_node (struct node *p);
/*@ spec free_node(pointer p);
    requires take u = Block<struct node>(p);
    ensures true;
@*/
/*@
predicate [rec] (datatype seq) Own_Forwards(pointer p, pointer prev_pointer, struct node prev_node) {
    if (is_null(p)) {
        return Seq_Nil{};
    } else {
        take n = Owned<struct node>(p);
        assert (ptr_eq(n.prev, prev_pointer));
        assert(ptr_eq(prev_node.next, p));
        take Right = Own_Forwards(n.next, p, n);
        return Seq_Cons{head: n.data, tail: Right};
    }
}

predicate [rec] (datatype seq) Own_Backwards(pointer p, pointer next_pointer, struct node next_node) {
    if (is_null(p)) {
        return Seq_Nil{};
    } else {
        take n = Owned<struct node>(p);
        assert (ptr_eq(n.next, next_pointer));
        assert(ptr_eq(next_node.prev, p));
        take Left = Own_Backwards(n.prev, p, n);
        return Seq_Cons{head: n.data, tail: Left};
    }
}

predicate (datatype Dll) Dll_at (pointer p) {
    if (is_null(p)) {
        return Empty_Dll{};
    } else {
        take n = Owned<struct node>(p);
        take Left = Own_Backwards(n.prev, p, n);
        take Right = Own_Forwards(n.next, p, n);
        return Dll{left: Left, curr: n, right: Right};
    }
}
@*/
// Adds after the given node and returns a pointer to the new node
struct node *add(int element, struct node *n)
/*@ requires take Before = Dll_at(n);
    ensures  take After = Dll_at(return);

             is_null(n) ? After == Dll { left: Seq_Nil{}, curr: Node(After), right: Seq_Nil{}}
                        : After == Dll { left: Seq_Cons{head: Node(Before).data, tail: Left(Before)}, curr: Node(After), right: Right(Before)};
@*/
{
  /* EXECUTABLE CN PRECONDITION */
  struct node* __cn_ret;
  cn_bump_frame_id __cn_bump_count_a_973 = cn_bump_get_frame_id();
  ghost_stack_depth_incr();
  enum CN_GHOST_ENUM ghost_spec = EMPTY;
  if (ghost_spec != (enum CN_GHOST_ENUM) top_ghost_frame_tag())
  cn_ghost_arg_failure();
else
  ;
  cn_integer* element_cn = convert_to_cn_integer(element);
  cn_pointer* n_cn = convert_to_cn_pointer(n);
  pop_ghost_frame();
  update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/dll_add/20261018-scope-recheck/cn_original_Dbl_Linked_List__add/empty_element_4/input.cn.c:203:19:");
  struct Dll* Before_cn = Dll_at(n_cn, PRE, 0);
  cn_pop_msg_info();
  
	/* C OWNERSHIP */

  c_add_to_ghost_state((&element), sizeof(signed int), get_cn_stack_depth());
  cn_pointer* element_addr_cn = convert_to_cn_pointer((&element));
  c_add_to_ghost_state((&n), sizeof(struct node*), get_cn_stack_depth());
  cn_pointer* n_addr_cn = convert_to_cn_pointer((&n));
  
    struct node *new_node = (
({
  push_ghost_frame(EMPTY, 0);
  (void) 0;
})
, malloc_node());
c_add_to_ghost_state((&new_node), sizeof(struct node*), get_cn_stack_depth());


cn_pointer* new_node_addr_cn = convert_to_cn_pointer((&new_node));

    CN_STORE(CN_LOAD(new_node)->data, CN_LOAD(element));
    CN_STORE(CN_LOAD(new_node)->prev, 0);
    CN_STORE(CN_LOAD(new_node)->next, 0);
    if (CN_LOAD(n) == 0) //empty list case
    {
        CN_STORE(CN_LOAD(new_node)->prev, 0);
        CN_STORE(CN_LOAD(new_node)->next, 0);
        { __cn_ret = CN_LOAD(new_node); 
c_remove_from_ghost_state((&new_node), sizeof(struct node*));
goto __cn_epilogue; }
    } else {
        
        CN_STORE(CN_LOAD(new_node)->next, CN_LOAD(CN_LOAD(n)->next));
        CN_STORE(CN_LOAD(new_node)->prev, CN_LOAD(n));
        if (CN_LOAD(CN_LOAD(n)->next) !=0) {
            
            CN_STORE(CN_LOAD(CN_LOAD(n)->next)->prev, CN_LOAD(new_node));
        }
        CN_STORE(CN_LOAD(n)->next, CN_LOAD(new_node));
        { __cn_ret = CN_LOAD(new_node); 
c_remove_from_ghost_state((&new_node), sizeof(struct node*));
goto __cn_epilogue; }
    }

c_remove_from_ghost_state((&new_node), sizeof(struct node*));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  
	/* C OWNERSHIP */


  c_remove_from_ghost_state((&element), sizeof(signed int));

  c_remove_from_ghost_state((&n), sizeof(struct node*));

{
  cn_pointer* return_cn = convert_to_cn_pointer(__cn_ret);
  update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/dll_add/20261018-scope-recheck/cn_original_Dbl_Linked_List__add/empty_element_4/input.cn.c:204:19:");
  struct Dll* After_cn = Dll_at(return_cn, POST, 0);
  cn_pop_msg_info();
  update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/dll_add/20261018-scope-recheck/cn_original_Dbl_Linked_List__add/empty_element_4/input.cn.c:206:14-207:144");
  cn_bool* a_942;
  if (convert_from_cn_bool(is_null(n_cn))) {
    struct Dll* a_945 = (struct Dll*) cn_bump_malloc(sizeof(struct Dll));
    a_945->tag = DLL;
    struct seq* a_947 = (struct seq*) cn_bump_malloc(sizeof(struct seq));
    a_947->tag = SEQ_NIL;
    struct seq* a_950 = (struct seq*) cn_bump_malloc(sizeof(struct seq));
    a_950->tag = SEQ_NIL;
    a_945->u.dll = (struct dll*) cn_bump_malloc(sizeof(struct dll));
    a_945->u.dll->left = a_947;
    a_945->u.dll->curr = Node(After_cn);
    a_945->u.dll->right = a_950;
    a_942 = struct_Dll_equality(After_cn, a_945);
  }
  else {
    struct Dll* a_956 = (struct Dll*) cn_bump_malloc(sizeof(struct Dll));
    a_956->tag = DLL;
    struct seq* a_958 = (struct seq*) cn_bump_malloc(sizeof(struct seq));
    a_958->tag = SEQ_CONS;
    a_958->u.seq_cons = (struct seq_cons*) cn_bump_malloc(sizeof(struct seq_cons));
    a_958->u.seq_cons->head = Node(Before_cn)->data;
    a_958->u.seq_cons->tail = Left(Before_cn);
    a_956->u.dll = (struct dll*) cn_bump_malloc(sizeof(struct dll));
    a_956->u.dll->left = a_958;
    a_956->u.dll->curr = Node(After_cn);
    a_956->u.dll->right = Right(Before_cn);
    a_942 = struct_Dll_equality(After_cn, a_956);
  }
  cn_assert(a_942, POST);
  cn_pop_msg_info();
  ghost_stack_depth_decr();
  update_cn_error_message_info(0);
  cn_postcondition_leak_check();
  cn_pop_msg_info();
}

  cn_bump_free_after(__cn_bump_count_a_973);

return __cn_ret;

}
int main(void) /*@ ensures return == 0; @*/ {
  /* EXECUTABLE CN PRECONDITION */
  signed int __cn_ret = 0;
  fulminate_init((struct fulm_init_config){.max_bump_blocks= 0, .bump_block_size= 0, .flags= (struct fulm_init_flags){.with_ghost_args= 1, .source_locs_mode= 0, .correct_missing_ownership= 0, .ownership_stack_mode= 0}});
   struct node *n=(
({
  push_ghost_frame(EMPTY, 0);
  (void) 0;
})
, add(1,0));
c_add_to_ghost_state((&n), sizeof(struct node*), get_cn_stack_depth());


cn_pointer* n_addr_cn = convert_to_cn_pointer((&n));
 (
({
  push_ghost_frame(EMPTY, 0);
  (void) 0;
})
, free_node(CN_LOAD(n))); { __cn_ret = 0; 
c_remove_from_ghost_state((&n), sizeof(struct node*));
goto __cn_epilogue; } 
c_remove_from_ghost_state((&n), sizeof(struct node*));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:
;

return __cn_ret;

}

/* RECORD */

/* CONVERSION */

/* GENERATED STRUCT FUNCTIONS */

static struct Dll* default_struct_Dll()
{
  struct Dll* res = (struct Dll*) cn_bump_malloc(sizeof(struct Dll));
  res->tag = EMPTY_DLL;
  res->u.empty_dll = (struct empty_dll*) cn_bump_malloc(sizeof(struct empty_dll));
  return res;
}
static struct seq* default_struct_seq()
{
  struct seq* res = (struct seq*) cn_bump_malloc(sizeof(struct seq));
  res->tag = SEQ_NIL;
  res->u.seq_nil = (struct seq_nil*) cn_bump_malloc(sizeof(struct seq_nil));
  return res;
}
static void* cn_map_get_struct_Dll(cn_map* m, cn_integer* key)
{
  void* ret = ht_get(m, (&key->val));
  if (0 == ret)
    return (void*) default_struct_Dll();
  else
    return ret;
}
static void* cn_map_get_struct_seq(cn_map* m, cn_integer* key)
{
  void* ret = ht_get(m, (&key->val));
  if (0 == ret)
    return (void*) default_struct_seq();
  else
    return ret;
}
static struct node_cn* default_struct_node_cn()
{
  struct node_cn* a_1399 = (struct node_cn*) cn_bump_malloc(sizeof(struct node_cn));
  a_1399->data = default_cn_integer();
  a_1399->prev = default_cn_pointer();
  a_1399->next = default_cn_pointer();
  return a_1399;
}
static struct int_list_cn* default_struct_int_list_cn()
{
  struct int_list_cn* a_1392 = (struct int_list_cn*) cn_bump_malloc(sizeof(struct int_list_cn));
  a_1392->head = default_cn_integer();
  a_1392->tail = default_cn_pointer();
  return a_1392;
}
static void* cn_map_get_struct_node_cn(cn_map* m, cn_integer* key)
{
  void* ret = ht_get(m, (&key->val));
  if (0 == ret)
    return (void*) default_struct_node_cn();
  else
    return ret;
}
static void* cn_map_get_struct_int_list_cn(cn_map* m, cn_integer* key)
{
  void* ret = ht_get(m, (&key->val));
  if (0 == ret)
    return (void*) default_struct_int_list_cn();
  else
    return ret;
}
static cn_bool* struct_Dll_equality(struct Dll* x, struct Dll* y)
{
  if (x->tag != y->tag)
    return convert_to_cn_bool(0);
  else
    switch (x->tag)
  {
    case EMPTY_DLL:
    {
      return convert_to_cn_bool(1);
    }
    case DLL:
    {
      struct dll* a_1356 = x->u.dll;
      struct dll* a_1357 = y->u.dll;
      return cn_bool_and(struct_seq_equality(a_1356->right, a_1357->right), cn_bool_and(struct_node_cn_equality(a_1356->curr, a_1357->curr), cn_bool_and(struct_seq_equality(a_1356->left, a_1357->left), convert_to_cn_bool(1))));
    }
  }
  return (void*) 0;
}
static cn_bool* struct_seq_equality(struct seq* x, struct seq* y)
{
  if (x->tag != y->tag)
    return convert_to_cn_bool(0);
  else
    switch (x->tag)
  {
    case SEQ_NIL:
    {
      return convert_to_cn_bool(1);
    }
    case SEQ_CONS:
    {
      struct seq_cons* a_1332 = x->u.seq_cons;
      struct seq_cons* a_1333 = y->u.seq_cons;
      return cn_bool_and(struct_seq_equality(a_1332->tail, a_1333->tail), cn_bool_and(cn_integer_equality(a_1332->head, a_1333->head), convert_to_cn_bool(1)));
    }
  }
  return (void*) 0;
}
static cn_bool* struct_node_cn_equality(void* x, void* y)
{
  struct node_cn* x_cast = (struct node_cn*) x;
  struct node_cn* y_cast = (struct node_cn*) y;
  return cn_bool_and(cn_bool_and(cn_bool_and(convert_to_cn_bool(true), cn_integer_equality(x_cast->data, y_cast->data)), cn_pointer_equality(x_cast->prev, y_cast->prev)), cn_pointer_equality(x_cast->next, y_cast->next));
}
static cn_bool* struct_int_list_cn_equality(void* x, void* y)
{
  struct int_list_cn* x_cast = (struct int_list_cn*) x;
  struct int_list_cn* y_cast = (struct int_list_cn*) y;
  return cn_bool_and(cn_bool_and(convert_to_cn_bool(true), cn_integer_equality(x_cast->head, y_cast->head)), cn_pointer_equality(x_cast->tail, y_cast->tail));
}
static struct node convert_from_struct_node_cn(struct node_cn* node)
{
  struct node res;
  res.data = convert_from_cn_integer(node->data);
  res.prev = convert_from_cn_pointer(node->prev);
  res.next = convert_from_cn_pointer(node->next);
  return res;
}
static struct int_list convert_from_struct_int_list_cn(struct int_list_cn* int_list)
{
  struct int_list res;
  res.head = convert_from_cn_integer(int_list->head);
  res.tail = convert_from_cn_pointer(int_list->tail);
  return res;
}
static struct node_cn* convert_to_struct_node_cn(struct node node)
{
  struct node_cn* res = (struct node_cn*) cn_bump_malloc(sizeof(struct node_cn));
  res->data = convert_to_cn_integer(node.data);
  res->prev = convert_to_cn_pointer(node.prev);
  res->next = convert_to_cn_pointer(node.next);
  return res;
}
static struct int_list_cn* convert_to_struct_int_list_cn(struct int_list int_list)
{
  struct int_list_cn* res = (struct int_list_cn*) cn_bump_malloc(sizeof(struct int_list_cn));
  res->head = convert_to_cn_integer(int_list.head);
  res->tail = convert_to_cn_pointer(int_list.tail);
  return res;
}
/* OWNERSHIP FUNCTIONS */

/* OWNERSHIP FUNCTIONS */

static struct int_list_cn* deref_struct_int_list(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  return convert_to_struct_int_list_cn((*(struct int_list*) cn_ptr->ptr));
}
static struct node_cn* deref_struct_node(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  return convert_to_struct_node_cn((*(struct node*) cn_ptr->ptr));
}
static struct int_list_cn* owned_struct_int_list(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  void* generic_c_ptr = (void*) (struct int_list*) cn_ptr->ptr;
  cn_get_or_put_ownership(spec_mode, generic_c_ptr, sizeof(struct int_list), loop_ownership);
  return convert_to_struct_int_list_cn((*(struct int_list*) cn_ptr->ptr));
}
static struct node_cn* owned_struct_node(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  void* generic_c_ptr = (void*) (struct node*) cn_ptr->ptr;
  cn_get_or_put_ownership(spec_mode, generic_c_ptr, sizeof(struct node), loop_ownership);
  return convert_to_struct_node_cn((*(struct node*) cn_ptr->ptr));
}
/* CN FUNCTIONS */
static struct node_cn* Node(struct Dll* L)
{
  switch (L->tag)
  {
    case EMPTY_DLL:
    {
      struct empty_dll* empty_dll_1 = L->u.empty_dll;
      return default_struct_node_cn();
    }
    case DLL:
    {
      struct dll* dll_1 = L->u.dll;
      struct node_cn* n = dll_1->curr;
      return n;
    }
    default:
    abort();
  }
}
static struct seq* Left(struct Dll* L)
{
  switch (L->tag)
  {
    case EMPTY_DLL:
    {
      struct empty_dll* empty_dll_1 = L->u.empty_dll;
      struct seq* a_1181 = (struct seq*) cn_bump_malloc(sizeof(struct seq));
      a_1181->tag = SEQ_NIL;
      return a_1181;
    }
    case DLL:
    {
      struct dll* dll_1 = L->u.dll;
      struct seq* l = dll_1->left;
      return l;
    }
    default:
    abort();
  }
}
static struct seq* Right(struct Dll* L)
{
  switch (L->tag)
  {
    case EMPTY_DLL:
    {
      struct empty_dll* empty_dll_1 = L->u.empty_dll;
      struct seq* a_1171 = (struct seq*) cn_bump_malloc(sizeof(struct seq));
      a_1171->tag = SEQ_NIL;
      return a_1171;
    }
    case DLL:
    {
      struct dll* dll_1 = L->u.dll;
      struct seq* r = dll_1->right;
      return r;
    }
    default:
    abort();
  }
}
static struct seq* rev(struct seq* xs)
{
  switch (xs->tag)
  {
    case SEQ_NIL:
    {
      struct seq_nil* seq_nil_1 = xs->u.seq_nil;
      struct seq* a_1160 = (struct seq*) cn_bump_malloc(sizeof(struct seq));
      a_1160->tag = SEQ_NIL;
      return a_1160;
    }
    case SEQ_CONS:
    {
      struct seq_cons* seq_cons_1 = xs->u.seq_cons;
      struct seq* zs = seq_cons_1->tail;
      cn_integer* h = seq_cons_1->head;
      return snoc(rev(zs), h);
    }
    default:
    abort();
  }
}
static struct seq* snoc(struct seq* xs, cn_integer* y)
{
  switch (xs->tag)
  {
    case SEQ_NIL:
    {
      struct seq_nil* seq_nil_1 = xs->u.seq_nil;
      struct seq* a_1142 = (struct seq*) cn_bump_malloc(sizeof(struct seq));
      a_1142->tag = SEQ_CONS;
      struct seq* a_1144 = (struct seq*) cn_bump_malloc(sizeof(struct seq));
      a_1144->tag = SEQ_NIL;
      a_1142->u.seq_cons = (struct seq_cons*) cn_bump_malloc(sizeof(struct seq_cons));
      a_1142->u.seq_cons->head = y;
      a_1142->u.seq_cons->tail = a_1144;
      return a_1142;
    }
    case SEQ_CONS:
    {
      struct seq_cons* seq_cons_1 = xs->u.seq_cons;
      struct seq* zs = seq_cons_1->tail;
      cn_integer* x = seq_cons_1->head;
      struct seq* a_1152 = (struct seq*) cn_bump_malloc(sizeof(struct seq));
      a_1152->tag = SEQ_CONS;
      a_1152->u.seq_cons = (struct seq_cons*) cn_bump_malloc(sizeof(struct seq_cons));
      a_1152->u.seq_cons->head = x;
      a_1152->u.seq_cons->tail = snoc(zs, y);
      return a_1152;
    }
    default:
    abort();
  }
}
static struct seq* append(struct seq* xs, struct seq* ys)
{
  switch (xs->tag)
  {
    case SEQ_NIL:
    {
      struct seq_nil* seq_nil_1 = xs->u.seq_nil;
      return ys;
    }
    case SEQ_CONS:
    {
      struct seq_cons* seq_cons_1 = xs->u.seq_cons;
      struct seq* zs = seq_cons_1->tail;
      cn_integer* h = seq_cons_1->head;
      struct seq* a_1135 = (struct seq*) cn_bump_malloc(sizeof(struct seq));
      a_1135->tag = SEQ_CONS;
      a_1135->u.seq_cons = (struct seq_cons*) cn_bump_malloc(sizeof(struct seq_cons));
      a_1135->u.seq_cons->head = h;
      a_1135->u.seq_cons->tail = append(zs, ys);
      return a_1135;
    }
    default:
    abort();
  }
}
static struct seq* tl(struct seq* xs)
{
  switch (xs->tag)
  {
    case SEQ_NIL:
    {
      struct seq_nil* seq_nil_1 = xs->u.seq_nil;
      struct seq* a_1121 = (struct seq*) cn_bump_malloc(sizeof(struct seq));
      a_1121->tag = SEQ_NIL;
      return a_1121;
    }
    case SEQ_CONS:
    {
      struct seq_cons* seq_cons_1 = xs->u.seq_cons;
      struct seq* tail = seq_cons_1->tail;
      return tail;
    }
    default:
    abort();
  }
}
static cn_integer* hd(struct seq* xs)
{
  switch (xs->tag)
  {
    case SEQ_NIL:
    {
      struct seq_nil* seq_nil_1 = xs->u.seq_nil;
      return convert_to_cn_integer(0);
    }
    case SEQ_CONS:
    {
      struct seq_cons* seq_cons_1 = xs->u.seq_cons;
      cn_integer* h = seq_cons_1->head;
      return h;
    }
    default:
    abort();
  }
}
static cn_bool* addr_eq(cn_pointer* arg1, cn_pointer* arg2)
{
  return cn_integer_equality(cast_cn_pointer_to_cn_integer(arg1), cast_cn_pointer_to_cn_integer(arg2));
}
static cn_bool* prov_eq(cn_pointer* arg1, cn_pointer* arg2)
{
  return cn_alloc_id_equality(convert_to_cn_alloc_id(0), convert_to_cn_alloc_id(0));
}
static cn_bool* ptr_eq(cn_pointer* arg1, cn_pointer* arg2)
{
  return cn_pointer_equality(arg1, arg2);
}
static cn_bool* is_null(cn_pointer* arg)
{
  return cn_pointer_equality(arg, convert_to_cn_pointer(0));
}
static cn_bool* not(cn_bool* arg)
{
  return cn_bool_not(arg);
}
static cn_integer* MINu8()
{
  return convert_to_cn_integer(0);
}
static cn_integer* MAXu8()
{
  return convert_to_cn_integer(255);
}
static cn_integer* MINu16()
{
  return convert_to_cn_integer(0);
}
static cn_integer* MAXu16()
{
  return convert_to_cn_integer(65535);
}
static cn_integer* MINu32()
{
  return convert_to_cn_integer(0);
}
static cn_integer* MAXu32()
{
  return convert_to_cn_integer(4294967295);
}
static cn_integer* MINu64()
{
  return convert_to_cn_integer(0);
}
static cn_integer* MAXu64()
{
  return convert_to_cn_integer(18446744073709551615);
}
static cn_integer* MINi8()
{
  return convert_to_cn_integer(-128);
}
static cn_integer* MAXi8()
{
  return convert_to_cn_integer(127);
}
static cn_integer* MINi16()
{
  return convert_to_cn_integer(-32768);
}
static cn_integer* MAXi16()
{
  return convert_to_cn_integer(32767);
}
static cn_integer* MINi32()
{
  return convert_to_cn_integer(-2147483648);
}
static cn_integer* MAXi32()
{
  return convert_to_cn_integer(2147483647);
}
static cn_integer* MINi64()
{
  return convert_to_cn_integer(-9223372036854775808);
}
static cn_integer* MAXi64()
{
  return convert_to_cn_integer(9223372036854775807);
}


/* CN PREDICATES */

static struct Dll* Dll_at(cn_pointer* p, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  if (convert_from_cn_bool(is_null(p))) {
    struct Dll* a_1241 = (struct Dll*) cn_bump_malloc(sizeof(struct Dll));
    a_1241->tag = EMPTY_DLL;
    return a_1241;
  }
  else {
    update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/dll_add/20261018-scope-recheck/cn_original_Dbl_Linked_List__add/empty_element_4/input.cn.c:194:14:");
    struct node_cn* n = owned_struct_node(p, spec_mode, loop_ownership);
    cn_pop_msg_info();
    update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/dll_add/20261018-scope-recheck/cn_original_Dbl_Linked_List__add/empty_element_4/input.cn.c:195:14:");
    struct seq* Left = Own_Backwards(n->prev, p, n, spec_mode, loop_ownership);
    cn_pop_msg_info();
    update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/dll_add/20261018-scope-recheck/cn_original_Dbl_Linked_List__add/empty_element_4/input.cn.c:196:14:");
    struct seq* Right = Own_Forwards(n->next, p, n, spec_mode, loop_ownership);
    cn_pop_msg_info();
    struct Dll* a_1249 = (struct Dll*) cn_bump_malloc(sizeof(struct Dll));
    a_1249->tag = DLL;
    a_1249->u.dll = (struct dll*) cn_bump_malloc(sizeof(struct dll));
    a_1249->u.dll->left = Left;
    a_1249->u.dll->curr = n;
    a_1249->u.dll->right = Right;
    return a_1249;
  }
}
static struct seq* Own_Backwards(cn_pointer* p, cn_pointer* next_pointer, struct node_cn* next_node, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  if (convert_from_cn_bool(is_null(p))) {
    struct seq* a_1226 = (struct seq*) cn_bump_malloc(sizeof(struct seq));
    a_1226->tag = SEQ_NIL;
    return a_1226;
  }
  else {
    update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/dll_add/20261018-scope-recheck/cn_original_Dbl_Linked_List__add/empty_element_4/input.cn.c:182:14:");
    struct node_cn* n = owned_struct_node(p, spec_mode, loop_ownership);
    cn_pop_msg_info();
    update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/dll_add/20261018-scope-recheck/cn_original_Dbl_Linked_List__add/empty_element_4/input.cn.c:183:9-186:50");
    cn_assert(ptr_eq(n->next, next_pointer), spec_mode);
    cn_pop_msg_info();
    update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/dll_add/20261018-scope-recheck/cn_original_Dbl_Linked_List__add/empty_element_4/input.cn.c:184:9-186:50");
    cn_assert(ptr_eq(next_node->prev, p), spec_mode);
    cn_pop_msg_info();
    update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/dll_add/20261018-scope-recheck/cn_original_Dbl_Linked_List__add/empty_element_4/input.cn.c:185:14:");
    struct seq* Left = Own_Backwards(n->prev, p, n, spec_mode, loop_ownership);
    cn_pop_msg_info();
    struct seq* a_1235 = (struct seq*) cn_bump_malloc(sizeof(struct seq));
    a_1235->tag = SEQ_CONS;
    a_1235->u.seq_cons = (struct seq_cons*) cn_bump_malloc(sizeof(struct seq_cons));
    a_1235->u.seq_cons->head = n->data;
    a_1235->u.seq_cons->tail = Left;
    return a_1235;
  }
}
static struct seq* Own_Forwards(cn_pointer* p, cn_pointer* prev_pointer, struct node_cn* prev_node, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  if (convert_from_cn_bool(is_null(p))) {
    struct seq* a_1211 = (struct seq*) cn_bump_malloc(sizeof(struct seq));
    a_1211->tag = SEQ_NIL;
    return a_1211;
  }
  else {
    update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/dll_add/20261018-scope-recheck/cn_original_Dbl_Linked_List__add/empty_element_4/input.cn.c:170:14:");
    struct node_cn* n = owned_struct_node(p, spec_mode, loop_ownership);
    cn_pop_msg_info();
    update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/dll_add/20261018-scope-recheck/cn_original_Dbl_Linked_List__add/empty_element_4/input.cn.c:171:9-174:51");
    cn_assert(ptr_eq(n->prev, prev_pointer), spec_mode);
    cn_pop_msg_info();
    update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/dll_add/20261018-scope-recheck/cn_original_Dbl_Linked_List__add/empty_element_4/input.cn.c:172:9-174:51");
    cn_assert(ptr_eq(prev_node->next, p), spec_mode);
    cn_pop_msg_info();
    update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/dll_add/20261018-scope-recheck/cn_original_Dbl_Linked_List__add/empty_element_4/input.cn.c:173:14:");
    struct seq* Right = Own_Forwards(n->next, p, n, spec_mode, loop_ownership);
    cn_pop_msg_info();
    struct seq* a_1220 = (struct seq*) cn_bump_malloc(sizeof(struct seq));
    a_1220->tag = SEQ_CONS;
    a_1220->u.seq_cons = (struct seq_cons*) cn_bump_malloc(sizeof(struct seq_cons));
    a_1220->u.seq_cons->head = n->data;
    a_1220->u.seq_cons->tail = Right;
    return a_1220;
  }
}
static struct seq* IntList(cn_pointer* p, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  if (convert_from_cn_bool(is_null(p))) {
    struct seq* a_1200 = (struct seq*) cn_bump_malloc(sizeof(struct seq));
    a_1200->tag = SEQ_NIL;
    return a_1200;
  }
  else {
    update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/dll_add/20261018-scope-recheck/cn_original_Dbl_Linked_List__add/empty_element_4/input.cn.c:37:10:");
    struct int_list_cn* H = owned_struct_int_list(p, spec_mode, loop_ownership);
    cn_pop_msg_info();
    update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/dll_add/20261018-scope-recheck/cn_original_Dbl_Linked_List__add/empty_element_4/input.cn.c:38:10:");
    struct seq* tl = IntList(H->tail, spec_mode, loop_ownership);
    cn_pop_msg_info();
    struct seq* a_1207 = (struct seq*) cn_bump_malloc(sizeof(struct seq));
    a_1207->tag = SEQ_CONS;
    a_1207->u.seq_cons = (struct seq_cons*) cn_bump_malloc(sizeof(struct seq_cons));
    a_1207->u.seq_cons->head = H->head;
    a_1207->u.seq_cons->tail = tl;
    return a_1207;
  }
}

/* CN LEMMAS */

