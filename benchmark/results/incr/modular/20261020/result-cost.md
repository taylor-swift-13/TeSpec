# incr：modular 结果与成本

已执行全部 103 对已有输入，空间 SMT OFF/ON。原生结果和所需 ITP 完整性分别记录。

| 模式 | PASS / FAIL / UNKNOWN / ERROR | 原生预期匹配 | 待处理 UNKNOWN |
| --- | --- | ---: | ---: |
| off | 28 / 50 / 13 / 12 | 90/103 | 13 |
| on | 28 / 50 / 13 / 12 | 90/103 | 13 |

| 模式 | 阶段 | 平均秒 | 平均单次峰值 MiB | 平均 token | 状态 |
| --- | --- | ---: | ---: | ---: | --- |
| off | native_cli | 0.164821 | 23.285270 | 0.000000 | MEASURED |
| off | symbolic_executor | 0.005040 | 4.793765 | 0.000000 | MEASURED |
| off | spatial_smt | — | — | 0.000000 | NOT_REQUIRED |
| off | agent_proof_filling | — | — | — | PENDING |
| off | coq_compilation_and_assumption_audit | — | — | — | PENDING |
| off | independent_kernel_check | — | — | — | PENDING |
| on | native_cli | 0.164811 | 23.310490 | 0.000000 | MEASURED |
| on | symbolic_executor | 0.004997 | 4.807380 | 0.000000 | MEASURED |
| on | spatial_smt | 0.000250 | 21.213251 | 0.000000 | MEASURED |
| on | agent_proof_filling | — | — | — | PENDING |
| on | coq_compilation_and_assumption_audit | — | — | — | PENDING |
| on | independent_kernel_check | — | — | — | PENDING |

CLI、执行器、空间 SMT 是嵌套阶段，不能相加。空间阶段 RSS 为1ms采样峰值。每次执行的全部残余VC组成一个ITP任务；未跑的证明阶段保留PENDING/null，UNKNOWN不算成功。

CN/QCP 主验证及 Fulminate 仍见 [原组表](../../result-cost.md)。[逐次证据与成本](result-cost.json)；[成本CSV](result-cost.csv)。
