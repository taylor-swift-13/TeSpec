# Mutation protocol

## Operators

Use a diverse set of single-site changes:

1. relational or branch operator replacement;
2. arithmetic operator replacement;
3. constant perturbation;
4. loop start, bound, or step change;
5. omitted heap write;
6. wrong array index or struct field;
7. wrong return value;
8. omitted, duplicated, or reordered callee call;
9. update of the wrong linked-list node or link;
10. signed/unsigned or floating boundary change when defined by the domain.

Do not create syntax errors, crashes, nontermination, use-after-free, overflow,
or a second simultaneous mutation. Do not change annotations, definitions,
strategies, includes, types, or function signatures.

## Evidence classes

For a fixed spec version and bind:

| Reference | Mutant | Classification |
|---|---|---|
| PASS | FAIL | confirmed negative example |
| PASS | PASS | surviving test; inspect for equivalence or weak spec |
| PASS | UNKNOWN | unresolved, not negative |
| PASS | ERROR | invalid mutant/tool error |
| non-PASS | any | invalid evaluation iteration |

If a surviving mutant is observably equivalent for all legal inputs, mark it
equivalent. If it differs and the intended spec should distinguish it, revise
the spec, version it, and rerun the complete protocol.

## Final evaluation

Use refinement mutants only to repair the spec. Freeze the final spec before
creating held-out mutants. Report refinement mutation score and held-out
mutation score separately. Never replace a failed held-out result with a
selectively rerun mutant.
