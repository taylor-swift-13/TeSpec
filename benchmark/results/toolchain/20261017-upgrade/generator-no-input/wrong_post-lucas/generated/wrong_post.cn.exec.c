#define __CN_INSTRUMENT
#include <cn-executable/utils.h>
#include <cn-executable/cerb_types.h>
typedef __cerbty_intptr_t intptr_t;
typedef __cerbty_uintptr_t uintptr_t;
typedef __cerbty_intmax_t intmax_t;
typedef __cerbty_uintmax_t uintmax_t;
_Noreturn void abort(void);
/* ORIGINAL C STRUCTS AND UNIONS */


/* CN VERSIONS OF C STRUCTS */



/* OWNERSHIP FUNCTIONS */

/* CONVERSION FUNCTIONS */

/* GENERATED STRUCT FUNCTIONS */

/* RECORD FUNCTIONS */

/* CN FUNCTIONS */

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
int constant(void) /*@ ensures return == 2; @*/ {
  /* EXECUTABLE CN PRECONDITION */
  signed int __cn_ret;
  cn_bump_frame_id __cn_bump_count_a_533 = cn_bump_get_frame_id();
  ghost_stack_depth_incr();
   { __cn_ret = 1; goto __cn_epilogue; } 
/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

{
  cn_integer* return_cn = convert_to_cn_integer(__cn_ret);
  update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/toolchain/20261017-upgrade/generator-no-input/wrong_post.cn.c:13:32-44");
  cn_assert(cn_integer_equality(return_cn, convert_to_cn_integer(2)), POST);
  cn_pop_msg_info();
  ghost_stack_depth_decr();
  update_cn_error_message_info(0);
  cn_postcondition_leak_check();
  cn_pop_msg_info();
}

  cn_bump_free_after(__cn_bump_count_a_533);

return __cn_ret;

}

/* RECORD */

/* CONVERSION */

/* GENERATED STRUCT FUNCTIONS */

/* OWNERSHIP FUNCTIONS */

/* OWNERSHIP FUNCTIONS */

/* CN FUNCTIONS */
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


/* CN LEMMAS */

