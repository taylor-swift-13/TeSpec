# Read UNKNOWN adjudication with Coq

All twelve original UNKNOWN cases have formally refuted return VCs and spatial splits, plus proved satisfiable entry conditions. Each goal file is a byte-identical copy of the actual generated VC. Each proof uses a concrete, aligned four-byte heap at address 4096 with the exact input value, including INT_MIN and INT_MAX.

No generated `input_proof_auto` or `input_proof_manual` module containing Admitted is imported. All 36 theorem assumption audits report `Closed under the global context`. A single independent coqchk invocation checks all twelve refutation modules and their dependencies.

`receipt.json` records exact source hashes, commands, compilation logs, kernel check and wall times. `resolved-results.json` is a separate adjudicated view: 22 PASS, 32 FAIL, 7 expected ERROR, zero UNKNOWN. Original automatic results remain 22 PASS, 20 FAIL, 12 UNKNOWN, 7 ERROR. Automatic capability is unchanged; executor and SMT code were not modified.

Counting the approved memory-read ERROR class as expected outcomes, this fixed suite scores 49/61 with automatic testing alone and 61/61 with the Coq adjudications. This is not a claim of automatic 100% accuracy or general coverage.

The first two unsuccessful proof compilation attempts are retained under attempts/. They failed during proof construction; the final kernel-checked receipt is authoritative. Coq replay peak RSS and conversation authoring tokens were not measured; they are not reported as zero.
