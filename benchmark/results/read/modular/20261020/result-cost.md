# read：modular 结果与成本

原生分类保持；最终分类附加逐次内核检查的ITP结论。

| 模式 | 原生 PASS/FAIL/UNKNOWN/ERROR | 最终 PASS/FAIL/UNKNOWN/ERROR | 最终匹配 | 已完成ITP |
| --- | --- | --- | ---: | ---: |
| off | 22 / 20 / 12 / 7 | 22 / 32 / 0 / 7 | 61/61 | 12 |
| on | 22 / 20 / 12 / 7 | 22 / 32 / 0 / 7 | 61/61 | 12 |

| 模式 | 阶段 | 执行数 | 平均秒 | 平均单次峰值MiB | 平均token | 状态 |
| --- | --- | ---: | ---: | ---: | ---: | --- |
| off | native_cli | 61 | 0.164830 | 23.282018 | 0.000000 | MEASURED |
| off | symbolic_executor | 61 | 0.004971 | 4.722400 | 0.000000 | MEASURED |
| off | spatial_smt | 0 | — | — | 0.000000 | NOT_REQUIRED |
| off | agent_proof_filling | 12 | 21.081917 | 214.720703 | 66344.000000 | MEASURED |
| off | coq_compilation_and_assumption_audit | 12 | 5.443702 | 570.389974 | 0.000000 | MEASURED |
| off | independent_kernel_check | 12 | 132.022420 | 1881.493490 | 0.000000 | MEASURED |
| on | native_cli | 61 | 0.164811 | 23.303727 | 0.000000 | MEASURED |
| on | symbolic_executor | 61 | 0.004881 | 4.691406 | 0.000000 | MEASURED |
| on | spatial_smt | 61 | 0.000260 | 21.201588 | 0.000000 | MEASURED |
| on | agent_proof_filling | 12 | 19.867083 | 190.558594 | 64703.583333 | MEASURED |
| on | coq_compilation_and_assumption_audit | 12 | 5.402432 | 570.392904 | 0.000000 | MEASURED |
| on | independent_kernel_check | 12 | 131.686587 | 1881.494792 | 0.000000 | MEASURED |
| off | itp_total | 12 | 158.548038 | 1881.493490 | 66344.000000 | MEASURED |
| on | itp_total | 12 | 156.956103 | 1881.494792 | 64703.583333 | MEASURED |

ITP按一次执行全部残余VC计量，所有模型/编译/内核失败与修复均计入；只展示条件均值和逐执行阶段峰值均值。使用gpt-6.1-sol实际CLI计量审阅完全相同原始Goal的历史证书，每次仍单独编译、假设审计和完整独立coqchk。不是从零证明搜索；没有把旧证明成本重复计费。

原生CLI/执行器/空间SMT为嵌套阶段，不能相加。证明三个阶段分别计量，itp_total与三个分项重叠不可再次相加；远程模型内存不在本地RSS范围内。BLOCKED表示执行未完成，无整次执行VC目标，未伪造ITP时间。

[完整逐次证据](result-cost.json)；[成本CSV](result-cost.csv)；[原四工具组表](../../result-cost.md)。
