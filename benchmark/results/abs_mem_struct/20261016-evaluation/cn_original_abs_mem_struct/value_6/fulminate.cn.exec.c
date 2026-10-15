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

struct tuple {
  signed int x;
  signed int y;
};


/* CN VERSIONS OF C STRUCTS */

struct tuple_cn {
  cn_bits_i32* x;
  cn_bits_i32* y;
};



/* OWNERSHIP FUNCTIONS */

static cn_bits_i32* deref_signed_int(cn_pointer*, enum spec_mode, struct loop_ownership*);
static struct tuple_cn* deref_struct_tuple(cn_pointer*, enum spec_mode, struct loop_ownership*);
static cn_bits_i32* owned_signed_int(cn_pointer*, enum spec_mode, struct loop_ownership*);
static struct tuple_cn* owned_struct_tuple(cn_pointer*, enum spec_mode, struct loop_ownership*);
/* CONVERSION FUNCTIONS */

/* GENERATED STRUCT FUNCTIONS */

static struct tuple_cn* default_struct_tuple_cn();
static void* cn_map_get_struct_tuple_cn(cn_map*, cn_integer*);
static cn_bool* struct_tuple_cn_equality(void*, void*);
static struct tuple convert_from_struct_tuple_cn(struct tuple_cn*);
static struct tuple_cn* convert_to_struct_tuple_cn(struct tuple);
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

