# array_load：modular 边界修复结果与成本

Boundary fix supplement. Original CN/QCP/Fulminate and inline evidence unchanged. Exact-target historical proof costs stay explicitly historical; current ITP costs include all failed attempts. UNKNOWN after partial auxiliary refutation is not successful detection.

| 配置 | 原生 PASS / FAIL / UNKNOWN / ERROR | 最终 PASS / FAIL / UNKNOWN / ERROR | 预期匹配 |
| --- | --- | --- | ---: |
| sampling-on/spatial-off | 65 / 0 / 2 / 0 | 66 / 0 / 1 / 0 | 66/67 |
| sampling-on/spatial-on | 65 / 0 / 2 / 0 | 66 / 0 / 1 / 0 | 66/67 |
| sampling-off/spatial-off | 65 / 0 / 2 / 0 | 66 / 0 / 1 / 0 | 66/67 |
| sampling-off/spatial-on | 65 / 0 / 2 / 0 | 66 / 0 / 1 / 0 | 66/67 |

| 配置 | 阶段 | 次数 | 平均秒 | 单次峰值内存平均 MiB | 平均 token | 测量范围 |
| --- | --- | ---: | ---: | ---: | ---: | --- |
| sampling-on/spatial-off | native_cli | 67 | 0.173992 | 24.311625 | 0.000000 | CURRENT |
| sampling-on/spatial-off | symbolic_executor | 67 | 0.011898 | 6.081973 | 0.000000 | CURRENT |
| sampling-on/spatial-off | spatial_smt | 0 | — | — | 0.000000 | NOT_REQUIRED |
| sampling-on/spatial-off | agent_proof_filling | 2 | 117.633500 | 192.822266 | 336080.000000 | CURRENT_ALL_ATTEMPTS |
| sampling-on/spatial-off | coq_compile_and_assumption_audit | 2 | 4.117776 | 538.015625 | 0.000000 | CURRENT_ALL_ATTEMPTS |
| sampling-on/spatial-off | independent_kernel_check | 2 | 127.461562 | 1799.865234 | 0.000000 | CURRENT_ALL_ATTEMPTS |
| sampling-on/spatial-off | itp_total | 2 | 249.212837 | 1799.865234 | 336080.000000 | CURRENT_ALL_ATTEMPTS |
| sampling-on/spatial-on | native_cli | 67 | 0.173435 | 24.423857 | 0.000000 | CURRENT |
| sampling-on/spatial-on | symbolic_executor | 67 | 0.011916 | 6.071945 | 0.000000 | CURRENT |
| sampling-on/spatial-on | spatial_smt | 67 | 0.000282 | 22.934585 | 0.000000 | CURRENT |
| sampling-on/spatial-on | agent_proof_filling | 2 | 148.539000 | 192.962891 | 523082.500000 | CURRENT_ALL_ATTEMPTS |
| sampling-on/spatial-on | coq_compile_and_assumption_audit | 2 | 4.849288 | 537.849609 | 0.000000 | CURRENT_ALL_ATTEMPTS |
| sampling-on/spatial-on | independent_kernel_check | 2 | 126.146978 | 1800.171875 | 0.000000 | CURRENT_ALL_ATTEMPTS |
| sampling-on/spatial-on | itp_total | 2 | 279.535266 | 1800.171875 | 523082.500000 | CURRENT_ALL_ATTEMPTS |
| sampling-off/spatial-off | native_cli | 67 | 0.173173 | 24.249534 | 0.000000 | CURRENT |
| sampling-off/spatial-off | symbolic_executor | 67 | 0.011734 | 6.080865 | 0.000000 | CURRENT |
| sampling-off/spatial-off | spatial_smt | 0 | — | — | 0.000000 | NOT_REQUIRED |
| sampling-off/spatial-off | agent_proof_filling | 2 | 148.992000 | 192.921875 | 539943.000000 | CURRENT_ALL_ATTEMPTS |
| sampling-off/spatial-off | coq_compile_and_assumption_audit | 2 | 4.843988 | 537.945312 | 0.000000 | CURRENT_ALL_ATTEMPTS |
| sampling-off/spatial-off | independent_kernel_check | 2 | 129.187460 | 1799.910156 | 0.000000 | CURRENT_ALL_ATTEMPTS |
| sampling-off/spatial-off | itp_total | 2 | 283.023448 | 1799.910156 | 539943.000000 | CURRENT_ALL_ATTEMPTS |
| sampling-off/spatial-on | native_cli | 67 | 0.173138 | 24.454408 | 0.000000 | CURRENT |
| sampling-off/spatial-on | symbolic_executor | 67 | 0.011899 | 6.059118 | 0.000000 | CURRENT |
| sampling-off/spatial-on | spatial_smt | 67 | 0.000285 | 23.013993 | 0.000000 | CURRENT |
| sampling-off/spatial-on | agent_proof_filling | 2 | 103.258500 | 192.498047 | 363725.000000 | CURRENT_ALL_ATTEMPTS |
| sampling-off/spatial-on | coq_compile_and_assumption_audit | 2 | 3.021523 | 537.791016 | 0.000000 | CURRENT_ALL_ATTEMPTS |
| sampling-off/spatial-on | independent_kernel_check | 2 | 127.355083 | 1913.814453 | 0.000000 | CURRENT_ALL_ATTEMPTS |
| sampling-off/spatial-on | itp_total | 2 | 233.635105 | 1913.814453 | 363725.000000 | CURRENT_ALL_ATTEMPTS |

CLI、执行器和空间SMT为嵌套阶段；ITP总计与分项重叠，不能重复相加。模型内存为Windows客户端PeakWorkingSet，Coq为GNU time单进程RSS。历史证明成本见原modular表，未冒充本轮新调用。

[逐次证据](result-cost.json)；[原四工具表](../../result-cost.md)；[历史modular证明成本](../../modular/20261020/result-cost.md)。
