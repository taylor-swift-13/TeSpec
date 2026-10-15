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


/* CN RECORDS */

struct BothOwned_record {
  cn_bits_u32* pv;
  cn_bits_u32* qv;
};

/* CN VERSIONS OF C STRUCTS */



/* OWNERSHIP FUNCTIONS */

static cn_bits_u32* deref_unsigned_int(cn_pointer*, enum spec_mode, struct loop_ownership*);
static cn_bits_u32* owned_unsigned_int(cn_pointer*, enum spec_mode, struct loop_ownership*);
/* CONVERSION FUNCTIONS */

/* GENERATED STRUCT FUNCTIONS */

/* RECORD FUNCTIONS */
static cn_bool* struct_BothOwned_record_equality(void*, void*);
static struct BothOwned_record* default_struct_BothOwned_record();
static void* cn_map_get_struct_BothOwned_record(cn_map*, cn_integer*);
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

static struct BothOwned_record* BothOwned(cn_pointer*, cn_pointer*, enum spec_mode, struct loop_ownership*);
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

# 0 "/home/yangfp/teSpec/benchmark/programs/incr_two/variants/cn_original_slf_incr2/tests/20261016-evaluation/input_5/fulminate.cn.c"
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
# 1 "/home/yangfp/teSpec/benchmark/programs/incr_two/variants/cn_original_slf_incr2/tests/20261016-evaluation/input_5/fulminate.cn.c"
/*@
predicate { u32 pv, u32 qv } BothOwned (pointer p, pointer q)
{
  if (ptr_eq(p,q)) {
    take pv = Owned<unsigned int>(p);
    return {pv: pv, qv: pv};
  }
  else {
    take pv = Owned<unsigned int>(p);
    take qv = Owned<unsigned int>(q);
    return {pv: pv, qv: qv};
  }
}
@*/

