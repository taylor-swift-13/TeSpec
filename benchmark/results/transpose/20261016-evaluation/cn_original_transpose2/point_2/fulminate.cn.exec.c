#define __CN_INSTRUMENT
#include <cn-executable/utils.h>
#include <cn-executable/cerb_types.h>
typedef __cerbty_intptr_t intptr_t;
typedef __cerbty_uintptr_t uintptr_t;
typedef __cerbty_intmax_t intmax_t;
typedef __cerbty_uintmax_t uintmax_t;
static const int __cerbvar_INT_MAX = 0x7fffffff;
static const int __cerbvar_INT_MIN = ~0x7fffffff;
static const unsigned long long __cerbvar_SIZE_MAX = ~(0ULL);
_Noreturn void abort(void);
/* ORIGINAL C STRUCTS AND UNIONS */

struct upoint {
  unsigned int x;
  unsigned int y;
};


/* CN VERSIONS OF C STRUCTS */

struct upoint_cn {
  cn_bits_u32* x;
  cn_bits_u32* y;
};



/* OWNERSHIP FUNCTIONS */

static cn_bits_u32* deref_unsigned_int(cn_pointer*, enum spec_mode, struct loop_ownership*);
static struct upoint_cn* deref_struct_upoint(cn_pointer*, enum spec_mode, struct loop_ownership*);
static cn_bits_u32* owned_unsigned_int(cn_pointer*, enum spec_mode, struct loop_ownership*);
static struct upoint_cn* owned_struct_upoint(cn_pointer*, enum spec_mode, struct loop_ownership*);
/* CONVERSION FUNCTIONS */

/* GENERATED STRUCT FUNCTIONS */

static struct upoint_cn* default_struct_upoint_cn();
static void* cn_map_get_struct_upoint_cn(cn_map*, cn_integer*);
static cn_bool* struct_upoint_cn_equality(void*, void*);
static struct upoint convert_from_struct_upoint_cn(struct upoint_cn*);
static struct upoint_cn* convert_to_struct_upoint_cn(struct upoint);
/* RECORD FUNCTIONS */

/* CN FUNCTIONS */

static cn_bool* addr_eq(cn_pointer*, cn_pointer*);
static cn_bool* prov_eq(cn_pointer*, cn_pointer*);
static cn_bool* ptr_eq(cn_pointer*, cn_pointer*);
static cn_bool* is_null(cn_pointer*);
static cn_bool* not(cn_bool*);
static cn_bits_u8* MINu8();
static cn_bits_u8* MAXu8();
static cn_bits_u16* MINu16();
static cn_bits_u16* MAXu16();
static cn_bits_u32* MINu32();
static cn_bits_u32* MAXu32();
static cn_bits_u64* MINu64();
static cn_bits_u64* MAXu64();
static cn_bits_i8* MINi8();
static cn_bits_i8* MAXi8();
static cn_bits_i16* MINi16();
static cn_bits_i16* MAXi16();
static cn_bits_i32* MINi32();
static cn_bits_i32* MAXi32();
static cn_bits_i64* MINi64();
static cn_bits_i64* MAXi64();

enum CN_GHOST_ENUM {
  CLEARED,
  EMPTY
};
#ifndef offsetof
#define offsetof(st, m) ((__cerbty_size_t)((char *)&((st *)0)->m - (char *)0))
#endif
#pragma GCC diagnostic ignored "-Wattributes"

/* GLOBAL ACCESSORS */
void* memcpy(void* dest, const void* src, __cerbty_size_t count );

