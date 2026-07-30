# Artifact contract

## Durable roots

`e2e/<case-id>/` stores one direct spec-authoring task. A four-class task may
use any output root, but one root stores exactly one question.

Every finalized root contains `artifact-manifest.json` with schema
`tespec-artifact-manifest/v1`. Paths in manifests and task metadata are
root-relative POSIX paths. The manifest inventories every durable file with
role, byte size, and SHA-256, and carries a digest over the sorted inventory.

## Roles

- `input`: original sources, domain, candidate spec, binds, dependencies, and
  immutable mutants.
- `evidence`: counterexamples, proof certificates, Coq proof sources, and
  confirmed traces.
- `report`: deterministic execution reports, logs, matrices, and result JSON.
- `metadata`: changelogs and other durable task metadata.

Compiled Coq objects (`.vo`, `.vos`, `.vok`, `.glob`, `.aux`), Python bytecode,
and solver caches are transient. They must not be indexed or shipped.

## E2E layout

```text
e2e/CASE/
├── source/original/
├── spec/versions/
├── spec/final_spec.c
├── tests/binds.json
├── mutants/refinement/
├── mutants/heldout/
├── evidence/
├── reports/
├── manifest.json
└── artifact-manifest.json
```

The workflow-specific `manifest.json` records semantic counts and the frozen
spec version. `artifact-manifest.json` records file integrity.

## Four-class layout

```text
TASK_ROOT/
├── input/
│   ├── impl.c
│   └── spec.qcp
├── dependencies/
├── relations/
├── evidence/
│   ├── soundness/
│   └── completeness/
├── reports/
├── result.json
└── artifact-manifest.json
```

`input/` contains only the implementation and specification visible in that
question. Mutation relationships between questions belong in
`relations/lineage.json`; they are construction metadata, never an additional
question input.

`result.json` uses schema `tespec-four-class-result/v1`:

```json
{
  "schema": "tespec-four-class-result/v1",
  "label": "correct",
  "properties": {"sound": true, "complete": true},
  "evidence": {
    "soundness_certificate": "evidence/soundness/certificate.json",
    "completeness_certificate": "evidence/completeness/certificate.json"
  }
}
```

For a false property, replace its certificate with
`soundness_counterexample` or `completeness_counterexample`. Every evidence
value is a relative path to a durable file.

Classification truth table:

| Label | Sound | Complete |
|---|---:|---:|
| `correct` | true | true |
| `soundness` | true | false |
| `complete` | false | true |
| `incomparable` | false | false |

Legacy labels are not accepted because their axes used a different task
definition. Rematerialize those questions from `impl + spec`.
