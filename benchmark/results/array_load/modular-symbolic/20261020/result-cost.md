# array_load：modular 关闭实例化实验

Native ablation only. Historical exact-goal proofs are disclosed, not new ITP calls or costs. Original four-tool group measurements remain unchanged.

| 空间 SMT | PASS / FAIL / UNKNOWN / ERROR | 原生预期匹配 | 同目标历史证书 |
| --- | --- | ---: | ---: |
| off | 62 / 0 / 5 / 0 | 62/67 | 0 |
| on | 62 / 0 / 5 / 0 | 62/67 | 0 |

| 空间 SMT | 阶段 | 平均秒 | 单次峰值 RSS 平均 MiB | 平均 token | 状态 |
| --- | --- | ---: | ---: | ---: | --- |
| off | native_cli | 0.171739 | 24.970849 | 0.000000 | MEASURED |
| off | symbolic_executor | 0.013164 | 6.014809 | 0.000000 | MEASURED |
| off | spatial_smt | — | — | 0.000000 | NOT_REQUIRED |
| off | agent_proof_filling | — | — | — | NOT_RUN_NATIVE_ABLATION |
| off | coq_compile_and_assumption_audit | — | — | — | NOT_RUN_NATIVE_ABLATION |
| off | independent_kernel_check | — | — | — | NOT_RUN_NATIVE_ABLATION |
| on | native_cli | 0.171752 | 24.985833 | 0.000000 | MEASURED |
| on | symbolic_executor | 0.013104 | 6.006413 | 0.000000 | MEASURED |
| on | spatial_smt | 0.000246 | 23.042386 | 0.000000 | MEASURED |
| on | agent_proof_filling | — | — | — | NOT_RUN_NATIVE_ABLATION |
| on | coq_compile_and_assumption_audit | — | — | — | NOT_RUN_NATIVE_ABLATION |
| on | independent_kernel_check | — | — | — | NOT_RUN_NATIVE_ABLATION |

阶段嵌套，不能相加。未执行新 ITP 的成本不填零；历史证明成本仍保留在旧批次。

[逐例原始证据](result-cost.json)；[原四工具表](../../result-cost.md)。