# 0 "/home/yangfp/teSpec/benchmark/programs/transpose/variants/cn_original_transpose2/tests/20261016-evaluation/point_2/fulminate.cn.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "/home/yangfp/.opam/tespec-cn-20260416/lib/cerberus-lib/runtime/libc/include/builtins.h" 1
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
# 0 "<command-line>" 2
# 1 "/home/yangfp/teSpec/benchmark/programs/transpose/variants/cn_original_transpose2/tests/20261016-evaluation/point_2/fulminate.cn.c"
void swap (unsigned int *p, unsigned int *q)
/*@ requires take v = Owned<unsigned int>(p);
             take w = Owned<unsigned int>(q);
    ensures  take v2 = Owned<unsigned int>(p);
             take w2 = Owned<unsigned int>(q);
             v2 == w && w2 == v;
@*/
{
  /* EXECUTABLE CN PRECONDITION */
  cn_bump_frame_id __cn_bump_count_a_679 = cn_bump_get_frame_id();
  ghost_stack_depth_incr();
  enum CN_GHOST_ENUM ghost_spec = EMPTY;
  if (ghost_spec != (enum CN_GHOST_ENUM) top_ghost_frame_tag())
  cn_ghost_arg_failure();
else
  ;
  cn_pointer* p_cn = convert_to_cn_pointer(p);
  cn_pointer* q_cn = convert_to_cn_pointer(q);
  pop_ghost_frame();
  update_cn_error_message_info("/*@ requires take v = Owned<unsigned int>(p);\n                  ^/home/yangfp/teSpec/benchmark/programs/transpose/variants/cn_original_transpose2/tests/20261016-evaluation/point_2/fulminate.cn.c:2:19:");
  cn_bits_u32* v_cn = owned_unsigned_int(p_cn, PRE, 0);
  cn_pop_msg_info();
  update_cn_error_message_info("             take w = Owned<unsigned int>(q);\n                  ^/home/yangfp/teSpec/benchmark/programs/transpose/variants/cn_original_transpose2/tests/20261016-evaluation/point_2/fulminate.cn.c:3:19:");
  cn_bits_u32* w_cn = owned_unsigned_int(q_cn, PRE, 0);
  cn_pop_msg_info();
  
	/* C OWNERSHIP */

  c_add_to_ghost_state((&p), sizeof(unsigned int*), get_cn_stack_depth());
  cn_pointer* p_addr_cn = convert_to_cn_pointer((&p));
  c_add_to_ghost_state((&q), sizeof(unsigned int*), get_cn_stack_depth());
  cn_pointer* q_addr_cn = convert_to_cn_pointer((&q));
  
  unsigned int m = CN_LOAD(*CN_LOAD(p));
c_add_to_ghost_state((&m), sizeof(unsigned int), get_cn_stack_depth());


cn_pointer* m_addr_cn = convert_to_cn_pointer((&m));

  unsigned int n = CN_LOAD(*CN_LOAD(q));
c_add_to_ghost_state((&n), sizeof(unsigned int), get_cn_stack_depth());


cn_pointer* n_addr_cn = convert_to_cn_pointer((&n));

  CN_STORE(*CN_LOAD(p), CN_LOAD(n));
  CN_STORE(*CN_LOAD(q), CN_LOAD(m));

c_remove_from_ghost_state((&m), sizeof(unsigned int));


c_remove_from_ghost_state((&n), sizeof(unsigned int));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  
	/* C OWNERSHIP */


  c_remove_from_ghost_state((&p), sizeof(unsigned int*));

  c_remove_from_ghost_state((&q), sizeof(unsigned int*));

{
  update_cn_error_message_info("    ensures  take v2 = Owned<unsigned int>(p);\n                  ^/home/yangfp/teSpec/benchmark/programs/transpose/variants/cn_original_transpose2/tests/20261016-evaluation/point_2/fulminate.cn.c:4:19:");
  cn_bits_u32* v2_cn = owned_unsigned_int(p_cn, POST, 0);
  cn_pop_msg_info();
  update_cn_error_message_info("             take w2 = Owned<unsigned int>(q);\n                  ^/home/yangfp/teSpec/benchmark/programs/transpose/variants/cn_original_transpose2/tests/20261016-evaluation/point_2/fulminate.cn.c:5:19:");
  cn_bits_u32* w2_cn = owned_unsigned_int(q_cn, POST, 0);
  cn_pop_msg_info();
  update_cn_error_message_info("             v2 == w && w2 == v;\n             ^~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/transpose/variants/cn_original_transpose2/tests/20261016-evaluation/point_2/fulminate.cn.c:6:14-33");
  cn_assert(cn_bool_and(cn_bits_u32_equality(v2_cn, w_cn), cn_bits_u32_equality(w2_cn, v_cn)), POST);
  cn_pop_msg_info();
  ghost_stack_depth_decr();
  cn_postcondition_leak_check();
}

  cn_bump_free_after(__cn_bump_count_a_679);
}

struct upoint;

