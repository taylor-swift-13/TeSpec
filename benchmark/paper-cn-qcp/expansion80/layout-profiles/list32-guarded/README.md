# Preserve nonempty list guards during execution

This version retains the explicit 32-bit representation and changes only the
nonempty left-unfold strategy (rule 10): it adds `p != NULL` along with the
fields and tail. The earlier `list32` profile remains frozen for its recorded
experiments. C bodies, mathematical contracts and original input bindings are
unchanged.

`ListUnfoldGuard32.v` proves that the guarded unfolding is exactly the `sll32`
definition. It also proves that a nonempty list at NULL is false, while the
guardless field expansion has a concrete NULL-address heap witness in the
QCP model. This explains the spurious NULL paths in the earlier profile. It
does not make NULL dereferences in C safe.

`prepare-complete-proofs.py` prepares the controller's complete original VC
group for every eligible case in an automatic report. It combines generic
entry heap witnesses with `ListConcreteVCTactics.v`. The tactic introduces
logical pointer witnesses, substitutes equalities, and normalizes constant
addresses when matching separated fields. It neither selects a verdict nor
admits unfinished goals. The result controller checks every original VC,
audits assumptions, replays the kernel and reconciles the execution result.

```sh
python3 run-profile.py --cases cn_list_length qcp_list_length \
  qcp_list_reverse qcp_list_append --output /tmp/guarded-list-runs
python3 prepare-complete-proofs.py --report /tmp/guarded-list-runs/cn_list_length/reference-run/report.json \
  --suite ../../suites/cn_list_length/suite.json --output /tmp/length-proofs
```

The generated proof request records the run-manifest hash required by
`spectest check-run-certificates`. Generation and Coq compilation are separate
from completed kernel checks. This experimental profile is not full-suite
admission and does not alter the frozen ATP aggregate.
