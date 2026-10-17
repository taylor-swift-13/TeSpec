#include <bennet/prelude.h>


#define bennet_domain_product(ty) struct bennet_domain_product_##ty

#define BENNET_DOMAIN_PRODUCT_DECL(ty)\
bennet_domain_product(ty) {bennet_domain_ownership(ty) element_0;};\
\
static inline bennet_domain_product(ty)* bennet_domain_product_top_##ty(void) {\
  bennet_domain_product(ty)* result = std_malloc(sizeof(bennet_domain_product(ty)));\
  result->element_0 = *bennet_domain_ownership_top_##ty();\
  return result;\
}\
static inline bool bennet_domain_product_is_top_##ty(bennet_domain_product(ty)* ptr)\
{  return bennet_domain_ownership_is_top_##ty(&ptr->element_0);}\
static inline bennet_domain_product(ty)* bennet_domain_product_bottom_##ty(void) {\
  bennet_domain_product(ty)* result = std_malloc(sizeof(bennet_domain_product(ty)));\
  result->element_0 = *bennet_domain_ownership_bottom_##ty();\
  return result;\
}\
static inline bool bennet_domain_product_is_bottom_##ty(bennet_domain_product(ty)* ptr)\
{  return bennet_domain_ownership_is_bottom_##ty(&ptr->element_0);}\
static inline bool bennet_domain_product_leq_##ty(bennet_domain_product(ty)* ptr1, bennet_domain_product(ty)* ptr2)\
{  return bennet_domain_ownership_leq_##ty(&ptr1->element_0, &ptr2->element_0);}\
static inline bool bennet_domain_product_equal_##ty(bennet_domain_product(ty)* ptr1, bennet_domain_product(ty)* ptr2)\
{  return bennet_domain_ownership_equal_##ty(&ptr1->element_0, &ptr2->element_0);}\
static inline bennet_domain_product(ty)* bennet_domain_product_join_##ty(bennet_domain_product(ty)* ptr1, bennet_domain_product(ty)* ptr2)\
{  bennet_domain_product(ty)* result = std_malloc(sizeof(bennet_domain_product(ty)));\
  result->element_0 = *bennet_domain_ownership_join_##ty(&ptr1->element_0, &ptr2->element_0);\
  return result;}\
static inline void bennet_domain_product_reduce_##ty(bennet_domain_product(ty)* ptr)\
{  (void)ptr;}\
static inline bennet_domain_product(ty)* bennet_domain_product_meet_##ty(bennet_domain_product(ty)* ptr1, bennet_domain_product(ty)* ptr2)\
{  bennet_domain_product(ty)* result = std_malloc(sizeof(bennet_domain_product(ty)));\
  result->element_0 = *bennet_domain_ownership_meet_##ty(&ptr1->element_0, &ptr2->element_0);\
  bennet_domain_product_reduce_##ty(result);\
  return result;}\
static inline bennet_domain_product(ty)* bennet_domain_product_copy_##ty(bennet_domain_product(ty)* ptr)\
{  bennet_domain_product(ty)* result = std_malloc(sizeof(bennet_domain_product(ty)));\
  result->element_0 = ptr->element_0;\
  return result;}\
static inline ty bennet_domain_product_arbitrary_##ty(bennet_domain_product(ty)* ptr){int which = 0;\
for (int attempt = 0; attempt < 10; attempt++)\
{ty res;\
switch(which){case 0:; res = bennet_domain_ownership_arbitrary_##ty(&ptr->element_0);return res;default: assert(false); break;}}assert(false); return 0;}\
static inline bennet_domain_product(ty)* bennet_domain_product_from_assignment_##ty(void *base_ptr, void *addr, size_t bytes) {\
  bennet_domain_product(ty)* result = std_malloc(sizeof(bennet_domain_product(ty)));\
  result->element_0 = *bennet_domain_ownership_from_assignment_##ty(base_ptr, addr, bytes);\
  bennet_domain_product_reduce_##ty(result);\
  return result;\
}\
static inline bennet_domain_product(ty)* bennet_domain_product_of_##ty(size_t before, size_t after) {\
  bennet_domain_product(ty)* result = std_malloc(sizeof(bennet_domain_product(ty)));\
  result->element_0 = *bennet_domain_ownership_of_##ty(before, after);\
  bennet_domain_product_reduce_##ty(result);\
  return result;\
}\
static inline bool bennet_domain_product_check_##ty(ty val, bennet_domain_product(ty)* ptr)\
{  return bennet_domain_ownership_check_##ty(val, &ptr->element_0);}\
static inline bool bennet_domain_product_check_ownership_##ty(ty val, bennet_domain_product(ty)* ptr)\
{  return bennet_domain_ownership_check_##ty(val, &ptr->element_0);}\
static inline bennet_domain_product(ty)* bennet_domain_product_top_except_ownership_##ty(bennet_domain_product(ty)* ptr)\
{  bennet_domain_product(ty)* result = std_malloc(sizeof(bennet_domain_product(ty)));\
  result->element_0 = ptr->element_0;\
  bennet_domain_product_reduce_##ty(result);\
  return result;}\
static inline bennet_domain_product(ty)* bennet_domain_product_from_ownership_##ty(bennet_domain_ownership(ty)* own)\
{  bennet_domain_product(ty)* result = std_malloc(sizeof(bennet_domain_product(ty)));\
  result->element_0 = *own;\
  bennet_domain_product_reduce_##ty(result);\
  return result;}\
static inline bool bennet_domain_product_to_interval_##ty(bennet_domain_product(ty)* ptr, ty* lo_out, ty* hi_out)\
{  ty _lo = 0, _hi = 0;\
  bool _valid = false;\
  {\
    ty _tlo, _thi;\
    if (bennet_domain_ownership_to_interval_##ty(&ptr->element_0, &_tlo, &_thi)) {\
      if (_valid) {\
        if (_tlo > _lo) _lo = _tlo;\
        if (_thi < _hi) _hi = _thi;\
      } else {\
        _lo = _tlo;\
        _hi = _thi;\
        _valid = true;\
      }\
    }\
  }\
  if (_valid) {\
    *lo_out = _lo;\
    *hi_out = _hi;\
  }\
  return _valid;}\
static inline bennet_domain_product(ty)* bennet_domain_product_of_interval_##ty(ty lo, ty hi)\
{  bennet_domain_product(ty)* result = std_malloc(sizeof(bennet_domain_product(ty)));\
  result->element_0 = *bennet_domain_ownership_of_interval_##ty(lo, hi);\
  return result;}\
static inline bennet_domain_product(ty)* bennet_domain_product_refine_##ty(bennet_domain_product(ty)* ptr, bennet_absint_sym x_sym, cn_base_type* x_bt, cn_term* constraint_term, bool* is_bottom_out)\
{  bennet_domain_product(ty)* result = std_malloc(sizeof(bennet_domain_product(ty)));\
  {\
    bennet_absint_state* _state_ownership = bennet_absint_state_create();\
    _state_ownership = bennet_absint_state_set_ownership(_state_ownership, x_sym, bennet_tagged_domain_create(x_bt, &ptr->element_0));\
    _state_ownership = bennet_ownership_transform_backward_assume(constraint_term, true, _state_ownership);\
    if (bennet_absint_state_is_bottom_ownership(_state_ownership)) {\
      *is_bottom_out = true;\
      return ptr;\
    }\
    bennet_tagged_domain _new_ownership = bennet_absint_state_get_ownership(_state_ownership, x_sym, x_bt);\
    result->element_0 = *(bennet_domain_ownership(ty)*)_new_ownership.domain;\
  }\
  bennet_domain_product_reduce_##ty(result);\
  if (bennet_domain_product_is_bottom_##ty(result)) {\
    *is_bottom_out = true;\
    std_free(result);\
    return ptr;\
  }\
  *is_bottom_out = false;\
  return result;}\
static inline bennet_domain_product(ty)* bennet_domain_product_transform_backward_##ty(cn_term* term, bennet_absint_sym target_sym, cn_base_type* output_bt, cn_base_type* target_bt, bennet_domain_product(ty)* output_domain)\
{  bennet_domain_product(ty)* result = std_malloc(sizeof(bennet_domain_product(ty)));\
  {\
    bennet_absint_state* _state = bennet_absint_state_create();\
    bennet_tagged_domain _out = bennet_tagged_domain_create(output_bt, &output_domain->element_0);\
    _state = bennet_absint_state_set_ownership(_state, target_sym, bennet_tagged_domain_top_ownership(output_bt));\
    _state = bennet_ownership_transform_backward(term, target_sym, _out, _state);\
    if (bennet_absint_state_is_bottom_ownership(_state)) {\
      return bennet_domain_product_bottom_##ty();\
    }\
    bennet_tagged_domain _new = bennet_absint_state_get_ownership(_state, target_sym, output_bt);\
    result->element_0 = *(bennet_domain_ownership(ty)*)_new.domain;\
  }\
  bennet_domain_product_reduce_##ty(result);\
  return result;}\
static inline void* bennet_domain_product_get_element_0_##ty(void* domain)\
{  return &((bennet_domain_product(ty)*)domain)->element_0;}\



BENNET_DOMAIN_PRODUCT_DECL(int8_t)
BENNET_DOMAIN_PRODUCT_DECL(uint8_t)
BENNET_DOMAIN_PRODUCT_DECL(int16_t)
BENNET_DOMAIN_PRODUCT_DECL(uint16_t)
BENNET_DOMAIN_PRODUCT_DECL(int32_t)
BENNET_DOMAIN_PRODUCT_DECL(uint32_t)
BENNET_DOMAIN_PRODUCT_DECL(int64_t)
BENNET_DOMAIN_PRODUCT_DECL(uint64_t)
BENNET_DOMAIN_PRODUCT_DECL(uintptr_t)


static inline void* bennet_domain_product_get_element_0(cn_base_type* type, void* domain)
{  if (type->tag == CN_BASE_LOC)
    return bennet_domain_product_get_element_0_uintptr_t(domain);
  assert(type->tag == CN_BASE_BITS);
  if (type->data.bits.is_signed) {
    switch (type->data.bits.size_bits) {
      case 8: return bennet_domain_product_get_element_0_int8_t(domain);
      case 16: return bennet_domain_product_get_element_0_int16_t(domain);
      case 32: return bennet_domain_product_get_element_0_int32_t(domain);
      case 64: return bennet_domain_product_get_element_0_int64_t(domain);
      default: assert(0); return NULL;
    }
  } else {
    switch (type->data.bits.size_bits) {
      case 8: return bennet_domain_product_get_element_0_uint8_t(domain);
      case 16: return bennet_domain_product_get_element_0_uint16_t(domain);
      case 32: return bennet_domain_product_get_element_0_uint32_t(domain);
      case 64: return bennet_domain_product_get_element_0_uint64_t(domain);
      default: assert(0); return NULL;
    }
  }}


#define BENNET_DOMAIN_PRODUCT_RWS_DECL(ty)\
static inline bennet_domain_product(ty)* bennet_domain_product_refine_with_state_##ty(bennet_domain_product(ty)* ptr, bennet_absint_sym x_sym, cn_base_type* x_bt, cn_term* constraint_term, bool* is_bottom_out, bennet_absint_sym extra_sym, bennet_tagged_domain extra_domain)\
{  bennet_domain_product(ty)* result = std_malloc(sizeof(bennet_domain_product(ty)));\
  {\
    bennet_absint_state* _init_ownership = bennet_absint_state_create();\
    _init_ownership = bennet_absint_state_set_ownership(_init_ownership, extra_sym, bennet_tagged_domain_create(extra_domain.type, bennet_domain_product_get_element_0(extra_domain.type, extra_domain.domain)));\
    bennet_absint_state* _state_ownership = _init_ownership;\
    _state_ownership = bennet_absint_state_set_ownership(_state_ownership, x_sym, bennet_tagged_domain_create(x_bt, &ptr->element_0));\
    _state_ownership = bennet_ownership_transform_backward_assume(constraint_term, true, _state_ownership);\
    if (bennet_absint_state_is_bottom_ownership(_state_ownership)) {\
      *is_bottom_out = true;\
      return ptr;\
    }\
    bennet_tagged_domain _new_ownership = bennet_absint_state_get_ownership(_state_ownership, x_sym, x_bt);\
    result->element_0 = *(bennet_domain_ownership(ty)*)_new_ownership.domain;\
  }\
  bennet_domain_product_reduce_##ty(result);\
  if (bennet_domain_product_is_bottom_##ty(result)) {\
    *is_bottom_out = true;\
    std_free(result);\
    return ptr;\
  }\
  *is_bottom_out = false;\
  return result;}\



BENNET_DOMAIN_PRODUCT_RWS_DECL(int8_t)
BENNET_DOMAIN_PRODUCT_RWS_DECL(uint8_t)
BENNET_DOMAIN_PRODUCT_RWS_DECL(int16_t)
BENNET_DOMAIN_PRODUCT_RWS_DECL(uint16_t)
BENNET_DOMAIN_PRODUCT_RWS_DECL(int32_t)
BENNET_DOMAIN_PRODUCT_RWS_DECL(uint32_t)
BENNET_DOMAIN_PRODUCT_RWS_DECL(int64_t)
BENNET_DOMAIN_PRODUCT_RWS_DECL(uint64_t)
BENNET_DOMAIN_PRODUCT_RWS_DECL(uintptr_t)

#define bennet_domain_product_top(ty) bennet_domain_product_top_##ty()
#define bennet_domain_product_is_top(ty, ptr) bennet_domain_product_is_top_##ty(ptr)
#define bennet_domain_product_bottom(ty) bennet_domain_product_bottom_##ty()
#define bennet_domain_product_is_bottom(ty, ptr) bennet_domain_product_is_bottom_##ty(ptr)
#define bennet_domain_product_of(ty, ...) bennet_domain_product_of_##ty(__VA_ARGS__)
#define bennet_domain_product_refine(ty, ptr, sym, bt, constraint, out) bennet_domain_product_refine_##ty(ptr, sym, bt, constraint, out)
#define bennet_domain_product_refine_with_state(ty, ptr, sym, bt, constraint, out, extra_sym, extra_domain) bennet_domain_product_refine_with_state_##ty(ptr, sym, bt, constraint, out, extra_sym, extra_domain)
#define bennet_domain_product_top_except_ownership(ty, ptr) bennet_domain_product_top_except_ownership_##ty(ptr)
#define bennet_domain_product_from_ownership(ty, own) bennet_domain_product_from_ownership_##ty(own)
#define bennet_domain_product_transform_backward(ty, term, sym, out_bt, tgt_bt, out) bennet_domain_product_transform_backward_##ty(term, sym, out_bt, tgt_bt, out)


#define BENNET_DOMAIN_INDIRECTION(ty)\
bennet_domain(ty) {bennet_domain_product(ty) car;};\
\
bennet_domain(ty)* bennet_domain_top_##ty(void) {return (bennet_domain(ty)*)bennet_domain_product_top(ty);}\
bool bennet_domain_is_top_##ty(bennet_domain(ty)* cs) {return bennet_domain_product_is_top(ty, &cs->car);}\
\
bennet_domain(ty)* bennet_domain_bottom_##ty(void) {return (bennet_domain(ty)*)bennet_domain_product_bottom(ty);}\
bool bennet_domain_is_bottom_##ty(bennet_domain(ty)* cs) {return bennet_domain_product_is_bottom(ty, &cs->car);}\
\
bool bennet_domain_leq_##ty(bennet_domain(ty)* cs1, bennet_domain(ty)* cs2) {return bennet_domain_product_leq_##ty(&cs1->car, &cs2->car);}\
bool bennet_domain_equal_##ty(bennet_domain(ty)* cs1, bennet_domain(ty)* cs2) {return bennet_domain_product_equal_##ty(&cs1->car, &cs2->car);}\
\
bennet_domain(ty)* bennet_domain_join_##ty(bennet_domain(ty)* cs1, bennet_domain(ty)* cs2) {return (bennet_domain(ty)*)bennet_domain_product_join_##ty(&cs1->car, &cs2->car);}\
bennet_domain(ty)* bennet_domain_meet_##ty(bennet_domain(ty)* cs1, bennet_domain(ty)* cs2) {return (bennet_domain(ty)*)bennet_domain_product_meet_##ty(&cs1->car, &cs2->car);}\
\
bennet_domain(ty)* bennet_domain_copy_##ty(bennet_domain(ty)* cs) {return (bennet_domain(ty)*)bennet_domain_product_copy_##ty(&cs->car);}\
ty bennet_domain_arbitrary_##ty(bennet_domain(ty)* cs) {return bennet_domain_product_arbitrary_##ty(&cs->car);}\
bool bennet_domain_check_##ty(ty val, bennet_domain(ty)* cs) {return bennet_domain_product_check_##ty(val, &cs->car);}\
bool bennet_domain_check_ownership_##ty(ty val, bennet_domain(ty)* cs) {return bennet_domain_product_check_ownership_##ty(val, &cs->car);}\
\
bennet_domain(ty)* bennet_domain_from_assignment_##ty(void *base_ptr, void *addr, size_t bytes) {return (bennet_domain(ty)*)bennet_domain_product_from_assignment_##ty(base_ptr, addr, bytes);}\
bool bennet_domain_to_interval_##ty(bennet_domain(ty)* cs, ty* lo_out, ty* hi_out) {return bennet_domain_product_to_interval_##ty(&cs->car, lo_out, hi_out);}\
bennet_domain(ty)* bennet_domain_of_interval_##ty(ty lo, ty hi) {return (bennet_domain(ty)*)bennet_domain_product_of_interval_##ty(lo, hi);}\
\
bennet_domain(ty)* bennet_domain_top_except_ownership_##ty(bennet_domain(ty)* cs) {return (bennet_domain(ty)*)bennet_domain_product_top_except_ownership(ty, &cs->car);}\
bennet_domain(ty)* bennet_domain_from_ownership_##ty(bennet_domain_ownership(ty)* own) {return (bennet_domain(ty)*)bennet_domain_product_from_ownership(ty, own);}\
\
bennet_domain(ty)* bennet_domain_refine_##ty(bennet_domain(ty)* cs, bennet_absint_sym x_sym, cn_base_type* x_bt, cn_term* constraint_term, bool* is_bottom_out) {return (bennet_domain(ty)*)bennet_domain_product_refine(ty, &cs->car, x_sym, x_bt, constraint_term, is_bottom_out);}\
\
bennet_domain(ty)* bennet_domain_refine_with_state_##ty(bennet_domain(ty)* cs, bennet_absint_sym x_sym, cn_base_type* x_bt, cn_term* constraint_term, bool* is_bottom_out, bennet_absint_sym extra_sym, bennet_tagged_domain extra_domain) {return (bennet_domain(ty)*)bennet_domain_product_refine_with_state(ty, &cs->car, x_sym, x_bt, constraint_term, is_bottom_out, extra_sym, extra_domain);}\
\
bennet_domain(ty)* bennet_domain_transform_backward_##ty(cn_term* term, bennet_absint_sym target_sym, cn_base_type* output_bt, cn_base_type* target_bt, bennet_domain(ty)* output_domain) {return (bennet_domain(ty)*)bennet_domain_product_transform_backward(ty, term, target_sym, output_bt, target_bt, &output_domain->car);}\
\

BENNET_DOMAIN_INDIRECTION(int8_t)
BENNET_DOMAIN_INDIRECTION(uint8_t)
BENNET_DOMAIN_INDIRECTION(int16_t)
BENNET_DOMAIN_INDIRECTION(uint16_t)
BENNET_DOMAIN_INDIRECTION(int32_t)
BENNET_DOMAIN_INDIRECTION(uint32_t)
BENNET_DOMAIN_INDIRECTION(int64_t)
BENNET_DOMAIN_INDIRECTION(uint64_t)
BENNET_DOMAIN_INDIRECTION(uintptr_t)



#ifndef NULL
 #include <stdlib.h>
 #endif
 #include <stdint.h>
 #include <cn-executable/utils.h>
 #include <cn-executable/cerb_types.h>
 
/* ORIGINAL C STRUCTS AND UNIONS */

 
/* CN VERSIONS OF C STRUCTS */

 

/* OWNERSHIP FUNCTIONS */

  
/* GENERATED STRUCT FUNCTIONS */

  
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
 
 #include <bennet/prelude.h>
#include <cn-testing/prelude.h>
#include <cn-replicate/shape.h>
#include <cn-replicate/lines.h>

/* TAG DEFINITIONS */




////////////////////////////////
// Assume Ownership Functions //
////////////////////////////////

void assume_constant();

void assume_constant()
{
  return;
}

//////////////////////////////
/////// Shape Analyzers //////
//////////////////////////////

void cn_analyze_shape_constant();

void cn_analyze_shape_constant()
{}

//////////////////////////////
///////// Replicators ////////
//////////////////////////////

void cn_replicate_constant();

void cn_replicate_constant()
{
  cn_replica_lines_append("constant();");
}

//////////////////////////////
/// Constant function tests //
//////////////////////////////

signed int constant();
CN_EXTERN_UNIT_TEST_CASE(constant);

int main(int argc, char* argv[])
{
  //////////////////////////////
  /// Allocator Configuration //
  //////////////////////////////

  fulm_default_alloc.malloc = std_malloc;
  fulm_default_alloc.calloc = std_calloc;
  fulm_default_alloc.free = std_free;

  //////////////////////////////
  ////// Test Registration /////
  //////////////////////////////

  CN_REGISTER_EXTERN_UNIT_TEST_CASE(valid, constant);

  return cn_test_main(argc, argv);
}
/* RECORD */
 
 /* CONVERSION */
 
/* GENERATED STRUCT FUNCTIONS */

 
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

