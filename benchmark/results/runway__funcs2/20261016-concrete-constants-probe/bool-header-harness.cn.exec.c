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

struct State {
  signed int ModeA;
  signed int ModeD;
  signed int W_A;
  signed int W_D;
  signed int Runway_Time;
  signed int Plane_Counter;
};


/* CN VERSIONS OF C STRUCTS */

struct State_cn {
  cn_bits_i32* ModeA;
  cn_bits_i32* ModeD;
  cn_bits_i32* W_A;
  cn_bits_i32* W_D;
  cn_bits_i32* Runway_Time;
  cn_bits_i32* Plane_Counter;
};



/* OWNERSHIP FUNCTIONS */

/* CONVERSION FUNCTIONS */

/* GENERATED STRUCT FUNCTIONS */

static struct State_cn* default_struct_State_cn();
static void* cn_map_get_struct_State_cn(cn_map*, cn_integer*);
static cn_bool* struct_State_cn_equality(void*, void*);
static struct State convert_from_struct_State_cn(struct State_cn*);
static struct State_cn* convert_to_struct_State_cn(struct State);
/* RECORD FUNCTIONS */

/* CN FUNCTIONS */

static cn_bool* valid_state(struct State_cn*);
static cn_bits_i32* ACTIVE();
static cn_bits_i32* INACTIVE();
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

# 0 "/home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c"
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
# 1 "/home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c"
# 1 "/home/yangfp/teSpec/benchmark/programs/runway__funcs2/variants/cn_original_runway__funcs2/tests/20261016-compatibility/state.h" 1

    /*@ function (i32) INACTIVE () { 0i32 } @*/
    static int c_INACTIVE() { { __cn_ret = 0; goto __cn_epilogue; } }


    /*@ function (i32) ACTIVE () { 1i32 } @*/
    static int c_ACTIVE() { { __cn_ret = 1; goto __cn_epilogue; } }

struct State;
# 2 "/home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c" 2
# 1 "/home/yangfp/teSpec/benchmark/programs/runway__funcs2/variants/cn_original_runway__funcs2/tests/20261016-compatibility/valid_state.h" 1
/*@
function (boolean) valid_state (struct State s) {
     (s.ModeA == INACTIVE() || s.ModeA == ACTIVE()) &&
     (s.ModeD == INACTIVE() || s.ModeD == ACTIVE()) &&
     (s.ModeA == INACTIVE() || s.ModeD == INACTIVE()) &&
     (s.W_A >= 0i32 && s.W_D >= 0i32) &&
     (0i32 <= s.Runway_Time && s.Runway_Time <= 5i32) && 
     (0i32 <= s.Plane_Counter && s.Plane_Counter <= 3i32) && 
     (s.ModeA == INACTIVE() && s.ModeD == INACTIVE() implies s.Plane_Counter == 0i32) &&
     (s.Runway_Time > 0i32 implies (s.ModeA == ACTIVE() || s.ModeD == ACTIVE())) &&

     (s.Plane_Counter > 0i32 && s.ModeA == ACTIVE() implies s.W_D > 0i32) &&
     (s.Plane_Counter > 0i32 && s.ModeD == ACTIVE() implies s.W_A > 0i32)

}
@*/
# 3 "/home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c" 2
# 1 "/home/yangfp/teSpec/arxiv/fulminate-cn/src/examples/runway/funcs1.h" 1
struct State init()
/*@ requires true;
    ensures valid_state(return);
@*/
{
    struct State initial = {0,0,0,0,0,0};
c_add_to_ghost_state((&initial), sizeof(struct State), get_cn_stack_depth());


cn_pointer* initial_addr_cn = convert_to_cn_pointer((&initial));

    { __cn_ret = CN_LOAD(initial); 
c_remove_from_ghost_state((&initial), sizeof(struct State));
goto __cn_epilogue; }

c_remove_from_ghost_state((&initial), sizeof(struct State));
}

struct State increment_Plane_Counter(struct State s)
/*@ requires valid_state(s);
             0i32 <= s.Plane_Counter;
             s.Plane_Counter <= 2i32;
             s.ModeA == ACTIVE() || s.ModeD == ACTIVE();
             s.ModeA == ACTIVE() implies s.W_D > 0i32;
             s.ModeD == ACTIVE() implies s.W_A > 0i32;
    ensures  valid_state(return);
             s.Plane_Counter == return.Plane_Counter - 1i32;
             s.Runway_Time == return.Runway_Time;
             s.ModeA == return.ModeA;
             s.ModeD == return.ModeD;
             s.W_A == return.W_A;
             s.W_D == return.W_D;
@*/
{
  struct State temp = CN_LOAD(s);
c_add_to_ghost_state((&temp), sizeof(struct State), get_cn_stack_depth());


cn_pointer* temp_addr_cn = convert_to_cn_pointer((&temp));

  CN_STORE(temp.Plane_Counter, CN_LOAD(s.Plane_Counter) + 1);
  { __cn_ret = CN_LOAD(temp); 
c_remove_from_ghost_state((&temp), sizeof(struct State));
goto __cn_epilogue; }

c_remove_from_ghost_state((&temp), sizeof(struct State));
}