# 0 "/home/yangfp/teSpec/benchmark/programs/abs_mem_struct/variants/cn_original_abs_mem_struct/tests/20261016-evaluation/value_6/fulminate.cn.c"
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
# 1 "/home/yangfp/teSpec/benchmark/programs/abs_mem_struct/variants/cn_original_abs_mem_struct/tests/20261016-evaluation/value_6/fulminate.cn.c"
int abs_mem (int *p)
/* --BEGIN-- */
/*@ requires take x = Owned<int>(p);
             MINi32() < x;
    ensures take x2 = Owned<int>(p);
            x == x2;
            return == ((x >= 0i32) ? x : (0i32-x));
@*/
/* --END-- */
{
  /* EXECUTABLE CN PRECONDITION */
  signed int __cn_ret;
  cn_bump_frame_id __cn_bump_count_a_664 = cn_bump_get_frame_id();
  ghost_stack_depth_incr();
  enum CN_GHOST_ENUM ghost_spec = EMPTY;
  if (ghost_spec != (enum CN_GHOST_ENUM) top_ghost_frame_tag())
  cn_ghost_arg_failure();
else
  ;
  cn_pointer* p_cn = convert_to_cn_pointer(p);
  pop_ghost_frame();
  update_cn_error_message_info("/*@ requires take x = Owned<int>(p);\n                  ^/home/yangfp/teSpec/benchmark/programs/abs_mem_struct/variants/cn_original_abs_mem_struct/tests/20261016-evaluation/value_6/fulminate.cn.c:3:19:");
  cn_bits_i32* x_cn = owned_signed_int(p_cn, PRE, 0);
  cn_pop_msg_info();
  update_cn_error_message_info("             MINi32() < x;\n             ^~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/abs_mem_struct/variants/cn_original_abs_mem_struct/tests/20261016-evaluation/value_6/fulminate.cn.c:4:14-27");
  cn_assert(cn_bits_i32_lt(MINi32(), x_cn), PRE);
  cn_pop_msg_info();
  
	/* C OWNERSHIP */

  c_add_to_ghost_state((&p), sizeof(signed int*), get_cn_stack_depth());
  cn_pointer* p_addr_cn = convert_to_cn_pointer((&p));
  
  int x = CN_LOAD(*CN_LOAD(p));
c_add_to_ghost_state((&x), sizeof(signed int), get_cn_stack_depth());


cn_pointer* x_addr_cn = convert_to_cn_pointer((&x));

  if (CN_LOAD(x) >= 0) {
    { __cn_ret = CN_LOAD(x); 
c_remove_from_ghost_state((&x), sizeof(signed int));
goto __cn_epilogue; }
  }
  else {
    { __cn_ret = -CN_LOAD(x); 
c_remove_from_ghost_state((&x), sizeof(signed int));
goto __cn_epilogue; }
  }

c_remove_from_ghost_state((&x), sizeof(signed int));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  
	/* C OWNERSHIP */


  c_remove_from_ghost_state((&p), sizeof(signed int*));

{
  cn_bits_i32* return_cn = convert_to_cn_bits_i32(__cn_ret);
  update_cn_error_message_info("    ensures take x2 = Owned<int>(p);\n                 ^/home/yangfp/teSpec/benchmark/programs/abs_mem_struct/variants/cn_original_abs_mem_struct/tests/20261016-evaluation/value_6/fulminate.cn.c:5:18:");
  cn_bits_i32* x2_cn = owned_signed_int(p_cn, POST, 0);
  cn_pop_msg_info();
  update_cn_error_message_info("            x == x2;\n            ^~~~~~~~ /home/yangfp/teSpec/benchmark/programs/abs_mem_struct/variants/cn_original_abs_mem_struct/tests/20261016-evaluation/value_6/fulminate.cn.c:6:13-21");
  cn_assert(cn_bits_i32_equality(x_cn, x2_cn), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("            return == ((x >= 0i32) ? x : (0i32-x));\n            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/abs_mem_struct/variants/cn_original_abs_mem_struct/tests/20261016-evaluation/value_6/fulminate.cn.c:7:13-52");
  cn_bits_i32* a_644;
  if (convert_from_cn_bool(cn_bits_i32_le(convert_to_cn_bits_i32(0LL), x_cn))) {
    a_644 = x_cn;
  }
  else {
    a_644 = cn_bits_i32_sub(convert_to_cn_bits_i32(0LL), x_cn);
  }
  cn_assert(cn_bits_i32_equality(return_cn, a_644), POST);
  cn_pop_msg_info();
  ghost_stack_depth_decr();
  cn_postcondition_leak_check();
}

  cn_bump_free_after(__cn_bump_count_a_664);

return __cn_ret;

}
struct tuple;
int abs_y (struct tuple *p)
/*@ requires take s = Owned(p);
             MINi32() < s.y;
    ensures  take s2 = Owned(p);
             s == s2;
             return == ((s.y >= 0i32) ? s.y : (0i32-s.y));
@*/
{
  /* EXECUTABLE CN PRECONDITION */
  signed int __cn_ret;
  cn_bump_frame_id __cn_bump_count_a_719 = cn_bump_get_frame_id();
  ghost_stack_depth_incr();
  enum CN_GHOST_ENUM ghost_spec = EMPTY;
  if (ghost_spec != (enum CN_GHOST_ENUM) top_ghost_frame_tag())
  cn_ghost_arg_failure();
else
  ;
  cn_pointer* p_cn = convert_to_cn_pointer(p);
  pop_ghost_frame();
  update_cn_error_message_info("/*@ requires take s = Owned(p);\n                  ^/home/yangfp/teSpec/benchmark/programs/abs_mem_struct/variants/cn_original_abs_mem_struct/tests/20261016-evaluation/value_6/fulminate.cn.c:24:19:");
  struct tuple_cn* s_cn = owned_struct_tuple(p_cn, PRE, 0);
  cn_pop_msg_info();
  update_cn_error_message_info("             MINi32() < s.y;\n             ^~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/abs_mem_struct/variants/cn_original_abs_mem_struct/tests/20261016-evaluation/value_6/fulminate.cn.c:25:14-29");
  cn_assert(cn_bits_i32_lt(MINi32(), s_cn->y), PRE);
  cn_pop_msg_info();
  
	/* C OWNERSHIP */

  c_add_to_ghost_state((&p), sizeof(struct tuple*), get_cn_stack_depth());
  cn_pointer* p_addr_cn = convert_to_cn_pointer((&p));
  
  { __cn_ret = (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, abs_mem(&CN_LOAD(p)->y)); goto __cn_epilogue; }

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  
	/* C OWNERSHIP */


  c_remove_from_ghost_state((&p), sizeof(struct tuple*));

{
  cn_bits_i32* return_cn = convert_to_cn_bits_i32(__cn_ret);
  update_cn_error_message_info("    ensures  take s2 = Owned(p);\n                  ^/home/yangfp/teSpec/benchmark/programs/abs_mem_struct/variants/cn_original_abs_mem_struct/tests/20261016-evaluation/value_6/fulminate.cn.c:26:19:");
  struct tuple_cn* s2_cn = owned_struct_tuple(p_cn, POST, 0);
  cn_pop_msg_info();
  update_cn_error_message_info("             s == s2;\n             ^~~~~~~~ /home/yangfp/teSpec/benchmark/programs/abs_mem_struct/variants/cn_original_abs_mem_struct/tests/20261016-evaluation/value_6/fulminate.cn.c:27:14-22");
  cn_assert(struct_tuple_cn_equality(s_cn, s2_cn), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             return == ((s.y >= 0i32) ? s.y : (0i32-s.y));\n             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/abs_mem_struct/variants/cn_original_abs_mem_struct/tests/20261016-evaluation/value_6/fulminate.cn.c:28:14-59");
  cn_bits_i32* a_699;
  if (convert_from_cn_bool(cn_bits_i32_le(convert_to_cn_bits_i32(0LL), s_cn->y))) {
    a_699 = s_cn->y;
  }
  else {
    a_699 = cn_bits_i32_sub(convert_to_cn_bits_i32(0LL), s_cn->y);
  }
  cn_assert(cn_bits_i32_equality(return_cn, a_699), POST);
  cn_pop_msg_info();
  ghost_stack_depth_decr();
  cn_postcondition_leak_check();
}

  cn_bump_free_after(__cn_bump_count_a_719);

return __cn_ret;

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
   struct tuple cell = { .x = -7, .y = 2147483647 };
c_add_to_ghost_state((&cell), sizeof(struct tuple), get_cn_stack_depth());


cn_pointer* cell_addr_cn = convert_to_cn_pointer((&cell));
 (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, abs_y(&cell)); { __cn_ret = 0; 
c_remove_from_ghost_state((&cell), sizeof(struct tuple));
goto __cn_epilogue; } 
c_remove_from_ghost_state((&cell), sizeof(struct tuple));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  free_ghost_frame_stack();

return __cn_ret;

}

/* RECORD */

/* CONVERSION */

/* GENERATED STRUCT FUNCTIONS */

static struct tuple_cn* default_struct_tuple_cn()
{
  struct tuple_cn* a_878 = (struct tuple_cn*) cn_bump_malloc(sizeof(struct tuple_cn));
  a_878->x = default_cn_bits_i32();
  a_878->y = default_cn_bits_i32();
  return a_878;
}
static void* cn_map_get_struct_tuple_cn(cn_map* m, cn_integer* key)
{
  void* ret = ht_get(m, (&key->val));
  if (0 == ret)
    return (void*) default_struct_tuple_cn();
  else
    return ret;
}
static cn_bool* struct_tuple_cn_equality(void* x, void* y)
{
  struct tuple_cn* x_cast = (struct tuple_cn*) x;
  struct tuple_cn* y_cast = (struct tuple_cn*) y;
  return cn_bool_and(cn_bool_and(convert_to_cn_bool(true), cn_bits_i32_equality(x_cast->x, y_cast->x)), cn_bits_i32_equality(x_cast->y, y_cast->y));
}
static struct tuple convert_from_struct_tuple_cn(struct tuple_cn* tuple)
{
  struct tuple res;
  res.x = convert_from_cn_bits_i32(tuple->x);
  res.y = convert_from_cn_bits_i32(tuple->y);
  return res;
}
static struct tuple_cn* convert_to_struct_tuple_cn(struct tuple tuple)
{
  struct tuple_cn* res = (struct tuple_cn*) cn_bump_malloc(sizeof(struct tuple_cn));
  res->x = convert_to_cn_bits_i32(tuple.x);
  res->y = convert_to_cn_bits_i32(tuple.y);
  return res;
}
/* OWNERSHIP FUNCTIONS */

/* OWNERSHIP FUNCTIONS */

static cn_bits_i32* deref_signed_int(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  return convert_to_cn_bits_i32((*(signed int*) cn_ptr->ptr));
}
static struct tuple_cn* deref_struct_tuple(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  return convert_to_struct_tuple_cn((*(struct tuple*) cn_ptr->ptr));
}
static cn_bits_i32* owned_signed_int(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  void* generic_c_ptr = (void*) (signed int*) cn_ptr->ptr;
  cn_get_or_put_ownership(spec_mode, generic_c_ptr, sizeof(signed int), loop_ownership);
  return convert_to_cn_bits_i32((*(signed int*) cn_ptr->ptr));
}
static struct tuple_cn* owned_struct_tuple(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  void* generic_c_ptr = (void*) (struct tuple*) cn_ptr->ptr;
  cn_get_or_put_ownership(spec_mode, generic_c_ptr, sizeof(struct tuple), loop_ownership);
  return convert_to_struct_tuple_cn((*(struct tuple*) cn_ptr->ptr));
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

