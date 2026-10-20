# add：modular 边界修复结果与成本

Boundary fix supplement. Original CN/QCP/Fulminate and inline evidence unchanged. Exact-target historical proof costs stay explicitly historical; current ITP costs include all failed attempts. UNKNOWN after partial auxiliary refutation is not successful detection.

| 配置 | 原生 PASS / FAIL / UNKNOWN / ERROR | 最终 PASS / FAIL / UNKNOWN / ERROR | 预期匹配 |
| --- | --- | --- | ---: |
| sampling-on/spatial-off | 76 / 46 / 0 / 0 | 76 / 46 / 0 / 0 | 122/122 |
| sampling-on/spatial-on | 76 / 46 / 0 / 0 | 76 / 46 / 0 / 0 | 122/122 |
| sampling-off/spatial-off | 76 / 46 / 0 / 0 | 76 / 46 / 0 / 0 | 122/122 |
| sampling-off/spatial-on | 76 / 46 / 0 / 0 | 76 / 46 / 0 / 0 | 122/122 |

| 配置 | 阶段 | 次数 | 平均秒 | 单次峰值内存平均 MiB | 平均 token | 测量范围 |
| --- | --- | ---: | ---: | ---: | ---: | --- |
| sampling-on/spatial-off | native_cli | 122 | 0.166586 | 24.439261 | 0.000000 | CURRENT |
| sampling-on/spatial-off | symbolic_executor | 122 | 0.005302 | 4.715932 | 0.000000 | CURRENT |
| sampling-on/spatial-off | spatial_smt | 0 | — | — | 0.000000 | NOT_REQUIRED |
| sampling-on/spatial-off | agent_proof_filling | 0 | — | — | — | NOT_RUN_OR_REUSED |
| sampling-on/spatial-off | coq_compile_and_assumption_audit | 0 | — | — | — | NOT_RUN_OR_REUSED |
| sampling-on/spatial-off | independent_kernel_check | 0 | — | — | — | NOT_RUN_OR_REUSED |
| sampling-on/spatial-off | itp_total | 0 | — | — | — | NOT_RUN_OR_REUSED |
| sampling-on/spatial-on | native_cli | 122 | 0.167010 | 24.467661 | 0.000000 | CURRENT |
| sampling-on/spatial-on | symbolic_executor | 122 | 0.005274 | 4.702741 | 0.000000 | CURRENT |
| sampling-on/spatial-on | spatial_smt | 122 | 0.000274 | 23.025487 | 0.000000 | CURRENT |
| sampling-on/spatial-on | agent_proof_filling | 0 | — | — | — | NOT_RUN_OR_REUSED |
| sampling-on/spatial-on | coq_compile_and_assumption_audit | 0 | — | — | — | NOT_RUN_OR_REUSED |
| sampling-on/spatial-on | independent_kernel_check | 0 | — | — | — | NOT_RUN_OR_REUSED |
| sampling-on/spatial-on | itp_total | 0 | — | — | — | NOT_RUN_OR_REUSED |
| sampling-off/spatial-off | native_cli | 122 | 0.166149 | 24.444416 | 0.000000 | CURRENT |
| sampling-off/spatial-off | symbolic_executor | 122 | 0.005263 | 4.692111 | 0.000000 | CURRENT |
| sampling-off/spatial-off | spatial_smt | 0 | — | — | 0.000000 | NOT_REQUIRED |
| sampling-off/spatial-off | agent_proof_filling | 0 | — | — | — | NOT_RUN_OR_REUSED |
| sampling-off/spatial-off | coq_compile_and_assumption_audit | 0 | — | — | — | NOT_RUN_OR_REUSED |
| sampling-off/spatial-off | independent_kernel_check | 0 | — | — | — | NOT_RUN_OR_REUSED |
| sampling-off/spatial-off | itp_total | 0 | — | — | — | NOT_RUN_OR_REUSED |
| sampling-off/spatial-on | native_cli | 122 | 0.166277 | 24.447554 | 0.000000 | CURRENT |
| sampling-off/spatial-on | symbolic_executor | 122 | 0.005271 | 4.696593 | 0.000000 | CURRENT |
| sampling-off/spatial-on | spatial_smt | 122 | 0.000266 | 23.022061 | 0.000000 | CURRENT |
| sampling-off/spatial-on | agent_proof_filling | 0 | — | — | — | NOT_RUN_OR_REUSED |
| sampling-off/spatial-on | coq_compile_and_assumption_audit | 0 | — | — | — | NOT_RUN_OR_REUSED |
| sampling-off/spatial-on | independent_kernel_check | 0 | — | — | — | NOT_RUN_OR_REUSED |
| sampling-off/spatial-on | itp_total | 0 | — | — | — | NOT_RUN_OR_REUSED |

CLI、执行器和空间SMT为嵌套阶段；ITP总计与分项重叠，不能重复相加。模型内存为Windows客户端PeakWorkingSet，Coq为GNU time单进程RSS。历史证明成本见原modular表，未冒充本轮新调用。

[逐次证据](result-cost.json)；[原四工具表](../../result-cost.md)；[历史modular证明成本](../../modular/20261020/result-cost.md)。
