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

struct point {
  signed int x;
  signed int y;
};


/* CN VERSIONS OF C STRUCTS */

struct point_cn {
  cn_bits_i32* x;
  cn_bits_i32* y;
};



/* OWNERSHIP FUNCTIONS */

static struct point_cn* deref_struct_point(cn_pointer*, enum spec_mode, struct loop_ownership*);
static struct point_cn* owned_struct_point(cn_pointer*, enum spec_mode, struct loop_ownership*);
/* CONVERSION FUNCTIONS */

/* GENERATED STRUCT FUNCTIONS */

static struct point_cn* default_struct_point_cn();
static void* cn_map_get_struct_point_cn(cn_map*, cn_integer*);
static cn_bool* struct_point_cn_equality(void*, void*);
static struct point convert_from_struct_point_cn(struct point_cn*);
static struct point_cn* convert_to_struct_point_cn(struct point);
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

# 0 "/home/yangfp/teSpec/benchmark/programs/transpose/variants/cn_original_transpose/tests/20261016-evaluation/point_5/fulminate.cn.c"
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
# 1 "/home/yangfp/teSpec/benchmark/programs/transpose/variants/cn_original_transpose/tests/20261016-evaluation/point_5/fulminate.cn.c"
struct point;

void transpose (struct point *p)
/*@ requires take s = Owned<struct point>(p);
    ensures take s2 = Owned<struct point>(p);
            s2.x == s.y;
            s2.y == s.x;
@*/
{
  /* EXECUTABLE CN PRECONDITION */
  cn_bump_frame_id __cn_bump_count_a_630 = cn_bump_get_frame_id();
  ghost_stack_depth_incr();
  enum CN_GHOST_ENUM ghost_spec = EMPTY;
  if (ghost_spec != (enum CN_GHOST_ENUM) top_ghost_frame_tag())
  cn_ghost_arg_failure();
else
  ;
  cn_pointer* p_cn = convert_to_cn_pointer(p);
  pop_ghost_frame();
  update_cn_error_message_info("/*@ requires take s = Owned<struct point>(p);\n                  ^/home/yangfp/teSpec/benchmark/programs/transpose/variants/cn_original_transpose/tests/20261016-evaluation/point_5/fulminate.cn.c:4:19:");
  struct point_cn* s_cn = owned_struct_point(p_cn, PRE, 0);
  cn_pop_msg_info();
  
	/* C OWNERSHIP */

  c_add_to_ghost_state((&p), sizeof(struct point*), get_cn_stack_depth());
  cn_pointer* p_addr_cn = convert_to_cn_pointer((&p));
  
  int temp_x = CN_LOAD(CN_LOAD(p)->x);
c_add_to_ghost_state((&temp_x), sizeof(signed int), get_cn_stack_depth());


cn_pointer* temp_x_addr_cn = convert_to_cn_pointer((&temp_x));

  int temp_y = CN_LOAD(CN_LOAD(p)->y);
c_add_to_ghost_state((&temp_y), sizeof(signed int), get_cn_stack_depth());


cn_pointer* temp_y_addr_cn = convert_to_cn_pointer((&temp_y));

  CN_STORE(CN_LOAD(p)->x, CN_LOAD(temp_y));
  CN_STORE(CN_LOAD(p)->y, CN_LOAD(temp_x));

c_remove_from_ghost_state((&temp_x), sizeof(signed int));


c_remove_from_ghost_state((&temp_y), sizeof(signed int));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  
	/* C OWNERSHIP */


  c_remove_from_ghost_state((&p), sizeof(struct point*));

{
  update_cn_error_message_info("    ensures take s2 = Owned<struct point>(p);\n                 ^/home/yangfp/teSpec/benchmark/programs/transpose/variants/cn_original_transpose/tests/20261016-evaluation/point_5/fulminate.cn.c:5:18:");
  struct point_cn* s2_cn = owned_struct_point(p_cn, POST, 0);
  cn_pop_msg_info();
  update_cn_error_message_info("            s2.x == s.y;\n            ^~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/transpose/variants/cn_original_transpose/tests/20261016-evaluation/point_5/fulminate.cn.c:6:13-25");
  cn_assert(cn_bits_i32_equality(s2_cn->x, s_cn->y), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("            s2.y == s.x;\n            ^~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/transpose/variants/cn_original_transpose/tests/20261016-evaluation/point_5/fulminate.cn.c:7:13-25");
  cn_assert(cn_bits_i32_equality(s2_cn->y, s_cn->x), POST);
  cn_pop_msg_info();
  ghost_stack_depth_decr();
  cn_postcondition_leak_check();
}

  cn_bump_free_after(__cn_bump_count_a_630);
}

int main(void) /*@ ensures return == 0i32; @*/ {
  /* EXECUTABLE CN PRECONDITION */
  signed int __cn_ret = 0;
  initialise_ownership_ghost_state();
  initialise_ghost_stack_depth();
  initialise_ghost_frame_stack();
  initialise_exec_c_locs_mode(0);
  initialise_correct_missing_ownership(0);
  initialise_ownership_stack_mode(0);
   struct point point = {.x = 2147483647, .y = (-2147483647 - 1)};
c_add_to_ghost_state((&point), sizeof(struct point), get_cn_stack_depth());


cn_pointer* point_addr_cn = convert_to_cn_pointer((&point));
 (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, transpose(&point)); { __cn_ret = 0; 
c_remove_from_ghost_state((&point), sizeof(struct point));
goto __cn_epilogue; } 
c_remove_from_ghost_state((&point), sizeof(struct point));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  free_ghost_frame_stack();

return __cn_ret;

}

/* RECORD */

/* CONVERSION */

/* GENERATED STRUCT FUNCTIONS */

static struct point_cn* default_struct_point_cn()
{
  struct point_cn* a_789 = (struct point_cn*) cn_bump_malloc(sizeof(struct point_cn));
  a_789->x = default_cn_bits_i32();
  a_789->y = default_cn_bits_i32();
  return a_789;
}
static void* cn_map_get_struct_point_cn(cn_map* m, cn_integer* key)
{
  void* ret = ht_get(m, (&key->val));
  if (0 == ret)
    return (void*) default_struct_point_cn();
  else
    return ret;
}
static cn_bool* struct_point_cn_equality(void* x, void* y)
{
  struct point_cn* x_cast = (struct point_cn*) x;
  struct point_cn* y_cast = (struct point_cn*) y;
  return cn_bool_and(cn_bool_and(convert_to_cn_bool(true), cn_bits_i32_equality(x_cast->x, y_cast->x)), cn_bits_i32_equality(x_cast->y, y_cast->y));
}
static struct point convert_from_struct_point_cn(struct point_cn* point)
{
  struct point res;
  res.x = convert_from_cn_bits_i32(point->x);
  res.y = convert_from_cn_bits_i32(point->y);
  return res;
}
static struct point_cn* convert_to_struct_point_cn(struct point point)
{
  struct point_cn* res = (struct point_cn*) cn_bump_malloc(sizeof(struct point_cn));
  res->x = convert_to_cn_bits_i32(point.x);
  res->y = convert_to_cn_bits_i32(point.y);
  return res;
}
/* OWNERSHIP FUNCTIONS */

/* OWNERSHIP FUNCTIONS */

static struct point_cn* deref_struct_point(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  return convert_to_struct_point_cn((*(struct point*) cn_ptr->ptr));
}
static struct point_cn* owned_struct_point(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  void* generic_c_ptr = (void*) (struct point*) cn_ptr->ptr;
  cn_get_or_put_ownership(spec_mode, generic_c_ptr, sizeof(struct point), loop_ownership);
  return convert_to_struct_point_cn((*(struct point*) cn_ptr->ptr));
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

