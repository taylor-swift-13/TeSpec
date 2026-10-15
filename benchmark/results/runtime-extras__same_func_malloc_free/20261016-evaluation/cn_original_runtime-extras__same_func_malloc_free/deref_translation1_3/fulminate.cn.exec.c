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

struct div {
  signed int quot;
  signed int rem;
};

struct ldiv {
  signed long quot;
  signed long rem;
};

struct lldiv {
  signed long long quot;
  signed long long rem;
};


/* CN VERSIONS OF C STRUCTS */

struct div_cn {
  cn_bits_i32* quot;
  cn_bits_i32* rem;
};

struct ldiv_cn {
  cn_bits_i64* quot;
  cn_bits_i64* rem;
};

struct lldiv_cn {
  cn_bits_i64* quot;
  cn_bits_i64* rem;
};



/* OWNERSHIP FUNCTIONS */

static cn_bits_u32* deref_unsigned_int(cn_pointer*, enum spec_mode, struct loop_ownership*);
static cn_bits_u32* owned_unsigned_int(cn_pointer*, enum spec_mode, struct loop_ownership*);
/* CONVERSION FUNCTIONS */

/* GENERATED STRUCT FUNCTIONS */

static struct lldiv_cn* default_struct_lldiv_cn();
static struct ldiv_cn* default_struct_ldiv_cn();
static struct div_cn* default_struct_div_cn();
static void* cn_map_get_struct_lldiv_cn(cn_map*, cn_integer*);
static void* cn_map_get_struct_ldiv_cn(cn_map*, cn_integer*);
static void* cn_map_get_struct_div_cn(cn_map*, cn_integer*);
static cn_bool* struct_lldiv_cn_equality(void*, void*);
static cn_bool* struct_ldiv_cn_equality(void*, void*);
static cn_bool* struct_div_cn_equality(void*, void*);
static struct lldiv convert_from_struct_lldiv_cn(struct lldiv_cn*);
static struct ldiv convert_from_struct_ldiv_cn(struct ldiv_cn*);
static struct div convert_from_struct_div_cn(struct div_cn*);
static struct lldiv_cn* convert_to_struct_lldiv_cn(struct lldiv);
static struct ldiv_cn* convert_to_struct_ldiv_cn(struct ldiv);
static struct div_cn* convert_to_struct_div_cn(struct div);
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

# 0 "/home/yangfp/teSpec/benchmark/programs/runtime-extras__same_func_malloc_free/variants/cn_original_runtime-extras__same_func_malloc_free/tests/20261016-evaluation/deref_translation1_3/fulminate.cn.c"
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
# 1 "/home/yangfp/teSpec/benchmark/programs/runtime-extras__same_func_malloc_free/variants/cn_original_runtime-extras__same_func_malloc_free/tests/20261016-evaluation/deref_translation1_3/fulminate.cn.c"

# 1 "/home/yangfp/.opam/tespec-cn-20260416/lib/cerberus-lib/runtime/libc/include/stdlib.h" 1



typedef __cerbty_size_t size_t;
typedef __cerbty_wchar_t wchar_t;

typedef struct div div_t;
typedef struct ldiv ldiv_t;
typedef struct lldiv lldiv_t;
# 19 "/home/yangfp/.opam/tespec-cn-20260416/lib/cerberus-lib/runtime/libc/include/stdlib.h"
int atoi (const char *);
long atol (const char *);
long long atoll (const char *);
double atof (const char *);

double strtod(const char * restrict nptr, char ** restrict endptr);
float strtof(const char * restrict nptr, char ** restrict endptr);
long double strtold(const char * restrict nptr, char ** restrict endptr);

long int strtol(const char * restrict, char ** restrict, int);
long long int strtoll(const char * restrict, char ** restrict, int);
unsigned long int strtoul(const char * restrict, char ** restrict, int);
unsigned long long int strtoull(const char * restrict, char ** restrict, int);

int rand(void);
void srand(unsigned int seed);

void *aligned_alloc(size_t alignment, size_t size);
void *calloc(size_t nmemb, size_t size);
void free(void *ptr);
void *malloc(size_t size);
void *realloc(void *ptr, size_t size);

_Noreturn void abort(void);
int atexit(void (*func)(void));
int at_quick_exit(void (*func)(void));
_Noreturn void exit(int status);
_Noreturn void _Exit(int status);
_Noreturn void quick_exit(int status);

char *getenv(const char *name);
int system(const char *string);

void *bsearch(const void *key, const void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *));
void qsort(void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *));

int abs(int j);
long int labs(long int j);
long long int llabs(long long int j);

div_t div(int numer, int denom);
ldiv_t ldiv(long int numer, long int denom);
lldiv_t lldiv(long long int numer, long long int denom);

int mblen(const char *s, size_t n);
int mbtowc(wchar_t * restrict pwc, const char * restrict s, size_t n);
int wctomb(char *s, wchar_t wchar);

