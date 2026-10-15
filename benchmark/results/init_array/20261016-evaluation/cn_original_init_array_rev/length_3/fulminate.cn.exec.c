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

static cn_pointer* deref_char_pointer(cn_pointer*, enum spec_mode, struct loop_ownership*);
static cn_bits_u32* deref_unsigned_int(cn_pointer*, enum spec_mode, struct loop_ownership*);
static cn_bits_u8* deref_char(cn_pointer*, enum spec_mode, struct loop_ownership*);
static cn_pointer* owned_char_pointer(cn_pointer*, enum spec_mode, struct loop_ownership*);
static cn_bits_u32* owned_unsigned_int(cn_pointer*, enum spec_mode, struct loop_ownership*);
static cn_bits_u8* owned_char(cn_pointer*, enum spec_mode, struct loop_ownership*);
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

# 0 "/home/yangfp/teSpec/benchmark/programs/init_array/variants/cn_original_init_array_rev/tests/20261016-evaluation/length_3/fulminate.cn.c"
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
# 1 "/home/yangfp/teSpec/benchmark/programs/init_array/variants/cn_original_init_array_rev/tests/20261016-evaluation/length_3/fulminate.cn.c"
void init_array2 (char *p, unsigned int n)
/*@ requires take a1 = each(u32 i; 0u32 <= i && i < n) { Block<char>( array_shift<char>(p, i)) };
    n > 0u32;
    ensures  take a2 = each(u32 i; 0u32 <= i && i < n) { Owned<char>( array_shift<char>(p, i)) };
@*/
{
  /* EXECUTABLE CN PRECONDITION */
  cn_bump_frame_id __cn_bump_count_a_861 = cn_bump_get_frame_id();
  ghost_stack_depth_incr();
  enum CN_GHOST_ENUM ghost_spec = EMPTY;
  if (ghost_spec != (enum CN_GHOST_ENUM) top_ghost_frame_tag())
  cn_ghost_arg_failure();
else
  ;
  cn_pointer* p_cn = convert_to_cn_pointer(p);
  cn_bits_u32* n_cn = convert_to_cn_bits_u32(n);
  pop_ghost_frame();
  update_cn_error_message_info("/*@ requires take a1 = each(u32 i; 0u32 <= i && i < n) { Block<char>( array_shift<char>(p, i)) };\n                  ^/home/yangfp/teSpec/benchmark/programs/init_array/variants/cn_original_init_array_rev/tests/20261016-evaluation/length_3/fulminate.cn.c:2:19:");
  {
  cn_bits_u32* i = cast_cn_bits_u32_to_cn_bits_u32(convert_to_cn_bits_u32(0ULL));
  cn_bits_u32* a_652 = n_cn;
  cn_pointer* a_673 = cn_array_shift(p_cn, sizeof(char), cast_cn_bits_u32_to_cn_bits_u64(i));
  cn_get_or_put_ownership(PRE, (void*) (char*) a_673->ptr, (sizeof(char) * convert_from_cn_bits_u32(cn_bits_u32_sub(a_652, i))), 0);
}
  cn_pop_msg_info();
  update_cn_error_message_info("    n > 0u32;\n    ^~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/init_array/variants/cn_original_init_array_rev/tests/20261016-evaluation/length_3/fulminate.cn.c:3:5-14");
  cn_assert(cn_bits_u32_lt(convert_to_cn_bits_u32(0ULL), n_cn), PRE);
  cn_pop_msg_info();
  
	/* C OWNERSHIP */

  c_add_to_ghost_state((&p), sizeof(char*), get_cn_stack_depth());
  cn_pointer* p_addr_cn = convert_to_cn_pointer((&p));
  c_add_to_ghost_state((&n), sizeof(unsigned int), get_cn_stack_depth());
  cn_pointer* n_addr_cn = convert_to_cn_pointer((&n));
  
  unsigned int j;
c_add_to_ghost_state((&j), sizeof(unsigned int), get_cn_stack_depth());


cn_pointer* j_addr_cn = convert_to_cn_pointer((&j));

  CN_STORE(j, 0);

  {
cn_bump_frame_id __cn_bump_count_a_816;

struct loop_ownership* a_689;

cn_bits_u32* O_j2;

cn_pointer* O_p2;

cn_bits_u32* O_n2;
while (({
  __cn_bump_count_a_816 = cn_bump_get_frame_id();
  a_689 = initialise_loop_ownership_state();
  update_cn_error_message_info("  while (j < n)\n  ^~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/init_array/variants/cn_original_init_array_rev/tests/20261016-evaluation/length_3/fulminate.cn.c:10:3-25:4");
  O_j2 = owned_unsigned_int(j_addr_cn, LOOP, a_689);
  cn_pop_msg_info();
  update_cn_error_message_info("  while (j < n)\n  ^~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/init_array/variants/cn_original_init_array_rev/tests/20261016-evaluation/length_3/fulminate.cn.c:10:3-25:4");
  O_p2 = owned_char_pointer(p_addr_cn, LOOP, a_689);
  cn_pop_msg_info();
  update_cn_error_message_info("  while (j < n)\n  ^~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/init_array/variants/cn_original_init_array_rev/tests/20261016-evaluation/length_3/fulminate.cn.c:10:3-25:4");
  O_n2 = owned_unsigned_int(n_addr_cn, LOOP, a_689);
  cn_pop_msg_info();
  update_cn_error_message_info("  /*@ inv take al = each(u32 i; 0u32 <= i && i < n-j) { Block<char>( array_shift<char>(p, i)) };\n               ^/home/yangfp/teSpec/benchmark/programs/init_array/variants/cn_original_init_array_rev/tests/20261016-evaluation/length_3/fulminate.cn.c:12:16:");
  {
    cn_bits_u32* i = cast_cn_bits_u32_to_cn_bits_u32(convert_to_cn_bits_u32(0ULL));
    cn_bits_u32* a_708 = cn_bits_u32_sub(O_n2, O_j2);
    cn_pointer* a_731 = cn_array_shift(O_p2, sizeof(char), cast_cn_bits_u32_to_cn_bits_u64(i));
    cn_get_or_put_ownership(LOOP, (void*) (char*) a_731->ptr, (sizeof(char) * convert_from_cn_bits_u32(cn_bits_u32_sub(a_708, i))), a_689);
  }
  cn_pop_msg_info();
  update_cn_error_message_info("          take ar = each(u32 i; n-j <= i && i < n) { Owned<char>( array_shift<char>(p, i)) };\n               ^/home/yangfp/teSpec/benchmark/programs/init_array/variants/cn_original_init_array_rev/tests/20261016-evaluation/length_3/fulminate.cn.c:13:16:");
  {
    cn_bits_u32* i = cast_cn_bits_u32_to_cn_bits_u32(cn_bits_u32_sub(O_n2, O_j2));
    cn_bits_u32* a_744 = O_n2;
    cn_pointer* a_763 = cn_array_shift(O_p2, sizeof(char), cast_cn_bits_u32_to_cn_bits_u64(i));
    cn_get_or_put_ownership(LOOP, (void*) (char*) a_763->ptr, (sizeof(char) * convert_from_cn_bits_u32(cn_bits_u32_sub(a_744, i))), a_689);
  }
  cn_pop_msg_info();
  update_cn_error_message_info("          {p} unchanged; {n} unchanged;\n          ^~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/init_array/variants/cn_original_init_array_rev/tests/20261016-evaluation/length_3/fulminate.cn.c:14:11-25");
  cn_assert(cn_pointer_equality(O_p2, p_cn), LOOP);
  cn_pop_msg_info();
  update_cn_error_message_info("          {p} unchanged; {n} unchanged;\n                         ^~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/init_array/variants/cn_original_init_array_rev/tests/20261016-evaluation/length_3/fulminate.cn.c:14:26-40");
  cn_assert(cn_bits_u32_equality(O_n2, n_cn), LOOP);
  cn_pop_msg_info();
  update_cn_error_message_info("          0u32 <= j && j <= n;\n          ^~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/init_array/variants/cn_original_init_array_rev/tests/20261016-evaluation/length_3/fulminate.cn.c:15:11-31");
  cn_assert(cn_bool_and(cn_bits_u32_le(convert_to_cn_bits_u32(0ULL), O_j2), cn_bits_u32_le(O_j2, O_n2)), LOOP);
  cn_pop_msg_info();
  update_cn_error_message_info("    /*@ extract Block<char>, n-(j+1u32); @*/\n       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/init_array/variants/cn_original_init_array_rev/tests/20261016-evaluation/length_3/fulminate.cn.c:20:8-43");
  cn_pop_msg_info();
  update_cn_error_message_info("    /*@ extract Owned<char>, n-(j+1u32); @*/\n       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/init_array/variants/cn_original_init_array_rev/tests/20261016-evaluation/length_3/fulminate.cn.c:21:8-43");
  cn_pop_msg_info();
  cn_loop_put_back_ownership(a_689);
  0;
})
, CN_LOAD(j) < CN_LOAD(n))
/* --BEGIN-- */
  /*@ inv take al = each(u32 i; 0u32 <= i && i < n-j) { Block<char>( array_shift<char>(p, i)) };
          take ar = each(u32 i; n-j <= i && i < n) { Owned<char>( array_shift<char>(p, i)) };
          {p} unchanged; {n} unchanged;
          0u32 <= j && j <= n;
  @*/
/* --END-- */
  {
/* --BEGIN-- */
    /*@ extract Block<char>, n-(j+1u32); @*/
    /*@ extract Owned<char>, n-(j+1u32); @*/
/* --END-- */
    CN_STORE(CN_LOAD(p)[CN_LOAD(n)-(CN_LOAD(j)+1)], 0);
    CN_POSTFIX(j, ++);
  cn_bump_free_after(__cn_bump_count_a_816);
}cn_bump_free_after(__cn_bump_count_a_816);

}

c_remove_from_ghost_state((&j), sizeof(unsigned int));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  
	/* C OWNERSHIP */


  c_remove_from_ghost_state((&p), sizeof(char*));

  c_remove_from_ghost_state((&n), sizeof(unsigned int));

{
  update_cn_error_message_info("    ensures  take a2 = each(u32 i; 0u32 <= i && i < n) { Owned<char>( array_shift<char>(p, i)) };\n                  ^/home/yangfp/teSpec/benchmark/programs/init_array/variants/cn_original_init_array_rev/tests/20261016-evaluation/length_3/fulminate.cn.c:4:19:");
  {
    cn_bits_u32* i = cast_cn_bits_u32_to_cn_bits_u32(convert_to_cn_bits_u32(0ULL));
    cn_bits_u32* a_823 = n_cn;
    cn_pointer* a_844 = cn_array_shift(p_cn, sizeof(char), cast_cn_bits_u32_to_cn_bits_u64(i));
    cn_get_or_put_ownership(POST, (void*) (char*) a_844->ptr, (sizeof(char) * convert_from_cn_bits_u32(cn_bits_u32_sub(a_823, i))), 0);
  }
  cn_pop_msg_info();
  ghost_stack_depth_decr();
  cn_postcondition_leak_check();
}

  cn_bump_free_after(__cn_bump_count_a_861);
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
   char cells[3];
c_add_to_ghost_state((&cells), sizeof(char[3]), get_cn_stack_depth());


cn_pointer* cells_addr_cn = convert_to_cn_pointer((&cells));
 (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, init_array2(cells,3u)); { __cn_ret = 0; 
c_remove_from_ghost_state((&cells), sizeof(char[3]));
goto __cn_epilogue; } 
c_remove_from_ghost_state((&cells), sizeof(char[3]));

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

static cn_pointer* deref_char_pointer(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  return convert_to_cn_pointer((*(char**) cn_ptr->ptr));
}
static cn_bits_u32* deref_unsigned_int(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  return convert_to_cn_bits_u32((*(unsigned int*) cn_ptr->ptr));
}
static cn_bits_u8* deref_char(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  return convert_to_cn_bits_u8((*(char*) cn_ptr->ptr));
}
static cn_pointer* owned_char_pointer(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  void* generic_c_ptr = (void*) (char**) cn_ptr->ptr;
  cn_get_or_put_ownership(spec_mode, generic_c_ptr, sizeof(char*), loop_ownership);
  return convert_to_cn_pointer((*(char**) cn_ptr->ptr));
}
static cn_bits_u32* owned_unsigned_int(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  void* generic_c_ptr = (void*) (unsigned int*) cn_ptr->ptr;
  cn_get_or_put_ownership(spec_mode, generic_c_ptr, sizeof(unsigned int), loop_ownership);
  return convert_to_cn_bits_u32((*(unsigned int*) cn_ptr->ptr));
}
static cn_bits_u8* owned_char(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  void* generic_c_ptr = (void*) (char*) cn_ptr->ptr;
  cn_get_or_put_ownership(spec_mode, generic_c_ptr, sizeof(char), loop_ownership);
  return convert_to_cn_bits_u8((*(char*) cn_ptr->ptr));
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

