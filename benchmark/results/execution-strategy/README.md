# Execution strategy validation

The final executor is recorded in ../spatial-smt-regressions/20261018-execution-strategies-final/executor-build.json.
These are implementation regression runs; they do not replace four-tool universal/ITP benchmark cost tables.

## Final evidence

- [Target parameter matrix](20261018-contract-modular-final/summary.md): singleton and dll_add, 168 executions completed, 168 remaining UNKNOWN Dll return obligations.
- [Singleton result/cost](20261018-contract-modular-final/Dbl_Linked_List__singleton/result-cost.md).
- [dll_add result/cost](20261018-contract-modular-final/dll_add/result-cost.md).
- [219 focused tests](20261018-unit-regression-final/receipt.json): 3 skipped, no failures.
- [Modular positive representatives](../spatial-smt-regressions/20261018-modular-positive-final/summary.md): 21 groups, 42 PASS; not exhaustive modular coverage.
- [Full default-strategy regression](../spatial-smt-regressions/20261018-execution-strategies-final/summary.md).
- [Unresolved target VCs](../tespec-unexpected/recheck-20261018-contract-modular.json).
- [Fixed conditional-post issue](../tespec-unexpected/recheck-20261018-conditional-post.json).

The 168 target costs are measured per execution with nested CLI, executor and spatial-SMT stages. No model or ITP calls ran in this native matrix. Reported token zero does not claim that developing this implementation consumed zero model tokens.

## Earlier attempts

Development-smoke directories preserve initial diagnostics. contract-modular-v1 is a measurement-worker configuration error: 168 worker invocations but zero native executions, explicitly NOT_RUN. contract-modular-v2 and unit-regression concern the earlier executor before the conditional-post fix. Their hashes and results remain historical; final evidence is listed above.