size_t mbstowcs(wchar_t * restrict pwcs, const char * restrict s, size_t n);
size_t wcstombs(char * restrict s, const wchar_t * restrict pwcs, size_t n);
# 3 "/home/yangfp/teSpec/benchmark/programs/runtime-extras__same_func_malloc_free/variants/cn_original_runtime-extras__same_func_malloc_free/tests/20261016-evaluation/deref_translation1_3/fulminate.cn.c" 2
void *cn_malloc(unsigned long size);
void cn_free_sized(void* p, unsigned long s);


unsigned int deref(unsigned int *p)
/*@ trusted;
requires
    take v1_ = Owned(p);
ensures
    take v2 = Owned(p);
    v1_ == v2;
    return == v1_;
@*/
{
  /* EXECUTABLE CN PRECONDITION */
  unsigned int __cn_ret;
  cn_bump_frame_id __cn_bump_count_a_705 = cn_bump_get_frame_id();
  ghost_stack_depth_incr();
  enum CN_GHOST_ENUM ghost_spec = EMPTY;
  if (ghost_spec != (enum CN_GHOST_ENUM) top_ghost_frame_tag())
  cn_ghost_arg_failure();
else
  ;
  cn_pointer* p_cn = convert_to_cn_pointer(p);
  pop_ghost_frame();
  update_cn_error_message_info("    take v1_ = Owned(p);\n         ^/home/yangfp/teSpec/benchmark/programs/runtime-extras__same_func_malloc_free/variants/cn_original_runtime-extras__same_func_malloc_free/tests/20261016-evaluation/deref_translation1_3/fulminate.cn.c:10:10:");
  cn_bits_u32* v1__cn = owned_unsigned_int(p_cn, PRE, 0);
  cn_pop_msg_info();
  
	/* C OWNERSHIP */

  c_add_to_ghost_state((&p), sizeof(unsigned int*), get_cn_stack_depth());
  cn_pointer* p_addr_cn = convert_to_cn_pointer((&p));
  
  { __cn_ret = CN_LOAD(*CN_LOAD(p)); goto __cn_epilogue; }

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  
	/* C OWNERSHIP */


  c_remove_from_ghost_state((&p), sizeof(unsigned int*));

{
  cn_bits_u32* return_cn = convert_to_cn_bits_u32(__cn_ret);
  update_cn_error_message_info("    take v2 = Owned(p);\n         ^/home/yangfp/teSpec/benchmark/programs/runtime-extras__same_func_malloc_free/variants/cn_original_runtime-extras__same_func_malloc_free/tests/20261016-evaluation/deref_translation1_3/fulminate.cn.c:12:10:");
  cn_bits_u32* v2_cn = owned_unsigned_int(p_cn, POST, 0);
  cn_pop_msg_info();
  update_cn_error_message_info("    v1_ == v2;\n    ^~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/runtime-extras__same_func_malloc_free/variants/cn_original_runtime-extras__same_func_malloc_free/tests/20261016-evaluation/deref_translation1_3/fulminate.cn.c:13:5-15");
  cn_assert(cn_bits_u32_equality(v1__cn, v2_cn), POST);
  cn_pop_msg_info();
  update_cn_error_message_info("    return == v1_;\n    ^~~~~~~~~~~~~~ /home/yangfp/teSpec/benchmark/programs/runtime-extras__same_func_malloc_free/variants/cn_original_runtime-extras__same_func_malloc_free/tests/20261016-evaluation/deref_translation1_3/fulminate.cn.c:14:5-19");
  cn_assert(cn_bits_u32_equality(return_cn, v1__cn), POST);
  cn_pop_msg_info();
  ghost_stack_depth_decr();
  cn_postcondition_leak_check();
}

  cn_bump_free_after(__cn_bump_count_a_705);

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
   unsigned int cell=2147483647u;
c_add_to_ghost_state((&cell), sizeof(unsigned int), get_cn_stack_depth());


cn_pointer* cell_addr_cn = convert_to_cn_pointer((&cell));
 unsigned int result=(
({
  push_ghost_frame(EMPTY, 0);
  0;
})
, deref(&cell));
c_add_to_ghost_state((&result), sizeof(unsigned int), get_cn_stack_depth());


cn_pointer* result_addr_cn = convert_to_cn_pointer((&result));
 (void)CN_LOAD(result); { __cn_ret = 0; 
c_remove_from_ghost_state((&cell), sizeof(unsigned int));


c_remove_from_ghost_state((&result), sizeof(unsigned int));
goto __cn_epilogue; } 
c_remove_from_ghost_state((&cell), sizeof(unsigned int));


c_remove_from_ghost_state((&result), sizeof(unsigned int));

/* EXECUTABLE CN POSTCONDITION */
__cn_epilogue:

  free_ghost_frame_stack();

return __cn_ret;

}

/* RECORD */

/* CONVERSION */

/* GENERATED STRUCT FUNCTIONS */

