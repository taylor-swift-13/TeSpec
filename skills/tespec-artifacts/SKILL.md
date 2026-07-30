---
name: tespec-artifacts
description: Initialize, clean, finalize, hash, and validate TeSpec artifact directories for direct end-to-end spec authoring and existing-spec four-class evaluation. Use when Codex creates, migrates, packages, audits, or hands off files under e2e/ or four-class result roots and must separate durable evidence from reproducible compiler caches.
---

# TeSpec artifact management

Use the bundled manager as the only writer of `artifact-manifest.json`.
Read [references/artifact-contract.md](references/artifact-contract.md) before
changing a task layout or result schema.

Resolve the manager as:

```bash
MANAGER="$TESPEC_ROOT/skills/tespec-artifacts/scripts/manage_artifacts.py"
```

Use the repository root as `TESPEC_ROOT` outside the container.

## Initialize

Create a new, empty task root:

```bash
python3 "$MANAGER" init --kind e2e --task-id CASE --root e2e/CASE
python3 "$MANAGER" init --kind four-class --task-id QUESTION --root ARTIFACT_ROOT
```

Never mix multiple tasks in one root. Keep all paths recorded by task metadata
relative to that root. Do not copy `.vo`, `.glob`, caches, or previous reports
into a new run.

## Clean

Preview removal of reproducible compiler/cache files, then apply it:

```bash
python3 "$MANAGER" clean --root TASK_ROOT
python3 "$MANAGER" clean --root TASK_ROOT --apply
```

The clean command may remove only the allowlisted transient formats. Never
delete source, binds, specs, witnesses, `.v` proof sources, logs, or JSON
reports as part of cache cleanup.

## Finalize and validate

Finalize only after the owning workflow has completed:

```bash
python3 "$MANAGER" finalize \
  --kind e2e --task-id CASE --root e2e/CASE
python3 "$MANAGER" finalize \
  --kind four-class --task-id QUESTION --root ARTIFACT_ROOT
python3 "$MANAGER" validate --manifest TASK_ROOT/artifact-manifest.json
```

Treat validation failure as a failed handoff. Do not manually edit hashes.
After any durable file changes, finalize again and revalidate.

For four-class tasks, `input/` contains only `impl.c` and `spec.qcp`;
cross-question mutation lineage belongs under `relations/`. `result.json` is
authoritative for the classification.
Write only `correct`, `soundness`, `complete`, or `incomparable`. Reject
legacy labels instead of silently changing their semantics.
