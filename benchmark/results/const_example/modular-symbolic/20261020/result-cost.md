# const_example：modular 关闭实例化实验

Native ablation only. Historical exact-goal proofs are disclosed, not new ITP calls or costs. Original four-tool group measurements remain unchanged.

| 空间 SMT | PASS / FAIL / UNKNOWN / ERROR | 原生预期匹配 | 同目标历史证书 |
| --- | --- | ---: | ---: |
| off | 7 / 0 / 0 / 0 | 7/7 | 0 |
| on | 7 / 0 / 0 / 0 | 7/7 | 0 |

| 空间 SMT | 阶段 | 平均秒 | 单次峰值 RSS 平均 MiB | 平均 token | 状态 |
| --- | --- | ---: | ---: | ---: | --- |
| off | native_cli | 0.172102 | 24.991071 | 0.000000 | MEASURED |
| off | symbolic_executor | 0.004807 | 4.696429 | 0.000000 | MEASURED |
| off | spatial_smt | — | — | 0.000000 | NOT_REQUIRED |
| off | agent_proof_filling | — | — | — | NOT_RUN_NATIVE_ABLATION |
| off | coq_compile_and_assumption_audit | — | — | — | NOT_RUN_NATIVE_ABLATION |
| off | independent_kernel_check | — | — | — | NOT_RUN_NATIVE_ABLATION |
| on | native_cli | 0.164928 | 24.959263 | 0.000000 | MEASURED |
| on | symbolic_executor | 0.004581 | 4.691964 | 0.000000 | MEASURED |
| on | spatial_smt | 0.000199 | 23.011161 | 0.000000 | MEASURED |
| on | agent_proof_filling | — | — | — | NOT_RUN_NATIVE_ABLATION |
| on | coq_compile_and_assumption_audit | — | — | — | NOT_RUN_NATIVE_ABLATION |
| on | independent_kernel_check | — | — | — | NOT_RUN_NATIVE_ABLATION |

阶段嵌套，不能相加。未执行新 ITP 的成本不填零；历史证明成本仍保留在旧批次。

[逐例原始证据](result-cost.json)；[原四工具表](../../result-cost.md)。