struct State reset_Plane_Counter(struct State s)
/*@ requires valid_state(s);
    ensures  valid_state(return);
             return.Plane_Counter == 0i32;
             s.Runway_Time == return.Runway_Time;
             s.ModeA == return.ModeA;
             s.ModeD == return.ModeD;
             s.W_A == return.W_A;
             s.W_D == return.W_D;
@*/
{
  struct State temp = CN_LOAD(s);
c_add_to_ghost_state((&temp), sizeof(struct State), get_cn_stack_depth());


cn_pointer* temp_addr_cn = convert_to_cn_pointer((&temp));

  CN_STORE(temp.Plane_Counter, 0);
  { __cn_ret = CN_LOAD(temp); 
c_remove_from_ghost_state((&temp), sizeof(struct State));
goto __cn_epilogue; }

c_remove_from_ghost_state((&temp), sizeof(struct State));
}
# 4 "/home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c" 2

struct State increment_Runway_Time(struct State s)
/* --BEGIN-- */
/*@ requires valid_state(s);
             0i32 <= s.Runway_Time;
             s.Runway_Time <= 4i32;
             s.ModeA == ACTIVE() || s.ModeD == ACTIVE();
    ensures  valid_state(return);
             s.Plane_Counter == return.Plane_Counter;
             s.ModeA == return.ModeA;
             s.ModeD == return.ModeD;
@*/
/* --END-- */
{
  /* EXECUTABLE CN PRECONDITION */
  struct State __cn_ret;
  cn_bump_frame_id __cn_bump_count_a_1659 = cn_bump_get_frame_id();
  ghost_stack_depth_incr();
  enum CN_GHOST_ENUM ghost_spec = EMPTY;
  if (ghost_spec != (enum CN_GHOST_ENUM) top_ghost_frame_tag())
  cn_ghost_arg_failure();
else
  ;
  struct State_cn* s_cn = convert_to_struct_State_cn(s);
  pop_ghost_frame();
  update_cn_error_message_info("/*@ requires valid_state(s);\n             ^~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:7:14-29");
  cn_assert(valid_state(s_cn), PRE);
  cn_pop_msg_info();
  update_cn_error_message_info("             0i32 <= s.Runway_Time;\n             ^~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:8:14-36");
  cn_assert(cn_bits_i32_le(convert_to_cn_bits_i32(0LL), s_cn->Runway_Time), PRE);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.Runway_Time <= 4i32;\n             ^~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:9:14-36");
  cn_assert(cn_bits_i32_le(s_cn->Runway_Time, convert_to_cn_bits_i32(4LL)), PRE);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.ModeA == ACTIVE() || s.ModeD == ACTIVE();\n             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:10:14-57");
  cn_assert(cn_bool_or(cn_bits_i32_equality(s_cn->ModeA, ACTIVE()), cn_bits_i32_equality(s_cn->ModeD, ACTIVE())), PRE);
  cn_pop_msg_info();
  
	/* C OWNERSHIP */

  c_add_to_ghost_state((&s), sizeof(struct State), get_cn_stack_depth());
  cn_pointer* s_addr_cn = convert_to_cn_pointer((&s));
  
  struct State temp = CN_LOAD(s);
c_add_to_ghost_state((&temp), sizeof(struct State), get_cn_stack_depth());


cn_pointer* temp_addr_cn = convert_to_cn_pointer((&temp));

  CN_STORE(temp.Runway_Time, CN_LOAD(s.Runway_Time) + 1);
  { __cn_ret = CN_LOAD(temp); 
c_remove_from_ghost_state((&temp), sizeof(struct State));
goto __cn_epilogue; }

c_remove_from_ghost_state((&temp), sizeof(struct State));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  
	/* C OWNERSHIP */


  c_remove_from_ghost_state((&s), sizeof(struct State));

{
  struct State_cn* return_cn = convert_to_struct_State_cn(__cn_ret);
  update_cn_error_message_info("    ensures  valid_state(return);\n             ^~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:11:14-34");
  cn_assert(valid_state(return_cn), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.Plane_Counter == return.Plane_Counter;\n             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:12:14-54");
  cn_assert(cn_bits_i32_equality(s_cn->Plane_Counter, return_cn->Plane_Counter), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.ModeA == return.ModeA;\n             ^~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:13:14-38");
  cn_assert(cn_bits_i32_equality(s_cn->ModeA, return_cn->ModeA), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.ModeD == return.ModeD;\n             ^~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:14:14-38");
  cn_assert(cn_bits_i32_equality(s_cn->ModeD, return_cn->ModeD), POST);
  cn_pop_msg_info();
  ghost_stack_depth_decr();
  cn_postcondition_leak_check();
}

  cn_bump_free_after(__cn_bump_count_a_1659);

return __cn_ret;

}


struct State reset_Runway_Time(struct State s)
/* --BEGIN-- */
/*@ requires valid_state(s);
    ensures  valid_state(return);
             return.Runway_Time == 0i32;
             s.ModeA == return.ModeA;
             s.ModeD == return.ModeD;
             s.W_A == return.W_A;
             s.W_D == return.W_D;
             s.Plane_Counter == return.Plane_Counter;
@*/
/* --END-- */
{
  /* EXECUTABLE CN PRECONDITION */
  struct State __cn_ret;
  cn_bump_frame_id __cn_bump_count_a_1729 = cn_bump_get_frame_id();
  ghost_stack_depth_incr();
  enum CN_GHOST_ENUM ghost_spec = EMPTY;
  if (ghost_spec != (enum CN_GHOST_ENUM) top_ghost_frame_tag())
  cn_ghost_arg_failure();
else
  ;
  struct State_cn* s_cn = convert_to_struct_State_cn(s);
  pop_ghost_frame();
  update_cn_error_message_info("/*@ requires valid_state(s);\n             ^~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:26:14-29");
  cn_assert(valid_state(s_cn), PRE);
  cn_pop_msg_info();
  
	/* C OWNERSHIP */

  c_add_to_ghost_state((&s), sizeof(struct State), get_cn_stack_depth());
  cn_pointer* s_addr_cn = convert_to_cn_pointer((&s));
  
  struct State temp = CN_LOAD(s);
c_add_to_ghost_state((&temp), sizeof(struct State), get_cn_stack_depth());


cn_pointer* temp_addr_cn = convert_to_cn_pointer((&temp));

  CN_STORE(temp.Runway_Time, 0);
  { __cn_ret = CN_LOAD(temp); 
c_remove_from_ghost_state((&temp), sizeof(struct State));
goto __cn_epilogue; }

c_remove_from_ghost_state((&temp), sizeof(struct State));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  
	/* C OWNERSHIP */


  c_remove_from_ghost_state((&s), sizeof(struct State));

{
  struct State_cn* return_cn = convert_to_struct_State_cn(__cn_ret);
  update_cn_error_message_info("    ensures  valid_state(return);\n             ^~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:27:14-34");
  cn_assert(valid_state(return_cn), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             return.Runway_Time == 0i32;\n             ^~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:28:14-41");
  cn_assert(cn_bits_i32_equality(return_cn->Runway_Time, convert_to_cn_bits_i32(0LL)), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.ModeA == return.ModeA;\n             ^~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:29:14-38");
  cn_assert(cn_bits_i32_equality(s_cn->ModeA, return_cn->ModeA), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.ModeD == return.ModeD;\n             ^~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:30:14-38");
  cn_assert(cn_bits_i32_equality(s_cn->ModeD, return_cn->ModeD), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.W_A == return.W_A;\n             ^~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:31:14-34");
  cn_assert(cn_bits_i32_equality(s_cn->W_A, return_cn->W_A), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.W_D == return.W_D;\n             ^~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:32:14-34");
  cn_assert(cn_bits_i32_equality(s_cn->W_D, return_cn->W_D), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.Plane_Counter == return.Plane_Counter;\n             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:33:14-54");
  cn_assert(cn_bits_i32_equality(s_cn->Plane_Counter, return_cn->Plane_Counter), POST);
  cn_pop_msg_info();
  ghost_stack_depth_decr();
  cn_postcondition_leak_check();
}

  cn_bump_free_after(__cn_bump_count_a_1729);

return __cn_ret;

}

struct State arrive(struct State s)
/* --BEGIN-- */
/*@ requires valid_state(s);
             s.ModeA == ACTIVE() && s.W_A >= 1i32;
             s.Plane_Counter <= 2i32;
    ensures  valid_state(return);
             s.Runway_Time == return.Runway_Time;
             s.ModeA == return.ModeA;
             s.ModeD == return.ModeD;
             s.W_D == return.W_D;
             s.W_D == 0i32 implies s.Plane_Counter == return.Plane_Counter;
             s.W_D > 0i32 implies s.Plane_Counter == return.Plane_Counter - 1i32;
@*/
/* --END-- */
{
  /* EXECUTABLE CN PRECONDITION */
  struct State __cn_ret;
  cn_bump_frame_id __cn_bump_count_a_1824 = cn_bump_get_frame_id();
  ghost_stack_depth_incr();
  enum CN_GHOST_ENUM ghost_spec = EMPTY;
  if (ghost_spec != (enum CN_GHOST_ENUM) top_ghost_frame_tag())
  cn_ghost_arg_failure();
else
  ;
  struct State_cn* s_cn = convert_to_struct_State_cn(s);
  pop_ghost_frame();
  update_cn_error_message_info("/*@ requires valid_state(s);\n             ^~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:44:14-29");
  cn_assert(valid_state(s_cn), PRE);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.ModeA == ACTIVE() && s.W_A >= 1i32;\n             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:45:14-51");
  cn_assert(cn_bool_and(cn_bits_i32_equality(s_cn->ModeA, ACTIVE()), cn_bits_i32_le(convert_to_cn_bits_i32(1LL), s_cn->W_A)), PRE);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.Plane_Counter <= 2i32;\n             ^~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:46:14-38");
  cn_assert(cn_bits_i32_le(s_cn->Plane_Counter, convert_to_cn_bits_i32(2LL)), PRE);
  cn_pop_msg_info();
  
	/* C OWNERSHIP */

  c_add_to_ghost_state((&s), sizeof(struct State), get_cn_stack_depth());
  cn_pointer* s_addr_cn = convert_to_cn_pointer((&s));
  
  struct State temp = CN_LOAD(s);
c_add_to_ghost_state((&temp), sizeof(struct State), get_cn_stack_depth());


cn_pointer* temp_addr_cn = convert_to_cn_pointer((&temp));

  CN_STORE(temp.W_A, CN_LOAD(s.W_A) - 1);
  if (CN_LOAD(s.W_D) > 0) {
    CN_STORE(temp, (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, increment_Plane_Counter(CN_LOAD(temp))));
  }
  { __cn_ret = CN_LOAD(temp); 
c_remove_from_ghost_state((&temp), sizeof(struct State));
goto __cn_epilogue; }

c_remove_from_ghost_state((&temp), sizeof(struct State));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  
	/* C OWNERSHIP */


  c_remove_from_ghost_state((&s), sizeof(struct State));

{
  struct State_cn* return_cn = convert_to_struct_State_cn(__cn_ret);
  update_cn_error_message_info("    ensures  valid_state(return);\n             ^~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:47:14-34");
  cn_assert(valid_state(return_cn), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.Runway_Time == return.Runway_Time;\n             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:48:14-50");
  cn_assert(cn_bits_i32_equality(s_cn->Runway_Time, return_cn->Runway_Time), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.ModeA == return.ModeA;\n             ^~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:49:14-38");
  cn_assert(cn_bits_i32_equality(s_cn->ModeA, return_cn->ModeA), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.ModeD == return.ModeD;\n             ^~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:50:14-38");
  cn_assert(cn_bits_i32_equality(s_cn->ModeD, return_cn->ModeD), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.W_D == return.W_D;\n             ^~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:51:14-34");
  cn_assert(cn_bits_i32_equality(s_cn->W_D, return_cn->W_D), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.W_D == 0i32 implies s.Plane_Counter == return.Plane_Counter;\n             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:52:14-76");
  cn_assert(cn_bool_implies(cn_bits_i32_equality(s_cn->W_D, convert_to_cn_bits_i32(0LL)), cn_bits_i32_equality(s_cn->Plane_Counter, return_cn->Plane_Counter)), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.W_D > 0i32 implies s.Plane_Counter == return.Plane_Counter - 1i32;\n             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:53:14-82");
  cn_assert(cn_bool_implies(cn_bits_i32_lt(convert_to_cn_bits_i32(0LL), s_cn->W_D), cn_bits_i32_equality(s_cn->Plane_Counter, cn_bits_i32_sub(return_cn->Plane_Counter, convert_to_cn_bits_i32(1LL)))), POST);
  cn_pop_msg_info();
  ghost_stack_depth_decr();
  cn_postcondition_leak_check();
}

  cn_bump_free_after(__cn_bump_count_a_1824);

return __cn_ret;

}

struct State depart(struct State s)
/* --BEGIN-- */
/*@ requires valid_state(s);
             s.ModeD == ACTIVE() && s.W_D >=1i32;
             s.Plane_Counter <= 2i32;
    ensures  valid_state(return);
              s.Runway_Time == return.Runway_Time;
              s.ModeA == return.ModeA;
              s.ModeD == return.ModeD;
              s.W_A == return.W_A;
@*/
/* --END-- */
{
  /* EXECUTABLE CN PRECONDITION */
  struct State __cn_ret;
  cn_bump_frame_id __cn_bump_count_a_1894 = cn_bump_get_frame_id();
  ghost_stack_depth_incr();
  enum CN_GHOST_ENUM ghost_spec = EMPTY;
  if (ghost_spec != (enum CN_GHOST_ENUM) top_ghost_frame_tag())
  cn_ghost_arg_failure();
else
  ;
  struct State_cn* s_cn = convert_to_struct_State_cn(s);
  pop_ghost_frame();
  update_cn_error_message_info("/*@ requires valid_state(s);\n             ^~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:67:14-29");
  cn_assert(valid_state(s_cn), PRE);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.ModeD == ACTIVE() && s.W_D >=1i32;\n             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:68:14-50");
  cn_assert(cn_bool_and(cn_bits_i32_equality(s_cn->ModeD, ACTIVE()), cn_bits_i32_le(convert_to_cn_bits_i32(1LL), s_cn->W_D)), PRE);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.Plane_Counter <= 2i32;\n             ^~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:69:14-38");
  cn_assert(cn_bits_i32_le(s_cn->Plane_Counter, convert_to_cn_bits_i32(2LL)), PRE);
  cn_pop_msg_info();
  
	/* C OWNERSHIP */

  c_add_to_ghost_state((&s), sizeof(struct State), get_cn_stack_depth());
  cn_pointer* s_addr_cn = convert_to_cn_pointer((&s));
  
  struct State temp = CN_LOAD(s);
c_add_to_ghost_state((&temp), sizeof(struct State), get_cn_stack_depth());


cn_pointer* temp_addr_cn = convert_to_cn_pointer((&temp));

  CN_STORE(temp.W_D, CN_LOAD(s.W_D) - 1);
  if (CN_LOAD(s.W_A) > 0) {
    CN_STORE(temp, (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, increment_Plane_Counter(CN_LOAD(temp))));
  }
  { __cn_ret = CN_LOAD(temp); 
c_remove_from_ghost_state((&temp), sizeof(struct State));
goto __cn_epilogue; }

c_remove_from_ghost_state((&temp), sizeof(struct State));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  
	/* C OWNERSHIP */


  c_remove_from_ghost_state((&s), sizeof(struct State));

{
  struct State_cn* return_cn = convert_to_struct_State_cn(__cn_ret);
  update_cn_error_message_info("    ensures  valid_state(return);\n             ^~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:70:14-34");
  cn_assert(valid_state(return_cn), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("              s.Runway_Time == return.Runway_Time;\n              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:71:15-51");
  cn_assert(cn_bits_i32_equality(s_cn->Runway_Time, return_cn->Runway_Time), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("              s.ModeA == return.ModeA;\n              ^~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:72:15-39");
  cn_assert(cn_bits_i32_equality(s_cn->ModeA, return_cn->ModeA), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("              s.ModeD == return.ModeD;\n              ^~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:73:15-39");
  cn_assert(cn_bits_i32_equality(s_cn->ModeD, return_cn->ModeD), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("              s.W_A == return.W_A;\n              ^~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:74:15-35");
  cn_assert(cn_bits_i32_equality(s_cn->W_A, return_cn->W_A), POST);
  cn_pop_msg_info();
  ghost_stack_depth_decr();
  cn_postcondition_leak_check();
}

  cn_bump_free_after(__cn_bump_count_a_1894);

return __cn_ret;

}

struct State switch_modes(struct State s)
/* --BEGIN-- */
/*@ requires valid_state(s);
             s.ModeA == ACTIVE() || s.ModeD == ACTIVE();
             s.Plane_Counter == 0i32;
    ensures  valid_state(return);
             return.ModeA == ACTIVE() || return.ModeD == ACTIVE();
             return.ModeA == s.ModeD;
             return.ModeD == s.ModeA;
             return.W_A == s.W_A;
             return.W_D == s.W_D;
             return.Runway_Time == s.Runway_Time;
             s.Plane_Counter == return.Plane_Counter;
@*/
/* --END-- */
{
  /* EXECUTABLE CN PRECONDITION */
  struct State __cn_ret;
  cn_bump_frame_id __cn_bump_count_a_1989 = cn_bump_get_frame_id();
  ghost_stack_depth_incr();
  enum CN_GHOST_ENUM ghost_spec = EMPTY;
  if (ghost_spec != (enum CN_GHOST_ENUM) top_ghost_frame_tag())
  cn_ghost_arg_failure();
else
  ;
  struct State_cn* s_cn = convert_to_struct_State_cn(s);
  pop_ghost_frame();
  update_cn_error_message_info("/*@ requires valid_state(s);\n             ^~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:88:14-29");
  cn_assert(valid_state(s_cn), PRE);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.ModeA == ACTIVE() || s.ModeD == ACTIVE();\n             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:89:14-57");
  cn_assert(cn_bool_or(cn_bits_i32_equality(s_cn->ModeA, ACTIVE()), cn_bits_i32_equality(s_cn->ModeD, ACTIVE())), PRE);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.Plane_Counter == 0i32;\n             ^~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:90:14-38");
  cn_assert(cn_bits_i32_equality(s_cn->Plane_Counter, convert_to_cn_bits_i32(0LL)), PRE);
  cn_pop_msg_info();
  
	/* C OWNERSHIP */

  c_add_to_ghost_state((&s), sizeof(struct State), get_cn_stack_depth());
  cn_pointer* s_addr_cn = convert_to_cn_pointer((&s));
  
  struct State temp = CN_LOAD(s);
c_add_to_ghost_state((&temp), sizeof(struct State), get_cn_stack_depth());


cn_pointer* temp_addr_cn = convert_to_cn_pointer((&temp));

  if (CN_LOAD(s.ModeA) == 0) {
    // if arrival mode is inactive, make it active
    CN_STORE(temp.ModeA, 1);
  } else {
    // if arrival mode is active, make it inactive
    CN_STORE(temp.ModeA, 0);
  }
  if (CN_LOAD(s.ModeD) == 0) {
    // if departure mode is inactive, make it active
    CN_STORE(temp.ModeD, 1);
  } else {
    // if departure mode is active, make it inactive
    CN_STORE(temp.ModeD, 0);
  }
  { __cn_ret = CN_LOAD(temp); 
c_remove_from_ghost_state((&temp), sizeof(struct State));
goto __cn_epilogue; }

c_remove_from_ghost_state((&temp), sizeof(struct State));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  
	/* C OWNERSHIP */


  c_remove_from_ghost_state((&s), sizeof(struct State));

{
  struct State_cn* return_cn = convert_to_struct_State_cn(__cn_ret);
  update_cn_error_message_info("    ensures  valid_state(return);\n             ^~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:91:14-34");
  cn_assert(valid_state(return_cn), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             return.ModeA == ACTIVE() || return.ModeD == ACTIVE();\n             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:92:14-67");
  cn_assert(cn_bool_or(cn_bits_i32_equality(return_cn->ModeA, ACTIVE()), cn_bits_i32_equality(return_cn->ModeD, ACTIVE())), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             return.ModeA == s.ModeD;\n             ^~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:93:14-38");
  cn_assert(cn_bits_i32_equality(return_cn->ModeA, s_cn->ModeD), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             return.ModeD == s.ModeA;\n             ^~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:94:14-38");
  cn_assert(cn_bits_i32_equality(return_cn->ModeD, s_cn->ModeA), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             return.W_A == s.W_A;\n             ^~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:95:14-34");
  cn_assert(cn_bits_i32_equality(return_cn->W_A, s_cn->W_A), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             return.W_D == s.W_D;\n             ^~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:96:14-34");
  cn_assert(cn_bits_i32_equality(return_cn->W_D, s_cn->W_D), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             return.Runway_Time == s.Runway_Time;\n             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:97:14-50");
  cn_assert(cn_bits_i32_equality(return_cn->Runway_Time, s_cn->Runway_Time), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("             s.Plane_Counter == return.Plane_Counter;\n             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:98:14-54");
  cn_assert(cn_bits_i32_equality(s_cn->Plane_Counter, return_cn->Plane_Counter), POST);
  cn_pop_msg_info();
  ghost_stack_depth_decr();
  cn_postcondition_leak_check();
}

  cn_bump_free_after(__cn_bump_count_a_1989);

return __cn_ret;

}


// This function represents what happens every minute at the airport. 
// One `tick` corresponds to one minute.
struct State tick(struct State s)
/* --BEGIN-- */
/*@ requires valid_state(s);
             (i64) s.Plane_Counter < 2147483647i64;
             (i64) s.W_A < 2147483647i64;
             (i64) s.W_D < 2147483647i64;
    ensures valid_state(return);
            (s.W_A > 0i32 && s.W_D == 0i32 && s.Runway_Time == 0i32 implies return.ModeA == ACTIVE());
            (s.W_D > 0i32 && s.W_A == 0i32 && s.Runway_Time == 0i32 implies return.ModeD == ACTIVE());
@*/
/* --END-- */
{
  /* EXECUTABLE CN PRECONDITION */
  struct State __cn_ret;
  cn_bump_frame_id __cn_bump_count_a_2086 = cn_bump_get_frame_id();
  ghost_stack_depth_incr();
  enum CN_GHOST_ENUM ghost_spec = EMPTY;
  if (ghost_spec != (enum CN_GHOST_ENUM) top_ghost_frame_tag())
  cn_ghost_arg_failure();
else
  ;
  struct State_cn* s_cn = convert_to_struct_State_cn(s);
  pop_ghost_frame();
  update_cn_error_message_info("/*@ requires valid_state(s);\n             ^~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:125:14-29");
  cn_assert(valid_state(s_cn), PRE);
  cn_pop_msg_info();
  update_cn_error_message_info("             (i64) s.Plane_Counter < 2147483647i64;\n             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:126:14-52");
  cn_assert(cn_bits_i64_lt(cast_cn_bits_i32_to_cn_bits_i64(s_cn->Plane_Counter), convert_to_cn_bits_i64(2147483647LL)), PRE);
  cn_pop_msg_info();
  update_cn_error_message_info("             (i64) s.W_A < 2147483647i64;\n             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:127:14-42");
  cn_assert(cn_bits_i64_lt(cast_cn_bits_i32_to_cn_bits_i64(s_cn->W_A), convert_to_cn_bits_i64(2147483647LL)), PRE);
  cn_pop_msg_info();
  update_cn_error_message_info("             (i64) s.W_D < 2147483647i64;\n             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:128:14-42");
  cn_assert(cn_bits_i64_lt(cast_cn_bits_i32_to_cn_bits_i64(s_cn->W_D), convert_to_cn_bits_i64(2147483647LL)), PRE);
  cn_pop_msg_info();
  
	/* C OWNERSHIP */

  c_add_to_ghost_state((&s), sizeof(struct State), get_cn_stack_depth());
  cn_pointer* s_addr_cn = convert_to_cn_pointer((&s));
  

    // Plane on the runway
    if (CN_LOAD(s.Runway_Time) > 0)
    {
      if (CN_LOAD(s.Runway_Time) == 5)
      {
        CN_STORE(s, (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, reset_Runway_Time(CN_LOAD(s))));
      } else {
        CN_STORE(s, (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, increment_Runway_Time(CN_LOAD(s))));
      }
      { __cn_ret = CN_LOAD(s); goto __cn_epilogue; }
    }
    // Plane chosen to arrive
    else if (CN_LOAD(s.ModeA) == 1 && CN_LOAD(s.W_A) > 0 && CN_LOAD(s.Plane_Counter) < 3) {
      CN_STORE(s, (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, arrive(CN_LOAD(s))));
      CN_STORE(s, (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, increment_Runway_Time(CN_LOAD(s))));
      { __cn_ret = CN_LOAD(s); goto __cn_epilogue; }
    }
    // Plane chosen to depart
    else if (CN_LOAD(s.ModeD) == 1 && CN_LOAD(s.W_D) > 0 && CN_LOAD(s.Plane_Counter) < 3) {
      CN_STORE(s, (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, depart(CN_LOAD(s))));
      CN_STORE(s, (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, increment_Runway_Time(CN_LOAD(s))));
      { __cn_ret = CN_LOAD(s); goto __cn_epilogue; }
    }
    // Need to switch modes
    else {
      // Need to switch from arrival to departure mode
      if (CN_LOAD(s.ModeA) == 1) {
        CN_STORE(s, (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, reset_Plane_Counter(CN_LOAD(s))));
        CN_STORE(s, (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, switch_modes(CN_LOAD(s))));
        // If there are planes waiting to depart, let one depart
        if (CN_LOAD(s.W_D) > 0) {
          CN_STORE(s, (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, depart(CN_LOAD(s))));
          CN_STORE(s, (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, increment_Runway_Time(CN_LOAD(s))));
        }
        { __cn_ret = CN_LOAD(s); goto __cn_epilogue; }
      }
      // Need to switch from departure to arrival mode
      else if (CN_LOAD(s.ModeD) == 1) {
        CN_STORE(s, (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, reset_Plane_Counter(CN_LOAD(s))));
        CN_STORE(s, (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, switch_modes(CN_LOAD(s))));


        // If there are planes waiting to arrive, let one arrive
        if (CN_LOAD(s.W_A) > 0) {
          CN_STORE(s, (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, arrive(CN_LOAD(s))));

          CN_STORE(s, (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, increment_Runway_Time(CN_LOAD(s))));
        }
        { __cn_ret = CN_LOAD(s); goto __cn_epilogue; }
      }
      // If neither mode is active, then it must be the beginning of the day.
      else {
        if (CN_LOAD(s.W_A) > 0) {
          CN_STORE(s.ModeA, 1);
          CN_STORE(s, (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, arrive(CN_LOAD(s))));
          CN_STORE(s, (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, increment_Runway_Time(CN_LOAD(s))));
          { __cn_ret = CN_LOAD(s); goto __cn_epilogue; }
        } else if (CN_LOAD(s.W_D) > 0) {
          CN_STORE(s.ModeD, 1);
          CN_STORE(s, (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, depart(CN_LOAD(s))));
          CN_STORE(s, (
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, increment_Runway_Time(CN_LOAD(s))));
          { __cn_ret = CN_LOAD(s); goto __cn_epilogue; }
        } else {
          // No planes are waiting, so we choose arrival mode and wait
          CN_STORE(s.ModeA, 1);
          { __cn_ret = CN_LOAD(s); goto __cn_epilogue; }
        }
      }
    }

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  
	/* C OWNERSHIP */


  c_remove_from_ghost_state((&s), sizeof(struct State));

{
  struct State_cn* return_cn = convert_to_struct_State_cn(__cn_ret);
  update_cn_error_message_info("    ensures valid_state(return);\n            ^~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:129:13-33");
  cn_assert(valid_state(return_cn), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("            (s.W_A > 0i32 && s.W_D == 0i32 && s.Runway_Time == 0i32 implies return.ModeA == ACTIVE());\n            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:130:13-103");
  cn_assert(cn_bool_implies(cn_bool_and(cn_bool_and(cn_bits_i32_lt(convert_to_cn_bits_i32(0LL), s_cn->W_A), cn_bits_i32_equality(s_cn->W_D, convert_to_cn_bits_i32(0LL))), cn_bits_i32_equality(s_cn->Runway_Time, convert_to_cn_bits_i32(0LL))), cn_bits_i32_equality(return_cn->ModeA, ACTIVE())), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("            (s.W_D > 0i32 && s.W_A == 0i32 && s.Runway_Time == 0i32 implies return.ModeD == ACTIVE());\n            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/results/runway__funcs2/20261016-concrete-constants-probe/bool-header-harness.cn.c:131:13-103");
  cn_assert(cn_bool_implies(cn_bool_and(cn_bool_and(cn_bits_i32_lt(convert_to_cn_bits_i32(0LL), s_cn->W_D), cn_bits_i32_equality(s_cn->W_A, convert_to_cn_bits_i32(0LL))), cn_bits_i32_equality(s_cn->Runway_Time, convert_to_cn_bits_i32(0LL))), cn_bits_i32_equality(return_cn->ModeD, ACTIVE())), POST);
  cn_pop_msg_info();
  ghost_stack_depth_decr();
  cn_postcondition_leak_check();
}

  cn_bump_free_after(__cn_bump_count_a_2086);

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
   struct State s={1,0,0,1,0,0};
c_add_to_ghost_state((&s), sizeof(struct State), get_cn_stack_depth());


cn_pointer* s_addr_cn = convert_to_cn_pointer((&s));
 struct State result=(
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, increment_Plane_Counter(CN_LOAD(s)));
c_add_to_ghost_state((&result), sizeof(struct State), get_cn_stack_depth());


cn_pointer* result_addr_cn = convert_to_cn_pointer((&result));
 (void)CN_LOAD(result); { __cn_ret = 0; 
c_remove_from_ghost_state((&s), sizeof(struct State));


c_remove_from_ghost_state((&result), sizeof(struct State));
goto __cn_epilogue; } 
c_remove_from_ghost_state((&s), sizeof(struct State));


c_remove_from_ghost_state((&result), sizeof(struct State));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  free_ghost_frame_stack();

return __cn_ret;

}

/* RECORD */

/* CONVERSION */

/* GENERATED STRUCT FUNCTIONS */

static struct State_cn* default_struct_State_cn()
{
  struct State_cn* a_2377 = (struct State_cn*) cn_bump_malloc(sizeof(struct State_cn));
  a_2377->ModeA = default_cn_bits_i32();
  a_2377->ModeD = default_cn_bits_i32();
  a_2377->W_A = default_cn_bits_i32();
  a_2377->W_D = default_cn_bits_i32();
  a_2377->Runway_Time = default_cn_bits_i32();
  a_2377->Plane_Counter = default_cn_bits_i32();
  return a_2377;
}
static void* cn_map_get_struct_State_cn(cn_map* m, cn_integer* key)
{
  void* ret = ht_get(m, (&key->val));
  if (0 == ret)
    return (void*) default_struct_State_cn();
  else
    return ret;
}
static cn_bool* struct_State_cn_equality(void* x, void* y)
{
  struct State_cn* x_cast = (struct State_cn*) x;
  struct State_cn* y_cast = (struct State_cn*) y;
  return cn_bool_and(cn_bool_and(cn_bool_and(cn_bool_and(cn_bool_and(cn_bool_and(convert_to_cn_bool(true), cn_bits_i32_equality(x_cast->ModeA, y_cast->ModeA)), cn_bits_i32_equality(x_cast->ModeD, y_cast->ModeD)), cn_bits_i32_equality(x_cast->W_A, y_cast->W_A)), cn_bits_i32_equality(x_cast->W_D, y_cast->W_D)), cn_bits_i32_equality(x_cast->Runway_Time, y_cast->Runway_Time)), cn_bits_i32_equality(x_cast->Plane_Counter, y_cast->Plane_Counter));
}
static struct State convert_from_struct_State_cn(struct State_cn* State)
{
  struct State res;
  res.ModeA = convert_from_cn_bits_i32(State->ModeA);
  res.ModeD = convert_from_cn_bits_i32(State->ModeD);
  res.W_A = convert_from_cn_bits_i32(State->W_A);
  res.W_D = convert_from_cn_bits_i32(State->W_D);
  res.Runway_Time = convert_from_cn_bits_i32(State->Runway_Time);
  res.Plane_Counter = convert_from_cn_bits_i32(State->Plane_Counter);
  return res;
}
static struct State_cn* convert_to_struct_State_cn(struct State State)
{
  struct State_cn* res = (struct State_cn*) cn_bump_malloc(sizeof(struct State_cn));
  res->ModeA = convert_to_cn_bits_i32(State.ModeA);
  res->ModeD = convert_to_cn_bits_i32(State.ModeD);
  res->W_A = convert_to_cn_bits_i32(State.W_A);
  res->W_D = convert_to_cn_bits_i32(State.W_D);
  res->Runway_Time = convert_to_cn_bits_i32(State.Runway_Time);
  res->Plane_Counter = convert_to_cn_bits_i32(State.Plane_Counter);
  return res;
}
/* OWNERSHIP FUNCTIONS */

/* OWNERSHIP FUNCTIONS */

/* CN FUNCTIONS */
static cn_bool* valid_state(struct State_cn* s)
{
  return cn_bool_and(cn_bool_and(cn_bool_and(cn_bool_and(cn_bool_and(cn_bool_and(cn_bool_and(cn_bool_and(cn_bool_and(cn_bool_or(cn_bits_i32_equality(s->ModeA, INACTIVE()), cn_bits_i32_equality(s->ModeA, ACTIVE())), cn_bool_or(cn_bits_i32_equality(s->ModeD, INACTIVE()), cn_bits_i32_equality(s->ModeD, ACTIVE()))), cn_bool_or(cn_bits_i32_equality(s->ModeA, INACTIVE()), cn_bits_i32_equality(s->ModeD, INACTIVE()))), cn_bool_and(cn_bits_i32_le(convert_to_cn_bits_i32(0LL), s->W_A), cn_bits_i32_le(convert_to_cn_bits_i32(0LL), s->W_D))), cn_bool_and(cn_bits_i32_le(convert_to_cn_bits_i32(0LL), s->Runway_Time), cn_bits_i32_le(s->Runway_Time, convert_to_cn_bits_i32(5LL)))), cn_bool_and(cn_bits_i32_le(convert_to_cn_bits_i32(0LL), s->Plane_Counter), cn_bits_i32_le(s->Plane_Counter, convert_to_cn_bits_i32(3LL)))), cn_bool_implies(cn_bool_and(cn_bits_i32_equality(s->ModeA, INACTIVE()), cn_bits_i32_equality(s->ModeD, INACTIVE())), cn_bits_i32_equality(s->Plane_Counter, convert_to_cn_bits_i32(0LL)))), cn_bool_implies(cn_bits_i32_lt(convert_to_cn_bits_i32(0LL), s->Runway_Time), cn_bool_or(cn_bits_i32_equality(s->ModeA, ACTIVE()), cn_bits_i32_equality(s->ModeD, ACTIVE())))), cn_bool_implies(cn_bool_and(cn_bits_i32_lt(convert_to_cn_bits_i32(0LL), s->Plane_Counter), cn_bits_i32_equality(s->ModeA, ACTIVE())), cn_bits_i32_lt(convert_to_cn_bits_i32(0LL), s->W_D))), cn_bool_implies(cn_bool_and(cn_bits_i32_lt(convert_to_cn_bits_i32(0LL), s->Plane_Counter), cn_bits_i32_equality(s->ModeD, ACTIVE())), cn_bits_i32_lt(convert_to_cn_bits_i32(0LL), s->W_A)));
}
static cn_bits_i32* ACTIVE()
{
  return convert_to_cn_bits_i32(1LL);
}
static cn_bits_i32* INACTIVE()
{
  return convert_to_cn_bits_i32(0LL);
}
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