static struct lldiv_cn* default_struct_lldiv_cn()
{
  struct lldiv_cn* a_961 = (struct lldiv_cn*) cn_bump_malloc(sizeof(struct lldiv_cn));
  a_961->quot = default_cn_bits_i64();
  a_961->rem = default_cn_bits_i64();
  return a_961;
}
static struct ldiv_cn* default_struct_ldiv_cn()
{
  struct ldiv_cn* a_954 = (struct ldiv_cn*) cn_bump_malloc(sizeof(struct ldiv_cn));
  a_954->quot = default_cn_bits_i64();
  a_954->rem = default_cn_bits_i64();
  return a_954;
}
static struct div_cn* default_struct_div_cn()
{
  struct div_cn* a_947 = (struct div_cn*) cn_bump_malloc(sizeof(struct div_cn));
  a_947->quot = default_cn_bits_i32();
  a_947->rem = default_cn_bits_i32();
  return a_947;
}
static void* cn_map_get_struct_lldiv_cn(cn_map* m, cn_integer* key)
{
  void* ret = ht_get(m, (&key->val));
  if (0 == ret)
    return (void*) default_struct_lldiv_cn();
  else
    return ret;
}
static void* cn_map_get_struct_ldiv_cn(cn_map* m, cn_integer* key)
{
  void* ret = ht_get(m, (&key->val));
  if (0 == ret)
    return (void*) default_struct_ldiv_cn();
  else
    return ret;
}
static void* cn_map_get_struct_div_cn(cn_map* m, cn_integer* key)
{
  void* ret = ht_get(m, (&key->val));
  if (0 == ret)
    return (void*) default_struct_div_cn();
  else
    return ret;
}
static cn_bool* struct_lldiv_cn_equality(void* x, void* y)
{
  struct lldiv_cn* x_cast = (struct lldiv_cn*) x;
  struct lldiv_cn* y_cast = (struct lldiv_cn*) y;
  return cn_bool_and(cn_bool_and(convert_to_cn_bool(true), cn_bits_i64_equality(x_cast->quot, y_cast->quot)), cn_bits_i64_equality(x_cast->rem, y_cast->rem));
}
static cn_bool* struct_ldiv_cn_equality(void* x, void* y)
{
  struct ldiv_cn* x_cast = (struct ldiv_cn*) x;
  struct ldiv_cn* y_cast = (struct ldiv_cn*) y;
  return cn_bool_and(cn_bool_and(convert_to_cn_bool(true), cn_bits_i64_equality(x_cast->quot, y_cast->quot)), cn_bits_i64_equality(x_cast->rem, y_cast->rem));
}
static cn_bool* struct_div_cn_equality(void* x, void* y)
{
  struct div_cn* x_cast = (struct div_cn*) x;
  struct div_cn* y_cast = (struct div_cn*) y;
  return cn_bool_and(cn_bool_and(convert_to_cn_bool(true), cn_bits_i32_equality(x_cast->quot, y_cast->quot)), cn_bits_i32_equality(x_cast->rem, y_cast->rem));
}
static struct lldiv convert_from_struct_lldiv_cn(struct lldiv_cn* lldiv)
{
  struct lldiv res;
  res.quot = convert_from_cn_bits_i64(lldiv->quot);
  res.rem = convert_from_cn_bits_i64(lldiv->rem);
  return res;
}
static struct ldiv convert_from_struct_ldiv_cn(struct ldiv_cn* ldiv)
{
  struct ldiv res;
  res.quot = convert_from_cn_bits_i64(ldiv->quot);
  res.rem = convert_from_cn_bits_i64(ldiv->rem);
  return res;
}
static struct div convert_from_struct_div_cn(struct div_cn* div)
{
  struct div res;
  res.quot = convert_from_cn_bits_i32(div->quot);
  res.rem = convert_from_cn_bits_i32(div->rem);
  return res;
}
static struct lldiv_cn* convert_to_struct_lldiv_cn(struct lldiv lldiv)
{
  struct lldiv_cn* res = (struct lldiv_cn*) cn_bump_malloc(sizeof(struct lldiv_cn));
  res->quot = convert_to_cn_bits_i64(lldiv.quot);
  res->rem = convert_to_cn_bits_i64(lldiv.rem);
  return res;
}
static struct ldiv_cn* convert_to_struct_ldiv_cn(struct ldiv ldiv)
{
  struct ldiv_cn* res = (struct ldiv_cn*) cn_bump_malloc(sizeof(struct ldiv_cn));
  res->quot = convert_to_cn_bits_i64(ldiv.quot);
  res->rem = convert_to_cn_bits_i64(ldiv.rem);
  return res;
}
static struct div_cn* convert_to_struct_div_cn(struct div div)
{
  struct div_cn* res = (struct div_cn*) cn_bump_malloc(sizeof(struct div_cn));
  res->quot = convert_to_cn_bits_i32(div.quot);
  res->rem = convert_to_cn_bits_i32(div.rem);
  return res;
}
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


/* CN LEMMAS */

