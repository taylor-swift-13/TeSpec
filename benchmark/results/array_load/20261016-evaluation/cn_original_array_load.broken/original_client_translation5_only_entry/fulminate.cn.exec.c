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

# 0 "/home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c"
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
# 1 "/home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c"
int read (int *p, int n, int i)
/*@ requires take a1 = each(i32 j; 0i32 <= j && j < n) { Owned<int>(array_shift<int>(p,j)) };
             0i32 <= i && i < n; 
    ensures take a2 = each(i32 j; 0i32 <= j && j < n) { Owned<int>(array_shift<int>(p,j)) }; @*/
{
  /* EXECUTABLE CN PRECONDITION */
  signed int __cn_ret;
  cn_bump_frame_id __cn_bump_count_a_797 = cn_bump_get_frame_id();
  ghost_stack_depth_incr();
  enum CN_GHOST_ENUM ghost_spec = EMPTY;
  if (ghost_spec != (enum CN_GHOST_ENUM) top_ghost_frame_tag())
  cn_ghost_arg_failure();
else
  ;
  cn_pointer* p_cn = convert_to_cn_pointer(p);
  cn_bits_i32* n_cn = convert_to_cn_bits_i32(n);
  cn_bits_i32* i_cn = convert_to_cn_bits_i32(i);
  pop_ghost_frame();
  update_cn_error_message_info("/*@ requires take a1 = each(i32 j; 0i32 <= j && j < n) { Owned<int>(array_shift<int>(p,j)) };\n                  ^/home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c:2:19:");
  {
  cn_bits_i32* j = cast_cn_bits_i32_to_cn_bits_i32(convert_to_cn_bits_i32(0LL));
  cn_bits_i32* a_712 = n_cn;
  cn_pointer* a_733 = cn_array_shift(p_cn, sizeof(signed int), cast_cn_bits_i32_to_cn_bits_u64(j));
  cn_get_or_put_ownership(PRE, (void*) (signed int*) a_733->ptr, (sizeof(signed int) * convert_from_cn_bits_i32(cn_bits_i32_sub(a_712, j))), 0);
}
  cn_pop_msg_info();
  update_cn_error_message_info("             0i32 <= i && i < n; \n             ^~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c:3:14-33");
  cn_assert(cn_bool_and(cn_bits_i32_le(convert_to_cn_bits_i32(0LL), i_cn), cn_bits_i32_lt(i_cn, n_cn)), PRE);
  cn_pop_msg_info();
  
	/* C OWNERSHIP */

  c_add_to_ghost_state((&p), sizeof(signed int*), get_cn_stack_depth());
  cn_pointer* p_addr_cn = convert_to_cn_pointer((&p));
  c_add_to_ghost_state((&n), sizeof(signed int), get_cn_stack_depth());
  cn_pointer* n_addr_cn = convert_to_cn_pointer((&n));
  c_add_to_ghost_state((&i), sizeof(signed int), get_cn_stack_depth());
  cn_pointer* i_addr_cn = convert_to_cn_pointer((&i));
  
  { __cn_ret = CN_LOAD(CN_LOAD(p)[CN_LOAD(i)]); goto __cn_epilogue; }

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  
	/* C OWNERSHIP */


  c_remove_from_ghost_state((&p), sizeof(signed int*));

  c_remove_from_ghost_state((&n), sizeof(signed int));

  c_remove_from_ghost_state((&i), sizeof(signed int));

{
  cn_bits_i32* return_cn = convert_to_cn_bits_i32(__cn_ret);
  update_cn_error_message_info("    ensures take a2 = each(i32 j; 0i32 <= j && j < n) { Owned<int>(array_shift<int>(p,j)) }; @*/\n                 ^/home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c:4:18:");
  {
    cn_bits_i32* j = cast_cn_bits_i32_to_cn_bits_i32(convert_to_cn_bits_i32(0LL));
    cn_bits_i32* a_759 = n_cn;
    cn_pointer* a_780 = cn_array_shift(p_cn, sizeof(signed int), cast_cn_bits_i32_to_cn_bits_u64(j));
    cn_get_or_put_ownership(POST, (void*) (signed int*) a_780->ptr, (sizeof(signed int) * convert_from_cn_bits_i32(cn_bits_i32_sub(a_759, j))), 0);
  }
  cn_pop_msg_info();
  ghost_stack_depth_decr();
  cn_postcondition_leak_check();
}

  cn_bump_free_after(__cn_bump_count_a_797);

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
  
    int a[3] = { 0, 1, 2 };
c_add_to_ghost_state((&a), sizeof(signed int[3]), get_cn_stack_depth());


cn_pointer* a_addr_cn = convert_to_cn_pointer((&a));


    int zero = (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, read(a, 3, 0));
c_add_to_ghost_state((&zero), sizeof(signed int), get_cn_stack_depth());


cn_pointer* zero_addr_cn = convert_to_cn_pointer((&zero));

    update_cn_error_message_info("    /*@ assert (zero == 0i32); @*/\n       ^~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c:13:8-33");

cn_bits_i32* read_zero0 = convert_to_cn_bits_i32(cn_pointer_deref(convert_to_cn_pointer((&zero)), signed int));

update_cn_error_message_info("    /*@ assert (zero == 0i32); @*/\n        ^~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c:13:9-31");

update_cn_error_message_info("    /*@ assert (zero == 0i32); @*/\n        ^~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c:13:9-31");

cn_assert(cn_bits_i32_equality(read_zero0, convert_to_cn_bits_i32(0LL)), STATEMENT);

cn_pop_msg_info();

cn_pop_msg_info();

cn_pop_msg_info();

    int *first = a;
c_add_to_ghost_state((&first), sizeof(signed int*), get_cn_stack_depth());


cn_pointer* first_addr_cn = convert_to_cn_pointer((&first));

    update_cn_error_message_info("    /*@ assert (*first == 0i32); @*/\n       ^~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c:15:8-35");

cn_pointer* read_first0 = convert_to_cn_pointer(cn_pointer_deref(convert_to_cn_pointer((&first)), signed int*));

cn_bits_i32* deref_read_first00 = convert_to_cn_bits_i32(cn_pointer_deref(read_first0, signed int));

update_cn_error_message_info("    /*@ assert (*first == 0i32); @*/\n        ^~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c:15:9-33");

update_cn_error_message_info("    /*@ assert (*first == 0i32); @*/\n        ^~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c:15:9-33");

cn_assert(cn_bits_i32_equality(deref_read_first00, convert_to_cn_bits_i32(0LL)), STATEMENT);

cn_pop_msg_info();

cn_pop_msg_info();

cn_pop_msg_info();


    int one = (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, read(a, 3, 1));
c_add_to_ghost_state((&one), sizeof(signed int), get_cn_stack_depth());


cn_pointer* one_addr_cn = convert_to_cn_pointer((&one));

    update_cn_error_message_info("    /*@ assert (one == 1i32); @*/\n       ^~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c:18:8-32");

cn_bits_i32* read_one0 = convert_to_cn_bits_i32(cn_pointer_deref(convert_to_cn_pointer((&one)), signed int));

update_cn_error_message_info("    /*@ assert (one == 1i32); @*/\n        ^~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c:18:9-30");

update_cn_error_message_info("    /*@ assert (one == 1i32); @*/\n        ^~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c:18:9-30");

cn_assert(cn_bits_i32_equality(read_one0, convert_to_cn_bits_i32(1LL)), STATEMENT);

cn_pop_msg_info();

cn_pop_msg_info();

cn_pop_msg_info();

    int *second = a + 1;
c_add_to_ghost_state((&second), sizeof(signed int*), get_cn_stack_depth());


cn_pointer* second_addr_cn = convert_to_cn_pointer((&second));

    update_cn_error_message_info("    /*@ assert (*second == 1i32); @*/\n       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c:20:8-36");

cn_pointer* read_second0 = convert_to_cn_pointer(cn_pointer_deref(convert_to_cn_pointer((&second)), signed int*));

cn_bits_i32* deref_read_second00 = convert_to_cn_bits_i32(cn_pointer_deref(read_second0, signed int));

update_cn_error_message_info("    /*@ assert (*second == 1i32); @*/\n        ^~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c:20:9-34");

update_cn_error_message_info("    /*@ assert (*second == 1i32); @*/\n        ^~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c:20:9-34");

cn_assert(cn_bits_i32_equality(deref_read_second00, convert_to_cn_bits_i32(1LL)), STATEMENT);

cn_pop_msg_info();

cn_pop_msg_info();

cn_pop_msg_info();


    int two = (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, read(a, 3, 2));
c_add_to_ghost_state((&two), sizeof(signed int), get_cn_stack_depth());


cn_pointer* two_addr_cn = convert_to_cn_pointer((&two));

    update_cn_error_message_info("    /*@ assert (two == 2i32); @*/\n       ^~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c:23:8-32");

cn_bits_i32* read_two0 = convert_to_cn_bits_i32(cn_pointer_deref(convert_to_cn_pointer((&two)), signed int));

update_cn_error_message_info("    /*@ assert (two == 2i32); @*/\n        ^~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c:23:9-30");

update_cn_error_message_info("    /*@ assert (two == 2i32); @*/\n        ^~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c:23:9-30");

cn_assert(cn_bits_i32_equality(read_two0, convert_to_cn_bits_i32(2LL)), STATEMENT);

cn_pop_msg_info();

cn_pop_msg_info();

cn_pop_msg_info();

    int *third = a + 2;
c_add_to_ghost_state((&third), sizeof(signed int*), get_cn_stack_depth());


cn_pointer* third_addr_cn = convert_to_cn_pointer((&third));

    update_cn_error_message_info("    /*@ assert (*third == 2i32); @*/\n       ^~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c:25:8-35");

cn_pointer* read_third0 = convert_to_cn_pointer(cn_pointer_deref(convert_to_cn_pointer((&third)), signed int*));

cn_bits_i32* deref_read_third00 = convert_to_cn_bits_i32(cn_pointer_deref(read_third0, signed int));

update_cn_error_message_info("    /*@ assert (*third == 2i32); @*/\n        ^~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c:25:9-33");

update_cn_error_message_info("    /*@ assert (*third == 2i32); @*/\n        ^~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261016-evaluation/original_client_translation5_only_entry/fulminate.cn.c:25:9-33");

cn_assert(cn_bits_i32_equality(deref_read_third00, convert_to_cn_bits_i32(2LL)), STATEMENT);

cn_pop_msg_info();

cn_pop_msg_info();

cn_pop_msg_info();

 { __cn_ret = 0; 
c_remove_from_ghost_state((&a), sizeof(signed int[3]));


c_remove_from_ghost_state((&zero), sizeof(signed int));


c_remove_from_ghost_state((&first), sizeof(signed int*));


c_remove_from_ghost_state((&one), sizeof(signed int));


c_remove_from_ghost_state((&second), sizeof(signed int*));


c_remove_from_ghost_state((&two), sizeof(signed int));


c_remove_from_ghost_state((&third), sizeof(signed int*));
goto __cn_epilogue; } 
c_remove_from_ghost_state((&a), sizeof(signed int[3]));


c_remove_from_ghost_state((&zero), sizeof(signed int));


c_remove_from_ghost_state((&first), sizeof(signed int*));


c_remove_from_ghost_state((&one), sizeof(signed int));


c_remove_from_ghost_state((&second), sizeof(signed int*));


c_remove_from_ghost_state((&two), sizeof(signed int));


c_remove_from_ghost_state((&third), sizeof(signed int*));

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

