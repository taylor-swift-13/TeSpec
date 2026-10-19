# array_load：modular 结果与成本

原生分类保持；最终分类附加逐次内核检查的ITP结论。

| 模式 | 原生 PASS/FAIL/UNKNOWN/ERROR | 最终 PASS/FAIL/UNKNOWN/ERROR | 最终匹配 | 已完成ITP |
| --- | --- | --- | ---: | ---: |
| off | 60 / 0 / 7 / 0 | 60 / 0 / 7 / 0 | 60/67 | 0 |
| on | 60 / 0 / 7 / 0 | 60 / 0 / 7 / 0 | 60/67 | 0 |

| 模式 | 阶段 | 执行数 | 平均秒 | 平均单次峰值MiB | 平均token | 状态 |
| --- | --- | ---: | ---: | ---: | ---: | --- |
| off | native_cli | 67 | 0.165574 | 23.303871 | 0.000000 | MEASURED |
| off | symbolic_executor | 67 | 0.007960 | 5.822062 | 0.000000 | MEASURED |
| off | spatial_smt | 0 | — | — | 0.000000 | NOT_REQUIRED |
| off | agent_proof_filling | 0 | — | — | — | BLOCKED |
| off | coq_compilation_and_assumption_audit | 0 | — | — | — | BLOCKED |
| off | independent_kernel_check | 0 | — | — | — | BLOCKED |
| on | native_cli | 67 | 0.164807 | 23.327659 | 0.000000 | MEASURED |
| on | symbolic_executor | 67 | 0.008040 | 5.807836 | 0.000000 | MEASURED |
| on | spatial_smt | 67 | 0.000311 | 21.241371 | 0.000000 | MEASURED |
| on | agent_proof_filling | 0 | — | — | — | BLOCKED |
| on | coq_compilation_and_assumption_audit | 0 | — | — | — | BLOCKED |
| on | independent_kernel_check | 0 | — | — | — | BLOCKED |
| off | itp_total | 0 | — | — | — | BLOCKED |
| on | itp_total | 0 | — | — | — | BLOCKED |
| off | additional_entry_exit_diagnostic | 7 | 0.351613 | 27.137277 | 0.000000 | MEASURED |
| on | additional_entry_exit_diagnostic | 7 | 0.280166 | 27.087612 | 0.000000 | MEASURED |

ITP按一次执行全部残余VC计量，所有模型/编译/内核失败与修复均计入；只展示条件均值和逐执行阶段峰值均值。使用gpt-6.1-sol实际CLI计量审阅完全相同原始Goal的历史证书，每次仍单独编译、假设审计和完整独立coqchk。不是从零证明搜索；没有把旧证明成本重复计费。

原生CLI/执行器/空间SMT为嵌套阶段，不能相加。证明三个阶段分别计量，itp_total与三个分项重叠不可再次相加；远程模型内存不在本地RSS范围内。BLOCKED表示执行未完成，无整次执行VC目标，未伪造ITP时间。

[完整逐次证据](result-cost.json)；[成本CSV](result-cost.csv)；[原四工具组表](../../result-cost.md)。
