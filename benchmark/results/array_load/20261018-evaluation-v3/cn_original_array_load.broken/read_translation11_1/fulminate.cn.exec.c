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

static cn_integer* deref_signed_int(cn_pointer*, enum spec_mode, struct loop_ownership*);
static cn_integer* owned_signed_int(cn_pointer*, enum spec_mode, struct loop_ownership*);
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
int array_load_read (int *p, int n, int i)
/*@ requires take a1 = each(integer j; 0 <= j && j < n) { RW<int>(array_shift<int>(p,j)) };
             0 <= i && i < n; 
    ensures take a2 = each(integer j; 0 <= j && j < n) { RW<int>(array_shift<int>(p,j)) }; @*/
{
  /* EXECUTABLE CN PRECONDITION */
  signed int __cn_ret;
  cn_bump_frame_id __cn_bump_count_a_757 = cn_bump_get_frame_id();
  ghost_stack_depth_incr();
  enum CN_GHOST_ENUM ghost_spec = EMPTY;
  if (ghost_spec != (enum CN_GHOST_ENUM) top_ghost_frame_tag())
  cn_ghost_arg_failure();
else
  ;
  cn_pointer* p_cn = convert_to_cn_pointer(p);
  cn_integer* n_cn = convert_to_cn_integer(n);
  cn_integer* i_cn = convert_to_cn_integer(i);
  pop_ghost_frame();
  update_cn_error_message_info("/home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261018-evaluation-v3/read_translation11_1/fulminate.cn.c:14:19:");
  cn_map* a1_cn = map_create();
  {
  cn_integer* j = cast_cn_integer_to_cn_integer(convert_to_cn_integer(0));
  cn_integer* a_609 = cn_integer_add(cn_integer_sub(n_cn, convert_to_cn_integer(1)), convert_to_cn_integer(1));
  cn_pointer* a_633 = cn_array_shift(p_cn, sizeof(signed int), j);
  cn_get_or_put_ownership(PRE, (void*) (signed int*) a_633->ptr, (sizeof(signed int) * convert_from_cn_integer(cn_integer_sub(a_609, j))), 0);
  while (convert_from_cn_bool(cn_integer_lt(j, a_609))) {
    a_633 = cn_array_shift(p_cn, sizeof(signed int), j);
    cn_map_set(a1_cn, j, deref_signed_int(a_633, PRE, 0));
    cn_integer_increment(j);
  }
}
  cn_pop_msg_info();
  update_cn_error_message_info("/home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261018-evaluation-v3/read_translation11_1/fulminate.cn.c:14:59-66");
  cn_bool* a_661 = convert_to_cn_bool(true);
  {
  cn_integer* j = cast_cn_integer_to_cn_integer(convert_to_cn_integer(0));
  cn_integer* a_648 = cn_integer_add(cn_integer_sub(n_cn, convert_to_cn_integer(1)), convert_to_cn_integer(1));
  while (convert_from_cn_bool(cn_integer_lt(j, a_648))) {
    cn_bool_inplace_and(a_661, convert_to_cn_bool(true));
    cn_integer_increment(j);
  }
}
  cn_assert(a_661, PRE);
  cn_pop_msg_info();
  update_cn_error_message_info("/home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261018-evaluation-v3/read_translation11_1/fulminate.cn.c:15:14-30");
  cn_assert(cn_bool_and(cn_integer_le(convert_to_cn_integer(0), i_cn), cn_integer_lt(i_cn, n_cn)), PRE);
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
  cn_integer* return_cn = convert_to_cn_integer(__cn_ret);
  update_cn_error_message_info("/home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261018-evaluation-v3/read_translation11_1/fulminate.cn.c:16:18:");
  cn_map* a2_cn = map_create();
  {
    cn_integer* j = cast_cn_integer_to_cn_integer(convert_to_cn_integer(0));
    cn_integer* a_687 = cn_integer_add(cn_integer_sub(n_cn, convert_to_cn_integer(1)), convert_to_cn_integer(1));
    cn_pointer* a_711 = cn_array_shift(p_cn, sizeof(signed int), j);
    cn_get_or_put_ownership(POST, (void*) (signed int*) a_711->ptr, (sizeof(signed int) * convert_from_cn_integer(cn_integer_sub(a_687, j))), 0);
    while (convert_from_cn_bool(cn_integer_lt(j, a_687))) {
      a_711 = cn_array_shift(p_cn, sizeof(signed int), j);
      cn_map_set(a2_cn, j, deref_signed_int(a_711, POST, 0));
      cn_integer_increment(j);
    }
  }
  cn_pop_msg_info();
  update_cn_error_message_info("/home/yangfp/teSpec/benchmark/programs/array_load/variants/cn_original_array_load.broken/tests/20261018-evaluation-v3/read_translation11_1/fulminate.cn.c:16:58-65");
  cn_bool* a_739 = convert_to_cn_bool(true);
  {
    cn_integer* j = cast_cn_integer_to_cn_integer(convert_to_cn_integer(0));
    cn_integer* a_726 = cn_integer_add(cn_integer_sub(n_cn, convert_to_cn_integer(1)), convert_to_cn_integer(1));
    while (convert_from_cn_bool(cn_integer_lt(j, a_726))) {
      cn_bool_inplace_and(a_739, convert_to_cn_bool(true));
      cn_integer_increment(j);
    }
  }
  cn_assert(a_739, POST);
  cn_pop_msg_info();
  ghost_stack_depth_decr();
  update_cn_error_message_info(0);
  cn_postcondition_leak_check();
  cn_pop_msg_info();
}

  cn_bump_free_after(__cn_bump_count_a_757);

return __cn_ret;

}
int main(void) /*@ ensures return == 0; @*/ {
  /* EXECUTABLE CN PRECONDITION */
  signed int __cn_ret = 0;
  fulminate_init((struct fulm_init_config){.max_bump_blocks= 0, .bump_block_size= 0, .flags= (struct fulm_init_flags){.with_ghost_args= 1, .source_locs_mode= 0, .correct_missing_ownership= 0, .ownership_stack_mode= 0}});
   int a[1]={(-2147483648)};
c_add_to_ghost_state((&a), sizeof(signed int[1]), get_cn_stack_depth());


cn_pointer* a_addr_cn = convert_to_cn_pointer((&a));
 int result=(
({
  push_ghost_frame(EMPTY, 0);
  (void) 0;
})
, array_load_read(a,1,0));
c_add_to_ghost_state((&result), sizeof(signed int), get_cn_stack_depth());


cn_pointer* result_addr_cn = convert_to_cn_pointer((&result));
 (void)CN_LOAD(result); { __cn_ret = 0; 
c_remove_from_ghost_state((&a), sizeof(signed int[1]));


c_remove_from_ghost_state((&result), sizeof(signed int));
goto __cn_epilogue; } 
c_remove_from_ghost_state((&a), sizeof(signed int[1]));


c_remove_from_ghost_state((&result), sizeof(signed int));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:
;

return __cn_ret;

}

/* RECORD */

/* CONVERSION */

/* GENERATED STRUCT FUNCTIONS */

/* OWNERSHIP FUNCTIONS */

/* OWNERSHIP FUNCTIONS */

static cn_integer* deref_signed_int(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  return convert_to_cn_integer((*(signed int*) cn_ptr->ptr));
}
static cn_integer* owned_signed_int(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  void* generic_c_ptr = (void*) (signed int*) cn_ptr->ptr;
  cn_get_or_put_ownership(spec_mode, generic_c_ptr, sizeof(signed int), loop_ownership);
  return convert_to_cn_integer((*(signed int*) cn_ptr->ptr));
}
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

