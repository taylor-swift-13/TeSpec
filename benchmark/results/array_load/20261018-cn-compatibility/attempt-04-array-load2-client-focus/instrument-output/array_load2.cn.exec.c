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
    ensures take a2 = each(integer j; 0 <= j && j < n) { RW<int>(array_shift<int>(p,j)) };
            a1 == a2;
            return == a1[i];
@*/
{
  /* EXECUTABLE CN PRECONDITION */
  signed int __cn_ret;
  cn_bump_frame_id __cn_bump_count_a_900 = cn_bump_get_frame_id();
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
  update_cn_error_message_info("int main()\n                  ^/home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:14:19:");
  cn_map* a1_cn = map_create();
  {
  cn_integer* j = cast_cn_integer_to_cn_integer(convert_to_cn_integer(0));
  cn_integer* a_723 = cn_integer_add(cn_integer_sub(n_cn, convert_to_cn_integer(1)), convert_to_cn_integer(1));
  cn_pointer* a_747 = cn_array_shift(p_cn, sizeof(signed int), j);
  cn_get_or_put_ownership(PRE, (void*) (signed int*) a_747->ptr, (sizeof(signed int) * convert_from_cn_integer(cn_integer_sub(a_723, j))), 0);
  while (convert_from_cn_bool(cn_integer_lt(j, a_723))) {
    a_747 = cn_array_shift(p_cn, sizeof(signed int), j);
    cn_map_set(a1_cn, j, deref_signed_int(a_747, PRE, 0));
    cn_integer_increment(j);
  }
}
  cn_pop_msg_info();
  update_cn_error_message_info("int main()\n                                                          ^~~~~~~ /home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:14:59-66");
  cn_bool* a_775 = convert_to_cn_bool(true);
  {
  cn_integer* j = cast_cn_integer_to_cn_integer(convert_to_cn_integer(0));
  cn_integer* a_762 = cn_integer_add(cn_integer_sub(n_cn, convert_to_cn_integer(1)), convert_to_cn_integer(1));
  while (convert_from_cn_bool(cn_integer_lt(j, a_762))) {
    cn_bool_inplace_and(a_775, convert_to_cn_bool(true));
    cn_integer_increment(j);
  }
}
  cn_assert(a_775, PRE);
  cn_pop_msg_info();
  update_cn_error_message_info("{\n             ^~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:15:14-30");
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
  update_cn_error_message_info("    int a[3] = { 0, 1, 2 };\n                 ^/home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:16:18:");
  cn_map* a2_cn = map_create();
  {
    cn_integer* j = cast_cn_integer_to_cn_integer(convert_to_cn_integer(0));
    cn_integer* a_815 = cn_integer_add(cn_integer_sub(n_cn, convert_to_cn_integer(1)), convert_to_cn_integer(1));
    cn_pointer* a_839 = cn_array_shift(p_cn, sizeof(signed int), j);
    cn_get_or_put_ownership(POST, (void*) (signed int*) a_839->ptr, (sizeof(signed int) * convert_from_cn_integer(cn_integer_sub(a_815, j))), 0);
    while (convert_from_cn_bool(cn_integer_lt(j, a_815))) {
      a_839 = cn_array_shift(p_cn, sizeof(signed int), j);
      cn_map_set(a2_cn, j, deref_signed_int(a_839, POST, 0));
      cn_integer_increment(j);
    }
  }
  cn_pop_msg_info();
  update_cn_error_message_info("    int a[3] = { 0, 1, 2 };\n                                                         ^~~~~~~ /home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:16:58-65");
  cn_bool* a_867 = convert_to_cn_bool(true);
  {
    cn_integer* j = cast_cn_integer_to_cn_integer(convert_to_cn_integer(0));
    cn_integer* a_854 = cn_integer_add(cn_integer_sub(n_cn, convert_to_cn_integer(1)), convert_to_cn_integer(1));
    while (convert_from_cn_bool(cn_integer_lt(j, a_854))) {
      cn_bool_inplace_and(a_867, convert_to_cn_bool(true));
      cn_integer_increment(j);
    }
  }
  cn_assert(a_867, POST);
  cn_pop_msg_info();
  update_cn_error_message_info("\n            ^~~~~~~~~ /home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:17:13-22");
  cn_assert(cn_map_equality(a1_cn, a2_cn, cn_integer_equality), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("    int zero = array_load_read(a, 3, 0);\n            ^~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:18:13-29");
  cn_assert(cn_integer_equality(return_cn, (cn_integer*) cn_map_get_cn_integer(a1_cn, i_cn)), POST);
  cn_pop_msg_info();
  ghost_stack_depth_decr();
  update_cn_error_message_info(0);
  cn_postcondition_leak_check();
  cn_pop_msg_info();
}

  cn_bump_free_after(__cn_bump_count_a_900);

return __cn_ret;

}
int main()
{
  /* EXECUTABLE CN PRECONDITION */
  signed int __cn_ret = 0;
  fulminate_init((struct fulm_init_config){.max_bump_blocks= 0, .bump_block_size= 0, .flags= (struct fulm_init_flags){.with_ghost_args= 1, .source_locs_mode= 0, .correct_missing_ownership= 0, .ownership_stack_mode= 0}});
  
    int a[3] = { 0, 1, 2 };
c_add_to_ghost_state((&a), sizeof(signed int[3]), get_cn_stack_depth());


cn_pointer* a_addr_cn = convert_to_cn_pointer((&a));

    int zero = (
({
  push_ghost_frame(EMPTY, 0);
  (void) 0;
})
, array_load_read(a, 3, 0));
c_add_to_ghost_state((&zero), sizeof(signed int), get_cn_stack_depth());


cn_pointer* zero_addr_cn = convert_to_cn_pointer((&zero));

    update_cn_error_message_info("    /*@ instantiate 1; @*/\n       ^~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:29:8-30");

cn_integer* read_zero0 = convert_to_cn_integer(cn_pointer_deref(convert_to_cn_pointer((&zero)), signed int));

update_cn_error_message_info("    /*@ instantiate 1; @*/\n        ^~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:29:9-28");

update_cn_error_message_info("    /*@ instantiate 1; @*/\n        ^~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:29:9-28");

cn_assert(cn_integer_equality(read_zero0, convert_to_cn_integer(0)), STATEMENT);

cn_pop_msg_info();

cn_pop_msg_info();

cn_pop_msg_info();

    int *first = a;
c_add_to_ghost_state((&first), sizeof(signed int*), get_cn_stack_depth());


cn_pointer* first_addr_cn = convert_to_cn_pointer((&first));

    
    
    update_cn_error_message_info("    /*@ assert (two == 2); @*/\n       ^~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:33:8-32");

cn_pointer* read_first0 = convert_to_cn_pointer(cn_pointer_deref(convert_to_cn_pointer((&first)), signed int*));

cn_integer* deref_read_first00 = convert_to_cn_integer(cn_pointer_deref(read_first0, signed int));

update_cn_error_message_info("    /*@ assert (two == 2); @*/\n        ^~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:33:9-30");

update_cn_error_message_info("    /*@ assert (two == 2); @*/\n        ^~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:33:9-30");

cn_assert(cn_integer_equality(deref_read_first00, convert_to_cn_integer(0)), STATEMENT);

cn_pop_msg_info();

cn_pop_msg_info();

cn_pop_msg_info();

    int one = (
({
  push_ghost_frame(EMPTY, 0);
  (void) 0;
})
, array_load_read(a, 3, 1));
c_add_to_ghost_state((&one), sizeof(signed int), get_cn_stack_depth());


cn_pointer* one_addr_cn = convert_to_cn_pointer((&one));

    update_cn_error_message_info("    /*@ focus RW<int>, 2; @*/\n       ^~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:35:8-29");

cn_integer* read_one0 = convert_to_cn_integer(cn_pointer_deref(convert_to_cn_pointer((&one)), signed int));

update_cn_error_message_info("    /*@ focus RW<int>, 2; @*/\n        ^~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:35:9-27");

update_cn_error_message_info("    /*@ focus RW<int>, 2; @*/\n        ^~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:35:9-27");

cn_assert(cn_integer_equality(read_one0, convert_to_cn_integer(1)), STATEMENT);

cn_pop_msg_info();

cn_pop_msg_info();

cn_pop_msg_info();

    int *second = a + 1;
c_add_to_ghost_state((&second), sizeof(signed int*), get_cn_stack_depth());


cn_pointer* second_addr_cn = convert_to_cn_pointer((&second));

    
    
    update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:39:8-33");

cn_pointer* read_second0 = convert_to_cn_pointer(cn_pointer_deref(convert_to_cn_pointer((&second)), signed int*));

cn_integer* deref_read_second00 = convert_to_cn_integer(cn_pointer_deref(read_second0, signed int));

update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:39:9-31");

update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:39:9-31");

cn_assert(cn_integer_equality(deref_read_second00, convert_to_cn_integer(1)), STATEMENT);

cn_pop_msg_info();

cn_pop_msg_info();

cn_pop_msg_info();

    int two = (
({
  push_ghost_frame(EMPTY, 0);
  (void) 0;
})
, array_load_read(a, 3, 2));
c_add_to_ghost_state((&two), sizeof(signed int), get_cn_stack_depth());


cn_pointer* two_addr_cn = convert_to_cn_pointer((&two));

    update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:41:8-29");

cn_integer* read_two0 = convert_to_cn_integer(cn_pointer_deref(convert_to_cn_pointer((&two)), signed int));

update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:41:9-27");

update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:41:9-27");

cn_assert(cn_integer_equality(read_two0, convert_to_cn_integer(2)), STATEMENT);

cn_pop_msg_info();

cn_pop_msg_info();

cn_pop_msg_info();

    int *third = a + 2;
c_add_to_ghost_state((&third), sizeof(signed int*), get_cn_stack_depth());


cn_pointer* third_addr_cn = convert_to_cn_pointer((&third));

    
    
    update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:45:8-32");

cn_pointer* read_third0 = convert_to_cn_pointer(cn_pointer_deref(convert_to_cn_pointer((&third)), signed int*));

cn_integer* deref_read_third00 = convert_to_cn_integer(cn_pointer_deref(read_third0, signed int));

update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:45:9-30");

update_cn_error_message_info("/home/yangfp/teSpec/benchmark/results/array_load/20261018-cn-compatibility/attempt-04-array-load2-client-focus/array_load2.cn.c:45:9-30");

cn_assert(cn_integer_equality(deref_read_third00, convert_to_cn_integer(2)), STATEMENT);

cn_pop_msg_info();

cn_pop_msg_info();

cn_pop_msg_info();


c_remove_from_ghost_state((&a), sizeof(signed int[3]));


c_remove_from_ghost_state((&zero), sizeof(signed int));


c_remove_from_ghost_state((&first), sizeof(signed int*));


c_remove_from_ghost_state((&one), sizeof(signed int));


c_remove_from_ghost_state((&second), sizeof(signed int*));


c_remove_from_ghost_state((&two), sizeof(signed int));


c_remove_from_ghost_state((&third), sizeof(signed int*));

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

