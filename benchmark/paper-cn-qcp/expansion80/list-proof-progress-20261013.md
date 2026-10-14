# List reference and mutation evidence

The guarded ABI32 profile preserves the original C bodies, mathematical list
properties and all 128 bindings per subject. It fixes the nonempty unfolding
rule to retain the pointer guard from the predicate definition.

| Subject | Original reference inputs checked | End-to-end result | Archive |
| --- | ---: | --- | --- |
| cn_list_length | 128 | 128 PASS | evidence/list-length-atp-itp-all32-20261013 |
| qcp_list_length | 128 | 128 PASS | evidence/qcp-list-length-atp-itp-all32-20261013 |
| qcp_list_reverse | 128 | 128 PASS | evidence/qcp-list-reverse-atp-itp-all32-20261013 |

Each result combines automatic VALID execution VCs with a checked proof of
the original entry satisfiability obligation. The length and reverse QCP
batches each contain one full kernel replay and 127 replays of fresh task
modules using previously checked dependencies. The archive retains the
full replay origin and logs; the validator checks their hashes and links.

All 45 implementation-mutant survivors also pass: one length, 14 reverse and
30 append inputs. They are selected using the independent mutation oracle
and checked against the automatic VC evidence. The append survivors use
structural composition of separate list heads, including empty heads.
See evidence/list-mutant-survivors-atp-itp32-20261013.

These results remain experimental profile evidence, excluded from frozen ATP
totals. They do not establish full CN/QCP representation correspondence or
complete admission of the 80 subjects. The 979 violating list mutation inputs
remain unresolved under the strong negative criterion requiring FAIL.
The append reference batch with structural head composition is tracked
separately until its complete certificate report is available.
