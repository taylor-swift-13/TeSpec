# Finite spatial VC to SMT: standalone module

This directory implements an **offline Python/Z3 backend**, with unit tests and
replay of frozen QCP path VCs. The standalone interface does not modify symbolic execution, build the executor,
or change historical PASS/FAIL/UNKNOWN/ERROR records. The teSpec main runner can
now opt into this backend with `--spatial-smt`; see [integration](../../docs/spatial-smt.md). The executor's existing C SMT library is not replaced or integrated.

## Interface and semantic scope

`finite_spatial_smt.check(vc)` returns `VALID`, `INVALID`, or `UNKNOWN` for the
**entailment VC**, not for an execution or whole program. `encode(vc)` exposes the
SMT formula and can emit a standalone SMT-LIB query. `INVALID` includes a byte
heap countermodel; it does not by itself establish path reachability.

The JSON schema is intentionally small and rejects unknown fields:

```json
{
  "schema": "finite-spatial-vc/v1",
  "layout": {
    "architecture_bits": 32,
    "byte_order": "big",
    "memory_rules": "naive_C_Rules"
  },
  "mode": "exact",
  "pre": [{"spatial": [{"kind": "cell", "address": 4096, "type": "i32", "value": 7}]}],
  "post": [{"spatial": []}]
}
```

Here the answer is `INVALID`: an owned integer occupies four bytes, while `emp`
owns none. In `frame` mode the same target can be matched with the entire cell
left over, so the answer is `VALID`.

Each `pre`/`post` list is a disjunction of symbolic heaps. Each heap has integer
`exists` binders, a conjunction of `pure` expressions, and a separating
conjunction of `spatial` atoms. Empty spatial lists mean `emp`, not heap-independent
truth. An empty alternative list means false. The mode is mandatory.

Supported atoms:

- `cell`: `address`, `type`, and optional `value`; `null`/missing value means QCP
  `undef_store`, which permits BOTH initialized and noninitialized owned bytes.
- `array`: base `address`, scalar `type`, concrete nonnegative `length`, optional
  `start` index, and optional element `values`. The element list must have exactly
  `length` entries. Missing/null values mean an undef array.
- `i8/u8`, `i16/u16`, `i32/u32`, `i64/u64`, `i128/u128`, `bool`, and `ptr`.
- Explicit `naive_C_Rules32`/`naive_C_Rules` with Arch32 or `naive_C_Rules64` with
  Arch64, big endian only. Unsupported profiles return UNKNOWN.

Arithmetic is mathematical integer arithmetic, with checked constant positive
divisors for `//` and `%`. This is not C integer division or machine arithmetic.
Calls, casts, bitwise operators, floating point, user-defined predicates,
fractional permissions, magic wand, and general recursive structures are outside
this fragment. Arbitrary unsupported predicates are never replaced by `true`.

## Encoding

Use shared arrays `D : Int -> Bool` (owned), `I : Int -> Bool` (initialized), and
`M : Int -> Int` (canonical byte modulo 256). For each symbolic heap:

1. Expand cells/arrays to byte addresses. Enforce scalar value range, address
   bounds, alignment, and pairwise distinct owned byte addresses.
2. Initialized cells require initialized bytes and the QCP big-endian byte
   representation of the value. Undef cells constrain ownership but not
   initialization/content. Canonical byte representatives preserve the supported
   predicates modulo QCP's `Byte.eqm` relation.
3. `exact` requires `D` equal to a finite `store` chain over the constant-false
   array. `frame` only requires target byte addresses to be present in `D`.
4. Antecedent existential witnesses are fresh outer satisfiability variables.
   Consequent witnesses remain inside `Exists` under negation. Separate
   alternatives have separate scopes.
5. A goal witness used directly as a typed cell value can be substituted by the
   unique in-range value decoded from that cell's bytes, provided its address
   contains no local witnesses. Other existential witnesses retain quantifiers.
   Direct quantified and eliminated encodings are compared in unit tests.
6. Ask SMT for `Enc(pre) AND NOT Enc(post)`. SAT means INVALID; UNSAT means VALID;
   timeout/unknown means UNKNOWN. Unsatisfiable antecedents are explicitly marked
   `vacuous`, never reported as successful executions.

