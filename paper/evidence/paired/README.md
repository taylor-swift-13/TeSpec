# Paired development observations

CN verifies the full contract domain; Fulminate runs a concrete fixture;
TeSpec checks a symbolic instance. Repeated baselines across modes are
not independent subjects. UNPROVED and UNKNOWN do not establish violations.
Proof-completed replays and QCP universal checks are reported separately.

| Subject | Mode | Variant | CN | Fulminate | TeSpec | Require / execution / post / annotations |
|---|---|---|---|---|---|---|
| alias_shared | expand | valid | VERIFIED | RUNTIME_PASS | PASS | SAT / PASS / PASS / NOT_RUN |
| alias_shared | expand | wrong_post | UNPROVED | RUNTIME_VIOLATION | UNKNOWN | SAT / PASS / UNKNOWN / NOT_RUN |
| alias_shared | no-expand | valid | VERIFIED | RUNTIME_PASS | PASS | SAT / PASS / PASS / PASS |
| alias_shared | no-expand | wrong_post | UNPROVED | RUNTIME_VIOLATION | UNKNOWN | SAT / PASS / UNKNOWN / PASS |
| array_cells | expand | valid | VERIFIED | RUNTIME_PASS | PASS | SAT / PASS / PASS / NOT_RUN |
| array_cells | expand | wrong_post | UNPROVED | RUNTIME_VIOLATION | UNKNOWN | SAT / PASS / UNKNOWN / NOT_RUN |
| heap_loop | expand | valid | VERIFIED | RUNTIME_PASS | PASS | SAT / PASS / PASS / NOT_RUN |
| heap_loop | expand | wrong_post | UNPROVED | RUNTIME_VIOLATION | UNKNOWN | SAT / PASS / UNKNOWN / NOT_RUN |
| heap_loop | no-expand | valid | VERIFIED | RUNTIME_PASS | PASS | SAT / PASS / PASS / PASS |
| heap_loop | no-expand | wrong_post | UNPROVED | RUNTIME_VIOLATION | UNKNOWN | SAT / PASS / UNKNOWN / PASS |
| list_length | expand | valid | VERIFIED | RUNTIME_PASS | UNKNOWN | UNKNOWN / PASS / PASS / NOT_RUN |
| list_length | expand | wrong_post | UNPROVED | RUNTIME_VIOLATION | UNKNOWN | UNKNOWN / PASS / UNKNOWN / NOT_RUN |
| list_length | no-expand | valid | VERIFIED | RUNTIME_PASS | UNKNOWN | UNKNOWN / PASS / PASS / PASS |
| list_length | no-expand | wrong_post | UNPROVED | RUNTIME_VIOLATION | UNKNOWN | UNKNOWN / PASS / UNKNOWN / UNKNOWN |
| nested_call | expand | valid | VERIFIED | RUNTIME_PASS | PASS | SAT / PASS / PASS / NOT_RUN |
| nested_call | expand | wrong_post | UNPROVED | RUNTIME_VIOLATION | UNKNOWN | SAT / PASS / UNKNOWN / NOT_RUN |
| nested_call | no-expand | valid | VERIFIED | RUNTIME_PASS | PASS | SAT / PASS / PASS / PASS |
| nested_call | no-expand | wrong_post | UNPROVED | RUNTIME_VIOLATION | UNKNOWN | SAT / PASS / UNKNOWN / PASS |
| pointer_cell | expand | valid | VERIFIED | RUNTIME_PASS | PASS | SAT / PASS / PASS / NOT_RUN |
| pointer_cell | expand | wrong_post | UNPROVED | RUNTIME_VIOLATION | UNKNOWN | SAT / PASS / UNKNOWN / NOT_RUN |
| pointer_cell | no-expand | valid | VERIFIED | RUNTIME_PASS | PASS | SAT / PASS / PASS / PASS |
| pointer_cell | no-expand | wrong_post | UNPROVED | RUNTIME_VIOLATION | UNKNOWN | SAT / PASS / UNKNOWN / PASS |
| recursive_heap | expand | valid | VERIFIED | RUNTIME_PASS | PASS | SAT / PASS / PASS / NOT_RUN |
| recursive_heap | expand | wrong_post | UNPROVED | RUNTIME_VIOLATION | UNKNOWN | SAT / PASS / UNKNOWN / NOT_RUN |
| recursive_heap | no-expand | valid | VERIFIED | RUNTIME_PASS | PASS | SAT / PASS / PASS / PASS |
| recursive_heap | no-expand | wrong_post | UNPROVED | RUNTIME_VIOLATION | UNKNOWN | SAT / PASS / UNKNOWN / PASS |
| recursive_heap_weak | no-expand | valid | UNPROVED | RUNTIME_PASS | PASS | SAT / PASS / PASS / PASS |
| recursive_heap_weak | no-expand | wrong_post | UNPROVED | RUNTIME_VIOLATION | UNKNOWN | SAT / PASS / UNKNOWN / PASS |
| single_cell | expand | valid | VERIFIED | RUNTIME_PASS | PASS | SAT / PASS / PASS / NOT_RUN |
| single_cell | expand | wrong_post | UNPROVED | RUNTIME_VIOLATION | UNKNOWN | SAT / PASS / UNKNOWN / NOT_RUN |
| struct_fields | expand | valid | VERIFIED | RUNTIME_PASS | PASS | SAT / PASS / PASS / NOT_RUN |
| struct_fields | expand | wrong_post | UNPROVED | RUNTIME_VIOLATION | UNKNOWN | SAT / PASS / UNKNOWN / NOT_RUN |
| swap | expand | valid | VERIFIED | RUNTIME_PASS | PASS | SAT / PASS / PASS / NOT_RUN |
| swap | expand | wrong_post | UNPROVED | RUNTIME_VIOLATION | UNKNOWN | SAT / PASS / UNKNOWN / NOT_RUN |
