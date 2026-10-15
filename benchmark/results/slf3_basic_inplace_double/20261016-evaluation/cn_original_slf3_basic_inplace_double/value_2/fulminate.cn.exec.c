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


/* CN VERSIONS OF C STRUCTS */



/* OWNERSHIP FUNCTIONS */

static cn_bits_i32* deref_signed_int(cn_pointer*, enum spec_mode, struct loop_ownership*);
static cn_bits_i32* owned_signed_int(cn_pointer*, enum spec_mode, struct loop_ownership*);
/* CONVERSION FUNCTIONS */

/* GENERATED STRUCT FUNCTIONS */

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

# 0 "/home/yangfp/teSpec/benchmark/programs/slf3_basic_inplace_double/variants/cn_original_slf3_basic_inplace_double/tests/20261016-evaluation/value_2/fulminate.cn.c"
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
# 1 "/home/yangfp/teSpec/benchmark/programs/slf3_basic_inplace_double/variants/cn_original_slf3_basic_inplace_double/tests/20261016-evaluation/value_2/fulminate.cn.c"
# 1 "/home/yangfp/.opam/tespec-cn-20260416/lib/cerberus-lib/runtime/libc/include/limits.h" 1
# 25 "/home/yangfp/.opam/tespec-cn-20260416/lib/cerberus-lib/runtime/libc/include/limits.h"
// POSIX
# 2 "/home/yangfp/teSpec/benchmark/programs/slf3_basic_inplace_double/variants/cn_original_slf3_basic_inplace_double/tests/20261016-evaluation/value_2/fulminate.cn.c" 2

void inplace_double (int *p)
/* --BEGIN-- */
/*@ requires take n_ = Owned<int>(p);
             let r = 2i64 * ((i64) n_);
             (i64)MINi32() <= r; r <= (i64)MAXi32();
    ensures  take m_ = Owned<int>(p);
             m_ == (i32) r;
@*/
/* --END-- */
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
  update_cn_error_message_info("/*@ requires take n_ = Owned<int>(p);\n                  ^/home/yangfp/teSpec/benchmark/programs/slf3_basic_inplace_double/variants/cn_original_slf3_basic_inplace_double/tests/20261016-evaluation/value_2/fulminate.cn.c:5:19:");
  cn_bits_i32* n__cn = owned_signed_int(p_cn, PRE, 0);
  cn_pop_msg_info();
  cn_bits_i64* r_cn;
  r_cn = cn_bits_i64_multiply(convert_to_cn_bits_i64(2LL), cast_cn_bits_i32_to_cn_bits_i64(n__cn));
  update_cn_error_message_info("             (i64)MINi32() <= r; r <= (i64)MAXi32();\n             ^~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/slf3_basic_inplace_double/variants/cn_original_slf3_basic_inplace_double/tests/20261016-evaluation/value_2/fulminate.cn.c:7:14-33");
  cn_assert(cn_bits_i64_le(cast_cn_bits_i32_to_cn_bits_i64(MINi32()), r_cn), PRE);
  cn_pop_msg_info();
  update_cn_error_message_info("             (i64)MINi32() <= r; r <= (i64)MAXi32();\n                                 ^~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/slf3_basic_inplace_double/variants/cn_original_slf3_basic_inplace_double/tests/20261016-evaluation/value_2/fulminate.cn.c:7:34-53");
  cn_assert(cn_bits_i64_le(r_cn, cast_cn_bits_i32_to_cn_bits_i64(MAXi32())), PRE);
  cn_pop_msg_info();
  
	/* C OWNERSHIP */

  c_add_to_ghost_state((&p), sizeof(signed int*), get_cn_stack_depth());
  cn_pointer* p_addr_cn = convert_to_cn_pointer((&p));
  
  int n = CN_LOAD(*CN_LOAD(p));
c_add_to_ghost_state((&n), sizeof(signed int), get_cn_stack_depth());


cn_pointer* n_addr_cn = convert_to_cn_pointer((&n));

  int m = CN_LOAD(n) + CN_LOAD(n);
c_add_to_ghost_state((&m), sizeof(signed int), get_cn_stack_depth());


cn_pointer* m_addr_cn = convert_to_cn_pointer((&m));

  CN_STORE(*CN_LOAD(p), CN_LOAD(m));

c_remove_from_ghost_state((&n), sizeof(signed int));


c_remove_from_ghost_state((&m), sizeof(signed int));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  
	/* C OWNERSHIP */


  c_remove_from_ghost_state((&p), sizeof(signed int*));

{
  update_cn_error_message_info("    ensures  take m_ = Owned<int>(p);\n                  ^/home/yangfp/teSpec/benchmark/programs/slf3_basic_inplace_double/variants/cn_original_slf3_basic_inplace_double/tests/20261016-evaluation/value_2/fulminate.cn.c:8:19:");
  cn_bits_i32* m__cn = owned_signed_int(p_cn, POST, 0);
  cn_pop_msg_info();
  update_cn_error_message_info("             m_ == (i32) r;\n             ^~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/slf3_basic_inplace_double/variants/cn_original_slf3_basic_inplace_double/tests/20261016-evaluation/value_2/fulminate.cn.c:9:14-28");
  cn_assert(cn_bits_i32_equality(m__cn, cast_cn_bits_i64_to_cn_bits_i32(r_cn)), POST);
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
   int cell = 0;
c_add_to_ghost_state((&cell), sizeof(signed int), get_cn_stack_depth());


cn_pointer* cell_addr_cn = convert_to_cn_pointer((&cell));
 (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, inplace_double(&cell)); { __cn_ret = 0; 
c_remove_from_ghost_state((&cell), sizeof(signed int));
goto __cn_epilogue; } 
c_remove_from_ghost_state((&cell), sizeof(signed int));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  free_ghost_frame_stack();

return __cn_ret;

}

/* RECORD */

/* CONVERSION */

/* GENERATED STRUCT FUNCTIONS */

/* OWNERSHIP FUNCTIONS */

/* OWNERSHIP FUNCTIONS */

static cn_bits_i32* deref_signed_int(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  return convert_to_cn_bits_i32((*(signed int*) cn_ptr->ptr));
}
static cn_bits_i32* owned_signed_int(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  void* generic_c_ptr = (void*) (signed int*) cn_ptr->ptr;
  cn_get_or_put_ownership(spec_mode, generic_c_ptr, sizeof(signed int), loop_ownership);
  return convert_to_cn_bits_i32((*(signed int*) cn_ptr->ptr));
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