void incr2 (unsigned int *p, unsigned int *q)
/*@ requires take vs = BothOwned(p,q);
    ensures take vs_ = BothOwned(p,q);
            vs_.pv == (!ptr_eq(p,q) ? (vs.pv + 1u32) : (vs.pv + 2u32));
            vs_.qv == (!ptr_eq(p,q) ? (vs.qv + 1u32) : vs_.pv);
@*/
{
  /* EXECUTABLE CN PRECONDITION */
  cn_bump_frame_id __cn_bump_count_a_749 = cn_bump_get_frame_id();
  ghost_stack_depth_incr();
  enum CN_GHOST_ENUM ghost_spec = EMPTY;
  if (ghost_spec != (enum CN_GHOST_ENUM) top_ghost_frame_tag())
  cn_ghost_arg_failure();
else
  ;
  cn_pointer* p_cn = convert_to_cn_pointer(p);
  cn_pointer* q_cn = convert_to_cn_pointer(q);
  pop_ghost_frame();
  update_cn_error_message_info("/*@ requires take vs = BothOwned(p,q);\n                  ^/home/yangfp/teSpec/benchmark/programs/incr_two/variants/cn_original_slf_incr2/tests/20261016-evaluation/input_5/fulminate.cn.c:17:19:");
  struct BothOwned_record* vs_cn = BothOwned(p_cn, q_cn, PRE, 0);
  cn_pop_msg_info();
  
	/* C OWNERSHIP */

  c_add_to_ghost_state((&p), sizeof(unsigned int*), get_cn_stack_depth());
  cn_pointer* p_addr_cn = convert_to_cn_pointer((&p));
  c_add_to_ghost_state((&q), sizeof(unsigned int*), get_cn_stack_depth());
  cn_pointer* q_addr_cn = convert_to_cn_pointer((&q));
  
  update_cn_error_message_info("  /*@ split_case ptr_eq(p,q); @*/\n     ^~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/incr_two/variants/cn_original_slf_incr2/tests/20261016-evaluation/input_5/fulminate.cn.c:23:6-32");

cn_pop_msg_info();

  unsigned int n = CN_LOAD(*CN_LOAD(p));
c_add_to_ghost_state((&n), sizeof(unsigned int), get_cn_stack_depth());


cn_pointer* n_addr_cn = convert_to_cn_pointer((&n));

  unsigned int m = CN_LOAD(n)+1;
c_add_to_ghost_state((&m), sizeof(unsigned int), get_cn_stack_depth());


cn_pointer* m_addr_cn = convert_to_cn_pointer((&m));

  CN_STORE(*CN_LOAD(p), CN_LOAD(m));
  CN_STORE(n, CN_LOAD(*CN_LOAD(q)));
  CN_STORE(m, CN_LOAD(n)+1);
  CN_STORE(*CN_LOAD(q), CN_LOAD(m));

c_remove_from_ghost_state((&n), sizeof(unsigned int));


c_remove_from_ghost_state((&m), sizeof(unsigned int));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  
	/* C OWNERSHIP */


  c_remove_from_ghost_state((&p), sizeof(unsigned int*));

  c_remove_from_ghost_state((&q), sizeof(unsigned int*));

{
  update_cn_error_message_info("    ensures take vs_ = BothOwned(p,q);\n                 ^/home/yangfp/teSpec/benchmark/programs/incr_two/variants/cn_original_slf_incr2/tests/20261016-evaluation/input_5/fulminate.cn.c:18:18:");
  struct BothOwned_record* vs__cn = BothOwned(p_cn, q_cn, POST, 0);
  cn_pop_msg_info();
  update_cn_error_message_info("            vs_.pv == (!ptr_eq(p,q) ? (vs.pv + 1u32) : (vs.pv + 2u32));\n            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/incr_two/variants/cn_original_slf_incr2/tests/20261016-evaluation/input_5/fulminate.cn.c:19:13-72");
  cn_bits_u32* a_714;
  if (convert_from_cn_bool(cn_bool_not(ptr_eq(p_cn, q_cn)))) {
    a_714 = cn_bits_u32_add(vs_cn->pv, convert_to_cn_bits_u32(1ULL));
  }
  else {
    a_714 = cn_bits_u32_add(vs_cn->pv, convert_to_cn_bits_u32(2ULL));
  }
  cn_assert(cn_bits_u32_equality(vs__cn->pv, a_714), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("            vs_.qv == (!ptr_eq(p,q) ? (vs.qv + 1u32) : vs_.pv);\n            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/incr_two/variants/cn_original_slf_incr2/tests/20261016-evaluation/input_5/fulminate.cn.c:20:13-64");
  cn_bits_u32* a_730;
  if (convert_from_cn_bool(cn_bool_not(ptr_eq(p_cn, q_cn)))) {
    a_730 = cn_bits_u32_add(vs_cn->qv, convert_to_cn_bits_u32(1ULL));
  }
  else {
    a_730 = vs__cn->pv;
  }
  cn_assert(cn_bits_u32_equality(vs__cn->qv, a_730), POST);
  cn_pop_msg_info();
  ghost_stack_depth_decr();
  cn_postcondition_leak_check();
}

  cn_bump_free_after(__cn_bump_count_a_749);
}

void call_both_better (unsigned int *p, unsigned int *q)
/*@ requires take pv = Owned<unsigned int>(p);
             take qv = Owned<unsigned int>(q);
             !ptr_eq(p,q);
    ensures take pv_ = Owned<unsigned int>(p);
            take qv_ = Owned<unsigned int>(q);
            pv_ == pv + 3u32;
            qv_ == qv + 1u32;
@*/
{
  /* EXECUTABLE CN PRECONDITION */
  cn_bump_frame_id __cn_bump_count_a_813 = cn_bump_get_frame_id();
  ghost_stack_depth_incr();
  enum CN_GHOST_ENUM ghost_spec = EMPTY;
  if (ghost_spec != (enum CN_GHOST_ENUM) top_ghost_frame_tag())
  cn_ghost_arg_failure();
else
  ;
  cn_pointer* p_cn = convert_to_cn_pointer(p);
  cn_pointer* q_cn = convert_to_cn_pointer(q);
  pop_ghost_frame();
  update_cn_error_message_info("/*@ requires take pv = Owned<unsigned int>(p);\n                  ^/home/yangfp/teSpec/benchmark/programs/incr_two/variants/cn_original_slf_incr2/tests/20261016-evaluation/input_5/fulminate.cn.c:33:19:");
  cn_bits_u32* pv_cn = owned_unsigned_int(p_cn, PRE, 0);
  cn_pop_msg_info();
  update_cn_error_message_info("             take qv = Owned<unsigned int>(q);\n                  ^/home/yangfp/teSpec/benchmark/programs/incr_two/variants/cn_original_slf_incr2/tests/20261016-evaluation/input_5/fulminate.cn.c:34:19:");
  cn_bits_u32* qv_cn = owned_unsigned_int(q_cn, PRE, 0);
  cn_pop_msg_info();
  update_cn_error_message_info("             !ptr_eq(p,q);\n             ^~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/incr_two/variants/cn_original_slf_incr2/tests/20261016-evaluation/input_5/fulminate.cn.c:35:14-27");
  cn_assert(cn_bool_not(ptr_eq(p_cn, q_cn)), PRE);
  cn_pop_msg_info();
  
	/* C OWNERSHIP */

  c_add_to_ghost_state((&p), sizeof(unsigned int*), get_cn_stack_depth());
  cn_pointer* p_addr_cn = convert_to_cn_pointer((&p));
  c_add_to_ghost_state((&q), sizeof(unsigned int*), get_cn_stack_depth());
  cn_pointer* q_addr_cn = convert_to_cn_pointer((&q));
  
  (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, incr2(CN_LOAD(p), CN_LOAD(q)));
  (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, incr2(CN_LOAD(p), CN_LOAD(p)));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  
	/* C OWNERSHIP */


  c_remove_from_ghost_state((&p), sizeof(unsigned int*));

  c_remove_from_ghost_state((&q), sizeof(unsigned int*));

{
  update_cn_error_message_info("    ensures take pv_ = Owned<unsigned int>(p);\n                 ^/home/yangfp/teSpec/benchmark/programs/incr_two/variants/cn_original_slf_incr2/tests/20261016-evaluation/input_5/fulminate.cn.c:36:18:");
  cn_bits_u32* pv__cn = owned_unsigned_int(p_cn, POST, 0);
  cn_pop_msg_info();
  update_cn_error_message_info("            take qv_ = Owned<unsigned int>(q);\n                 ^/home/yangfp/teSpec/benchmark/programs/incr_two/variants/cn_original_slf_incr2/tests/20261016-evaluation/input_5/fulminate.cn.c:37:18:");
  cn_bits_u32* qv__cn = owned_unsigned_int(q_cn, POST, 0);
  cn_pop_msg_info();
  update_cn_error_message_info("            pv_ == pv + 3u32;\n            ^~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/incr_two/variants/cn_original_slf_incr2/tests/20261016-evaluation/input_5/fulminate.cn.c:38:13-30");
  cn_assert(cn_bits_u32_equality(pv__cn, cn_bits_u32_add(pv_cn, convert_to_cn_bits_u32(3ULL))), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("            qv_ == qv + 1u32;\n            ^~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/incr_two/variants/cn_original_slf_incr2/tests/20261016-evaluation/input_5/fulminate.cn.c:39:13-30");
  cn_assert(cn_bits_u32_equality(qv__cn, cn_bits_u32_add(qv_cn, convert_to_cn_bits_u32(1ULL))), POST);
  cn_pop_msg_info();
  ghost_stack_depth_decr();
  cn_postcondition_leak_check();
}

  cn_bump_free_after(__cn_bump_count_a_813);
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
   unsigned int a=1u;
c_add_to_ghost_state((&a), sizeof(unsigned int), get_cn_stack_depth());


cn_pointer* a_addr_cn = convert_to_cn_pointer((&a));
 unsigned int b=4294967295u;
c_add_to_ghost_state((&b), sizeof(unsigned int), get_cn_stack_depth());


cn_pointer* b_addr_cn = convert_to_cn_pointer((&b));
 (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, call_both_better(&a,&b)); { __cn_ret = 0; 
c_remove_from_ghost_state((&a), sizeof(unsigned int));


c_remove_from_ghost_state((&b), sizeof(unsigned int));
goto __cn_epilogue; } 
c_remove_from_ghost_state((&a), sizeof(unsigned int));


c_remove_from_ghost_state((&b), sizeof(unsigned int));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  free_ghost_frame_stack();

return __cn_ret;

}

/* RECORD */
cn_bool* struct_BothOwned_record_equality(void* x, void* y)
{
  struct BothOwned_record* x_cast = (struct BothOwned_record*) x;
  struct BothOwned_record* y_cast = (struct BothOwned_record*) y;
  return cn_bool_and(cn_bool_and(convert_to_cn_bool(true), cn_bits_u32_equality(x_cast->pv, y_cast->pv)), cn_bits_u32_equality(x_cast->qv, y_cast->qv));
}

struct BothOwned_record* default_struct_BothOwned_record()
{
  struct BothOwned_record* a_976 = (struct BothOwned_record*) cn_bump_malloc(sizeof(struct BothOwned_record));
  a_976->pv = default_cn_bits_u32();
  a_976->qv = default_cn_bits_u32();
  return a_976;
}

void* cn_map_get_struct_BothOwned_record(cn_map* m, cn_integer* key)
{
  void* ret = ht_get(m, (&key->val));
  if (0 == ret)
    return (void*) default_struct_BothOwned_record();
  else
    return ret;
}
/* CONVERSION */

/* GENERATED STRUCT FUNCTIONS */

/* OWNERSHIP FUNCTIONS */

/* OWNERSHIP FUNCTIONS */

static cn_bits_u32* deref_unsigned_int(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  return convert_to_cn_bits_u32((*(unsigned int*) cn_ptr->ptr));
}
static cn_bits_u32* owned_unsigned_int(cn_pointer* cn_ptr, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  void* generic_c_ptr = (void*) (unsigned int*) cn_ptr->ptr;
  cn_get_or_put_ownership(spec_mode, generic_c_ptr, sizeof(unsigned int), loop_ownership);
  return convert_to_cn_bits_u32((*(unsigned int*) cn_ptr->ptr));
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

static struct BothOwned_record* BothOwned(cn_pointer* p, cn_pointer* q, enum spec_mode spec_mode, struct loop_ownership* loop_ownership)
{
  if (convert_from_cn_bool(ptr_eq(p, q))) {
    update_cn_error_message_info("    take pv = Owned<unsigned int>(p);\n         ^/home/yangfp/teSpec/benchmark/programs/incr_two/variants/cn_original_slf_incr2/tests/20261016-evaluation/input_5/fulminate.cn.c:5:10:");
    cn_bits_u32* pv = owned_unsigned_int(p, spec_mode, loop_ownership);
    cn_pop_msg_info();
    struct BothOwned_record* a_936 = (struct BothOwned_record*) cn_bump_malloc(sizeof(struct BothOwned_record));
    a_936->pv = pv;
    a_936->qv = pv;
    return a_936;
  }
  else {
    update_cn_error_message_info("    take pv = Owned<unsigned int>(p);\n         ^/home/yangfp/teSpec/benchmark/programs/incr_two/variants/cn_original_slf_incr2/tests/20261016-evaluation/input_5/fulminate.cn.c:9:10:");
    cn_bits_u32* pv = owned_unsigned_int(p, spec_mode, loop_ownership);
    cn_pop_msg_info();
    update_cn_error_message_info("    take qv = Owned<unsigned int>(q);\n         ^/home/yangfp/teSpec/benchmark/programs/incr_two/variants/cn_original_slf_incr2/tests/20261016-evaluation/input_5/fulminate.cn.c:10:10:");
    cn_bits_u32* qv = owned_unsigned_int(q, spec_mode, loop_ownership);
    cn_pop_msg_info();
    struct BothOwned_record* a_943 = (struct BothOwned_record*) cn_bump_malloc(sizeof(struct BothOwned_record));
    a_943->pv = pv;
    a_943->qv = qv;
    return a_943;
  }
}

/* CN LEMMAS */

