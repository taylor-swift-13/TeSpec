# Bundled case routing

Inspect at least two relevant case directories before authoring a spec.

| Program shape | Primary examples |
|---|---|
| Scalar and one-cell heap | `cases/add_one`, `cases/read_cell`, `cases/increment_cell` |
| Arrays and closed structs | `cases/closed_struct_array`, `cases/znth_concrete_auto` |
| Finite loops | `cases/count_loop`, `cases/nested_loop`, `cases/sll_length_loop` |
| Visible callees and recursion | `cases/callee_heap`, `cases/callee_loop`, `cases/callee_recursive` |
| Singly linked layouts | `cases/sll_first_value`, `cases/composite_recursive_sll` |
| Doubly linked and composite heap | `cases/composite_loop_dll`, `cases/composite_recursive_bundle` |
| Nested recursive predicates | `cases/recursive_nested_composition` |
| User-defined separation predicates | `cases/generic_predicate`, `cases/xizi_single_link_empty` |
| Arbitrary and polymorphic Coq types | `cases/arbitrary_type`, `cases/polymorphic_type` |
| Floats and residual VCs | `cases/double_clamp`, `cases/float_operations`, `cases/residual_vc` |
| Larger multi-function examples | `cases/ip_jet_ctrl_send`, `cases/ip_wheel_friction`, `cases/struct_filter` |

Read each selected case's source, job/binds, dependency directory, and latest
report shape. Copy patterns only. Predicate names, concrete addresses, list
lengths, and proof text must come from the new target.
