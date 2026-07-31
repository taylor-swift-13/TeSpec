# Artifact contract

## Durable roots

`e2e/<case-id>/` stores one direct specification-authoring task.

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
