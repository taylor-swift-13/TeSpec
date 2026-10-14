# CN → QCP benchmark validation

init_array2: all 3 previously residual VCs proved; complete 6-VC module checked.
init_array_rev: suffix/undefined-prefix strategies repaired and justified by 7 resource lemmas; complete 7-VC module checked.

37 complete VC modules and 345 VCs passed Coq 8.20.1 compilation and independent coqchk checking. Includes mergesort (40), full list_all (105), sized stack (30), and seven additional scalar programs (48). Proofs use no Admitted or new proof axioms. Runtime functional extensionality and opaque address evaluation remain recorded in assumptions.log.

manifest.json records each current translated source and native/kernel status. Native reports remain historical observations, so a residual automatic result can coexist with a completed manual proof. Original trusted allocator/free interfaces remain assumptions. Main/harness and paired CN/teSpec execution are not covered by these certificates.

The original guarded-CN queue helper contract has a concrete counterexample on both 32-bit and 64-bit C executions. The original translation and finding remain archived. The active corrected QCP variant uses standard sllseg and explicit non-null p: 22 automatic VCs were discharged and 2 manual VCs have kernel-checked proofs, together with resource lemmas justifying the new strategies. The old IntQueue_push target retains its native automatic result. Thus all 54 core files have verified QCP target variants under the auto-plus-manual criterion; the queue variant intentionally differs from original CN semantics. See advanced/queue-corrected/queue-spec-finding.md and verification-receipt.json. These 2 manual VCs are separate from the 37 complete-module / 345-VC ledger.

An isolated printer-only QCP correction is recorded in merge-sort/printer-toolchain.json. It fixes emitted struct field tags; no executor/solver semantics were changed, and no production binary was replaced.

Replay complete proofs with Coq 8.20 and the matching QCP runtime:

    python3 proofs/replay.py --runtime /path/to/QCP/SeparationLogic

Sources and evidence are hashed in manifest.json and proofs/report.json. Supplemental reverse and guarded-queue strategy proofs are included.