void transpose2 (struct upoint *p)
/* --BEGIN-- */
/*@ requires take s = Owned<struct upoint>(p);
    ensures take s2 = Owned<struct upoint>(p);
            s2.x == s.y;
            s2.y == s.x;
@*/
{
  /* EXECUTABLE CN PRECONDITION */
  cn_bump_frame_id __cn_bump_count_a_716 = cn_bump_get_frame_id();
  ghost_stack_depth_incr();
  enum CN_GHOST_ENUM ghost_spec = EMPTY;
  if (ghost_spec != (enum CN_GHOST_ENUM) top_ghost_frame_tag())
  cn_ghost_arg_failure();
else
  ;
  cn_pointer* p_cn = convert_to_cn_pointer(p);
  pop_ghost_frame();
  update_cn_error_message_info("/*@ requires take s = Owned<struct upoint>(p);\n                  ^/home/yangfp/teSpec/benchmark/programs/transpose/variants/cn_original_transpose2/tests/20261016-evaluation/point_2/fulminate.cn.c:19:19:");
  struct upoint_cn* s_cn = owned_struct_upoint(p_cn, PRE, 0);
  cn_pop_msg_info();
  
	/* C OWNERSHIP */

  c_add_to_ghost_state((&p), sizeof(struct upoint*), get_cn_stack_depth());
  cn_pointer* p_addr_cn = convert_to_cn_pointer((&p));
  
  (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, swap(&CN_LOAD(p)->x, &CN_LOAD(p)->y));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  
	/* C OWNERSHIP */


  c_remove_from_ghost_state((&p), sizeof(struct upoint*));

{
  update_cn_error_message_info("    ensures take s2 = Owned<struct upoint>(p);\n                 ^/home/yangfp/teSpec/benchmark/programs/transpose/variants/cn_original_transpose2/tests/20261016-evaluation/point_2/fulminate.cn.c:20:18:");
  struct upoint_cn* s2_cn = owned_struct_upoint(p_cn, POST, 0);
  cn_pop_msg_info();
  update_cn_error_message_info("            s2.x == s.y;\n            ^~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/transpose/variants/cn_original_transpose2/tests/20261016-evaluation/point_2/fulminate.cn.c:21:13-25");
  cn_assert(cn_bits_u32_equality(s2_cn->x, s_cn->y), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("            s2.y == s.x;\n            ^~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/transpose/variants/cn_original_transpose2/tests/20261016-evaluation/point_2/fulminate.cn.c:22:13-25");
  cn_assert(cn_bits_u32_equality(s2_cn->y, s_cn->x), POST);
  cn_pop_msg_info();
  ghost_stack_depth_decr();
  cn_postcondition_leak_check();
}

  cn_bump_free_after(__cn_bump_count_a_716);
}
/* --END-- */

int main(void) /*@ ensures return == 0i32; @*/ {
  /* EXECUTABLE CN PRECONDITION */
  signed int __cn_ret = 0;
  initialise_ownership_ghost_state();
  initialise_ghost_stack_depth();
  initialise_ghost_frame_stack();
  initialise_exec_c_locs_mode(0);
  initialise_correct_missing_ownership(0);
  initialise_ownership_stack_mode(0);
   struct upoint point = {.x = 0u, .y = 1u};
c_add_to_ghost_state((&point), sizeof(struct upoint), get_cn_stack_depth());


cn_pointer* point_addr_cn = convert_to_cn_pointer((&point));
 (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, transpose2(&point)); { __cn_ret = 0; 
c_remove_from_ghost_state((&point), sizeof(struct upoint));
goto __cn_epilogue; } 
c_remove_from_ghost_state((&point), sizeof(struct upoint));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  free_ghost_frame_stack();

return __cn_ret;

}

/* RECORD */

/* CONVERSION */

/* GENERATED STRUCT FUNCTIONS */

static struct upoint_cn* default_struct_upoint_cn()
{
  struct upoint_cn* a_875 = (struct upoint_cn*) cn_bump_malloc(sizeof(struct upoint_cn));
  a_875->x = default_cn_bits_u32();
  a_875->y = default_cn_bits_u32();
  return a_875;
}
static void* cn_map_get_struct_upoint_cn(cn_map* m, cn_integer* key)
{
  void* ret = ht_get(m, (&key->val));
  if (0 == ret)
    return (void*) default_struct_upoint_cn();
  else
    return ret;
}
static cn_bool* struct_upoint_cn_equality(void* x, void* y)
{
  struct upoint_cn* x_cast = (struct upoint_cn*) x;
  struct upoint_cn* y_cast = (struct upoint_cn*) y;
  return cn_bool_and(cn_bool_and(convert_to_cn_bool(true), cn_bits_u32_equality(x_cast->x, y_cast->x)), cn_bits_u32_equality(x_cast->y, y_cast->y));
}
static struct upoint convert_from_struct_upoint_cn(struct upoint_cn* upoint)
{
  struct upoint res;
  res.x = convert_from_cn_bits_u32(upoint->x);
  res.y = convert_from_cn_bits_u32(upoint->y);
  return res;
}
static struct upoint_cn* convert_to_struct_upoint_cn(struct upoint upoint)
{
  struct upoint_cn* res = (struct upoint_cn*) cn_bump_malloc(sizeof(struct upoint_cn));
  res->x = convert_to_cn_bits_u32(upoint.x);
  res->y = convert_to_cn_bits_u32(upoint.y);
  return res;
}
/* OWNERSHIP FUNCTIONS */

/* OWNERSHIP FUNCTIONS */

static cn_bits_u32* deref_unsigned_int(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  return convert_to_cn_bits_u32((*(unsigned int*) cn_ptr->ptr));
}
static struct upoint_cn* deref_struct_upoint(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  return convert_to_struct_upoint_cn((*(struct upoint*) cn_ptr->ptr));
}
static cn_bits_u32* owned_unsigned_int(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  void* generic_c_ptr = (void*) (unsigned int*) cn_ptr->ptr;
  cn_get_or_put_ownership(spec_mode, generic_c_ptr, sizeof(unsigned int), loop_ownership);
  return convert_to_cn_bits_u32((*(unsigned int*) cn_ptr->ptr));
}
static struct upoint_cn* owned_struct_upoint(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  void* generic_c_ptr = (void*) (struct upoint*) cn_ptr->ptr;
  cn_get_or_put_ownership(spec_mode, generic_c_ptr, sizeof(struct upoint), loop_ownership);
  return convert_to_struct_upoint_cn((*(struct upoint*) cn_ptr->ptr));
}
/* CN FUNCTIONS */
static cn_bool* addr_eq(cn_pointer* arg1, cn_pointer* arg2)
{
  return cn_bits_u64_equality(cast_cn_pointer_to_cn_bits_u64(arg1), cast_cn_pointer_to_cn_bits_u64(arg2));
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
static cn_bits_u8* MINu8()
{
  return convert_to_cn_bits_u8(0UL);
}
static cn_bits_u8* MAXu8()
{
  return convert_to_cn_bits_u8(255UL);
}
static cn_bits_u16* MINu16()
{
  return convert_to_cn_bits_u16(0ULL);
}
static cn_bits_u16* MAXu16()
{
  return convert_to_cn_bits_u16(65535ULL);
}
static cn_bits_u32* MINu32()
{
  return convert_to_cn_bits_u32(0ULL);
}
static cn_bits_u32* MAXu32()
{
  return convert_to_cn_bits_u32(4294967295ULL);
}
static cn_bits_u64* MINu64()
{
  return convert_to_cn_bits_u64(0ULL);
}
static cn_bits_u64* MAXu64()
{
  return convert_to_cn_bits_u64(18446744073709551615ULL);
}
static cn_bits_i8* MINi8()
{
  return convert_to_cn_bits_i8((-127L - 1L));
}
static cn_bits_i8* MAXi8()
{
  return convert_to_cn_bits_i8(127L);
}
static cn_bits_i16* MINi16()
{
  return convert_to_cn_bits_i16((-32767LL - 1LL));
}
static cn_bits_i16* MAXi16()
{
  return convert_to_cn_bits_i16(32767LL);
}
static cn_bits_i32* MINi32()
{
  return convert_to_cn_bits_i32((-2147483647LL - 1LL));
}
static cn_bits_i32* MAXi32()
{
  return convert_to_cn_bits_i32(2147483647LL);
}
static cn_bits_i64* MINi64()
{
  return convert_to_cn_bits_i64((-9223372036854775807LL - 1LL));
}
static cn_bits_i64* MAXi64()
{
  return convert_to_cn_bits_i64(9223372036854775807LL);
}


/* CN PREDICATES */


/* CN LEMMAS */

