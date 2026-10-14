# Shared mathematical oracle controls

These independently checked propositions use the original mathematical relations
of COINS HumanEval/76 and VERINA basic/48. They are semantic controls, not runs of
the original agent pipelines, C verification results, or a success-rate comparison.

- `CoinsPower.v`: six accepted original example pairs and two rejected wrong-output
  pairs. Compilation and independent `coqchk` succeed; all audited results are
  closed under the global context.
- `VerinaSquare.lean`: five accepted square/nonsquare example pairs and two rejected
  wrong-output pairs. Lean 4.34.0 checks every theorem. The positive witnesses and
  one rejection are axiom-free; arithmetic nonexistence proofs use standard Lean
  `propext` and `Quot.sound`. No `sorryAx` is present. VERINA itself pins 4.18.0;
  this local control does not claim a pinned VERINA pipeline replay.

Reproduce with:

```sh
coqc CoinsPower.v
coqchk CoinsPower
lean +leanprover/lean4:v4.34.0 VerinaSquare.lean
```

These controls confirm that the comparator proof logics handle both acceptance
and checked rejection of the shared relations. A full C comparison additionally
requires a reviewed domain/Boolean bridge, execution-generated goals and heap
coverage. Source revisions and original hashes are in `../comparison-sources.json`.
