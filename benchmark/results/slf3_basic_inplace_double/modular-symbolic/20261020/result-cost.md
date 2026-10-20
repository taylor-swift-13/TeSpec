# slf3_basic_inplace_double：modular 关闭实例化实验

Native ablation only. Historical exact-goal proofs are disclosed, not new ITP calls or costs. Original four-tool group measurements remain unchanged.

| 空间 SMT | PASS / FAIL / UNKNOWN / ERROR | 原生预期匹配 | 同目标历史证书 |
| --- | --- | ---: | ---: |
| off | 20 / 28 / 2 / 2 | 50/52 | 2 |
| on | 20 / 28 / 2 / 2 | 50/52 | 2 |

| 空间 SMT | 阶段 | 平均秒 | 单次峰值 RSS 平均 MiB | 平均 token | 状态 |
| --- | --- | ---: | ---: | ---: | --- |
| off | native_cli | 0.164740 | 24.993314 | 0.000000 | MEASURED |
| off | symbolic_executor | 0.005119 | 4.758864 | 0.000000 | MEASURED |
| off | spatial_smt | — | — | 0.000000 | NOT_REQUIRED |
| off | agent_proof_filling | — | — | — | NOT_RUN_NATIVE_ABLATION |
| off | coq_compile_and_assumption_audit | — | — | — | NOT_RUN_NATIVE_ABLATION |
| off | independent_kernel_check | — | — | — | NOT_RUN_NATIVE_ABLATION |
| on | native_cli | 0.164820 | 24.987230 | 0.000000 | MEASURED |
| on | symbolic_executor | 0.004994 | 4.754282 | 0.000000 | MEASURED |
| on | spatial_smt | 0.000222 | 23.045598 | 0.000000 | MEASURED |
| on | agent_proof_filling | — | — | — | NOT_RUN_NATIVE_ABLATION |
| on | coq_compile_and_assumption_audit | — | — | — | NOT_RUN_NATIVE_ABLATION |
| on | independent_kernel_check | — | — | — | NOT_RUN_NATIVE_ABLATION |

阶段嵌套，不能相加。未执行新 ITP 的成本不填零；历史证明成本仍保留在旧批次。

[逐例原始证据](result-cost.json)；[原四工具表](../../result-cost.md)。
