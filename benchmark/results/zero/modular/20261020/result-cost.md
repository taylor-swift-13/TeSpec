# zero：modular 结果与成本

原生分类保持；最终分类附加逐次内核检查的ITP结论。

| 模式 | 原生 PASS/FAIL/UNKNOWN/ERROR | 最终 PASS/FAIL/UNKNOWN/ERROR | 最终匹配 | 已完成ITP |
| --- | --- | --- | ---: | ---: |
| off | 19 / 23 / 2 / 2 | 19 / 25 / 0 / 2 | 46/46 | 2 |
| on | 19 / 23 / 2 / 2 | 19 / 25 / 0 / 2 | 46/46 | 2 |

| 模式 | 阶段 | 执行数 | 平均秒 | 平均单次峰值MiB | 平均token | 状态 |
| --- | --- | ---: | ---: | ---: | ---: | --- |
| off | native_cli | 46 | 0.164794 | 23.293648 | 0.000000 | MEASURED |
| off | symbolic_executor | 46 | 0.005074 | 4.731063 | 0.000000 | MEASURED |
| off | spatial_smt | 0 | — | — | 0.000000 | NOT_REQUIRED |
| off | agent_proof_filling | 2 | 25.195500 | 191.960938 | 69904.000000 | MEASURED |
| off | coq_compilation_and_assumption_audit | 2 | 5.922078 | 572.328125 | 0.000000 | MEASURED |
| off | independent_kernel_check | 2 | 132.694123 | 1716.503906 | 0.000000 | MEASURED |
| on | native_cli | 46 | 0.164848 | 23.311990 | 0.000000 | MEASURED |
| on | symbolic_executor | 46 | 0.005073 | 4.721722 | 0.000000 | MEASURED |
| on | spatial_smt | 46 | 0.000242 | 21.212806 | 0.000000 | MEASURED |
| on | agent_proof_filling | 2 | 26.562500 | 187.833984 | 55942.000000 | MEASURED |
| on | coq_compilation_and_assumption_audit | 2 | 5.765490 | 572.070312 | 0.000000 | MEASURED |
| on | independent_kernel_check | 2 | 131.222904 | 1716.150391 | 0.000000 | MEASURED |
| off | itp_total | 2 | 163.811701 | 1716.503906 | 69904.000000 | MEASURED |
| on | itp_total | 2 | 163.550894 | 1716.150391 | 55942.000000 | MEASURED |

ITP按一次执行全部残余VC计量，所有模型/编译/内核失败与修复均计入；只展示条件均值和逐执行阶段峰值均值。使用gpt-6.1-sol实际CLI计量审阅完全相同原始Goal的历史证书，每次仍单独编译、假设审计和完整独立coqchk。不是从零证明搜索；没有把旧证明成本重复计费。

原生CLI/执行器/空间SMT为嵌套阶段，不能相加。证明三个阶段分别计量，itp_total与三个分项重叠不可再次相加；远程模型内存不在本地RSS范围内。BLOCKED表示执行未完成，无整次执行VC目标，未伪造ITP时间。

[完整逐次证据](result-cost.json)；[成本CSV](result-cost.csv)；[原四工具组表](../../result-cost.md)。