The memory definitions were inspected in QCP `Mem.v`, `ConAssertion.v`,
`CommonAssertion.v`, `CArch.v`, `ArrayLibCore.v`, and `ArrayLib.v`. In particular:

- QCP typed stores allow address zero; this encoder adds no invented non-null
  constraint.
- QCP `int64`/`int128` stores align to four bytes; Arch64 pointers align to eight.
- `mstore_noninit` includes initialized bytes. Treating it as strictly uninitialized
  would incorrectly refute valid entailments.
- The fragment has no tokens/STS resources; the naive model's trivial state
  component is omitted. The encoding must not be used for richer STS assertions.

This implementation is **not formally proved or kernel certified**. Its evidence
consists of semantic inspection, targeted tests, independent concrete semantics,
bounded exhaustive differential checks, and offline SMT replay. An equivalence
proof against the precise QCP runtime and a checked SMT certificate path remain
separate work. Results retain `certificate: NOT_CHECKED`.

## Historical adapter

`qcp_import.py` accepts the `PROP / LOCAL / SEP` diagnostic format. Nonempty LOCAL,
unknown predicates/types, and ambiguous formats are rejected, never ignored.
Only return VCs are automatically assigned exact mode; other VC kinds require a
separately justified mode adapter. Source files and raw statuses are immutable.

`finite_qcp_terms.py` reduces only documented builtin finite list constructors,
`app`, `repeat_Z`, `Zlength`, and `Znth`. A goal list witness with an explicit
concrete length constraint is materialized as scalar witnesses. A quantified
formula is expanded only for the strict shape
`forall ID, lo <= i_ID && i_ID < hi -> body` (also `<= hi`), with concrete bounds
and one implication. The original length equalities remain in the formula.
Unbounded/nested/ambiguous quantifiers and custom functions are rejected. The
name `zeros` alone is NOT sufficient to infer a user predicate's definition.

Limits are explicit: 512 bytes per heap, 64 pre/post alternatives combined,
128 instantiated quantified indices, and 128 scalar witnesses per materialized
list. Budget failures remain UNKNOWN. These are engineering bounds, not proofs
that larger inputs cannot be decided.

## Reproduce (no end-to-end execution)

```sh
python3 -m pip install -r tools/finite_spatial_smt/requirements.txt
python3 tools/finite_spatial_smt/finite_spatial_smt.py example.json --smt2 query.smt2
python3 tools/finite_spatial_smt/run_unit_tests.py --output /tmp/spatial-unit-tests.json
python3 tools/finite_spatial_smt/scan_history.py \
  --root /path/to/historical/artifacts --output /tmp/spatial-inventory.json
python3 tools/finite_spatial_smt/collect_corpus.py \
  --inventory /tmp/spatial-inventory.json --output /tmp/spatial-corpus
python3 tools/finite_spatial_smt/replay_corpus.py \
  --corpus /tmp/spatial-corpus/cases.json --output /tmp/spatial-replay
```

Collection and replay refuse to overwrite existing directories. Every admitted
case links to raw VC IDs and source-file SHA-256 values. All unsupported raw VCs
and reasons remain in `inventory.jsonl.gz`. SMT-LIB queries, per-VC results,
countermodels, aggregate timing, and process peak RSS are saved separately.
Raw observation count includes report/executor/stdout copies; it must not be
reported as a count of independent programs or independent VCs.

`test_finite_spatial_smt.py` contains semantic/adversarial tests, a numeric boundary
matrix, seeded ground-heap differential cases, and exhaustive finite-domain
symbolic comparisons. `concrete_oracle.py` checks ground entailments independently
without importing Z3 and reconstructs cell-value witnesses with Python byte
decoding. Historical replay comparisons do not use expected labels inferred from
variant names. A VC can be VALID even when a variant is labelled negative, because
one concrete input may not expose that variant's bug.

## Repository layout

This standalone teSpec component lives in `tools/finite_spatial_smt/`; it uses the installed Z3 package and contains no vendored executor or solver source.

- `test_*.py` and `fixtures/`: component tests and frozen regression fixtures.
- `results/20261015/`: unit-test receipt and provenance.
- `results/development-pilots/`: development runs, excluded from benchmark counts.
- `../../benchmark/results/spatial-vc-encoding/`: final historical VC offline replay only.

The current integration test receipt is in `results/20261015-integration/`; the
earlier `results/20261015/` receipt records the original standalone source version.
