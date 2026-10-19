# slf3_basic_inplace_double：modular 结果与成本

原生分类保持；最终分类附加逐次内核检查的ITP结论。

| 模式 | 原生 PASS/FAIL/UNKNOWN/ERROR | 最终 PASS/FAIL/UNKNOWN/ERROR | 最终匹配 | 已完成ITP |
| --- | --- | --- | ---: | ---: |
| off | 20 / 28 / 2 / 2 | 20 / 30 / 0 / 2 | 52/52 | 2 |
| on | 20 / 28 / 2 / 2 | 20 / 30 / 0 / 2 | 52/52 | 2 |

| 模式 | 阶段 | 执行数 | 平均秒 | 平均单次峰值MiB | 平均token | 状态 |
| --- | --- | ---: | ---: | ---: | ---: | --- |
| off | native_cli | 52 | 0.164824 | 23.290114 | 0.000000 | MEASURED |
| off | symbolic_executor | 52 | 0.004979 | 4.825646 | 0.000000 | MEASURED |
| off | spatial_smt | 0 | — | — | 0.000000 | NOT_REQUIRED |
| off | agent_proof_filling | 2 | 23.125000 | 190.326172 | 55048.000000 | MEASURED |
| off | coq_compilation_and_assumption_audit | 2 | 5.952502 | 575.283203 | 0.000000 | MEASURED |
| off | independent_kernel_check | 2 | 132.619508 | 1766.998047 | 0.000000 | MEASURED |
| on | native_cli | 52 | 0.164829 | 23.320763 | 0.000000 | MEASURED |
| on | symbolic_executor | 52 | 0.005147 | 4.807467 | 0.000000 | MEASURED |
| on | spatial_smt | 52 | 0.000236 | 21.224835 | 0.000000 | MEASURED |
| on | agent_proof_filling | 2 | 23.898500 | 191.593750 | 73065.000000 | MEASURED |
| on | coq_compilation_and_assumption_audit | 2 | 6.038456 | 575.419922 | 0.000000 | MEASURED |
| on | independent_kernel_check | 2 | 133.882579 | 1766.792969 | 0.000000 | MEASURED |
| off | itp_total | 2 | 161.697010 | 1766.998047 | 55048.000000 | MEASURED |
| on | itp_total | 2 | 163.819535 | 1766.792969 | 73065.000000 | MEASURED |

ITP按一次执行全部残余VC计量，所有模型/编译/内核失败与修复均计入；只展示条件均值和逐执行阶段峰值均值。使用gpt-6.1-sol实际CLI计量审阅完全相同原始Goal的历史证书，每次仍单独编译、假设审计和完整独立coqchk。不是从零证明搜索；没有把旧证明成本重复计费。

原生CLI/执行器/空间SMT为嵌套阶段，不能相加。证明三个阶段分别计量，itp_total与三个分项重叠不可再次相加；远程模型内存不在本地RSS范围内。BLOCKED表示执行未完成，无整次执行VC目标，未伪造ITP时间。

[完整逐次证据](result-cost.json)；[成本CSV](result-cost.csv)；[原四工具组表](../../result-cost.md)。
