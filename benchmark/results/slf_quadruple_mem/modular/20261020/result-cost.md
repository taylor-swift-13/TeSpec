# slf_quadruple_mem：modular 结果与成本

原生分类保持；最终分类附加逐次内核检查的ITP结论。

| 模式 | 原生 PASS/FAIL/UNKNOWN/ERROR | 最终 PASS/FAIL/UNKNOWN/ERROR | 最终匹配 | 已完成ITP |
| --- | --- | --- | ---: | ---: |
| off | 7 / 0 / 0 / 0 | 7 / 0 / 0 / 0 | 7/7 | 0 |
| on | 7 / 0 / 0 / 0 | 7 / 0 / 0 / 0 | 7/7 | 0 |

| 模式 | 阶段 | 执行数 | 平均秒 | 平均单次峰值MiB | 平均token | 状态 |
| --- | --- | ---: | ---: | ---: | ---: | --- |
| off | native_cli | 7 | 0.164807 | 23.276228 | 0.000000 | MEASURED |
| off | symbolic_executor | 7 | 0.005117 | 4.963170 | 0.000000 | MEASURED |
| off | spatial_smt | 0 | — | — | 0.000000 | NOT_REQUIRED |
| off | agent_proof_filling | 0 | — | — | — | NOT_REQUIRED |
| off | coq_compilation_and_assumption_audit | 0 | — | — | — | NOT_REQUIRED |
| off | independent_kernel_check | 0 | — | — | — | NOT_REQUIRED |
| on | native_cli | 7 | 0.164749 | 23.301897 | 0.000000 | MEASURED |
| on | symbolic_executor | 7 | 0.004974 | 4.922991 | 0.000000 | MEASURED |
| on | spatial_smt | 7 | 0.000212 | 21.258371 | 0.000000 | MEASURED |
| on | agent_proof_filling | 0 | — | — | — | NOT_REQUIRED |
| on | coq_compilation_and_assumption_audit | 0 | — | — | — | NOT_REQUIRED |
| on | independent_kernel_check | 0 | — | — | — | NOT_REQUIRED |
| off | itp_total | 0 | — | — | — | NOT_REQUIRED |
| on | itp_total | 0 | — | — | — | NOT_REQUIRED |

ITP按一次执行全部残余VC计量，所有模型/编译/内核失败与修复均计入；只展示条件均值和逐执行阶段峰值均值。使用gpt-6.1-sol实际CLI计量审阅完全相同原始Goal的历史证书，每次仍单独编译、假设审计和完整独立coqchk。不是从零证明搜索；没有把旧证明成本重复计费。

原生CLI/执行器/空间SMT为嵌套阶段，不能相加。证明三个阶段分别计量，itp_total与三个分项重叠不可再次相加；远程模型内存不在本地RSS范围内。BLOCKED表示执行未完成，无整次执行VC目标，未伪造ITP时间。

[完整逐次证据](result-cost.json)；[成本CSV](result-cost.csv)；[原四工具组表](../../result-cost.md)。
