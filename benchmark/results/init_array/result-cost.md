# init_array 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED |
| qcp | VERIFIED_KERNEL_CHECKED_WITH_RUNTIME_LIBRARY_ASSUMPTIONS |
| fulminate | 18/18 符合预期 · PASS 18 |

最新 Auto 补测的 17 次中，0 次符合预期。[状态、分支与实际成本](tespec/auto-remaining.json)

全量 Auto 符合预期：inline 18/18，modular 1/18。[同一输入的跨工具比较](../paired-tool-comparison.md)。

| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |
|---|---:|---:|---:|---:|---:|
| inline | 6 | 12 | 12 | 0 | 10 |
| modular | 17 | 1 | 1 | 0 | 1 |

以下为旧冻结双路线批次。

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 18 | 18 | 9 | 12 | 12 |
| modular | 18 | 1 | 1 | 1 | 1 |

| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | archived_cost | 一次主程序验证 · MEASURED | 0.3153 | 44700.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | archived_cost | 已测工作总量 · MEASURED | 0.0244 | 5796.0000 | 0 | — |
| qcp | — | agent 填写证明 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | 独立内核检查 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | ITP 平均合计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | vc_generation_and_automatic_processing | standalone_qcp | 1/1 · measured invocations | 0.0673 | 19972 | 0 | — |
| qcp | — | coq_compilation_and_assumption_audit | standalone_qcp | 2/2 · measured invocations | 4.6658 | 577708 | 0 | — |
| qcp | — | independent_kernel_check | standalone_qcp | 1/1 · measured invocations | 303.9151 | 2042936 | 0 | — |
| qcp | — | prior_invocations | standalone_qcp | 5/5 · measured invocations | 605.9203 | 2040948 | 0 | — |
| fulminate | — | 插桩、编译与首次执行 | archived_cost | 已测工作总量 · MEASURED | 2.1140 | 44480.0000 | 0 | — |
| fulminate | — | 单独运行测试 | archived_cost | 已测工作总量 · MEASURED | 0.0710 | 1132.0000 | 0 | — |
| tespec | inline | native | current_execution | 18/18 · MEASURED | 2.6482 | 21352 | 0 | 18/18 |
| tespec | inline | auto | current_execution | 12/12 · MEASURED | 2.0547 | 56116 | 0 | — |
| tespec | inline | itp_model | current_execution | 12/12 · MEASURED | 1112.7510 | 167036.0000 | 707257 | — |
| tespec | inline | itp_coq | current_execution | 6/12 · PARTIAL_METRICS | 6791.2369 | — | 0 | — |
| tespec | inline | itp_kernel | current_execution | 12/12 · MEASURED | 347.6251 | 1809548 | 0 | — |
| tespec | inline | candidate_precheck | historical_stage_remeasurement | 9/9 · MEASURED | 0.7783 | 17192 | 0 | — |
| tespec | inline | compile_Candidate.v | historical_stage_remeasurement | 9/9 · MEASURED | 5402.2220 | 1824048 | 0 | — |
| tespec | inline | compile_Goal.v | historical_stage_remeasurement | 9/9 · MEASURED | 15.2364 | 571864 | 0 | — |
| tespec | inline | version | historical_stage_remeasurement | 9/9 · MEASURED | 1.5437 | 31304 | 0 | — |
| tespec | modular | native | current_execution | 18/18 · MEASURED | 2.4662 | 21132 | 0 | 18/18 |
| tespec | modular | auto | current_execution | 1/1 · MEASURED | 0.0897 | 51972 | 0 | — |
| tespec | modular | itp_model | current_execution | 1/1 · MEASURED | 114.6250 | 172052.0000 | 432498 | — |
| tespec | modular | itp_coq | current_execution | 1/1 · MEASURED | 4.4655 | 564008 | 0 | — |
| tespec | modular | itp_kernel | current_execution | 1/1 · MEASURED | 128.3313 | 1809652 | 0 | — |
| tespec | modular | layout_prepare | fresh_auto_remaining | 17/17 · MEASURED | 0.9359 | 18132 | 0 | — |
| tespec | modular | native | fresh_auto_remaining | 17/17 · MEASURED | 2.5696 | 21088 | 0 | 17/17 |
| tespec | inline | auto | auto_on_itp_roots | 12/12 · MEASURED | 2.2851 | 55900 | 0 | — |
| tespec | modular | auto | auto_on_itp_roots | 1/1 · MEASURED | 0.0923 | 52288 | 0 | — |
| tespec | inline | layout_prepare | latest_native_matrix | 3/3 · MEASURED | 0.1892 | 18240 | 0 | — |
| tespec | inline | batch_auto | latest_native_matrix | 2/2 · MEASURED | 1.3417 | 56468 | 0 | — |
| tespec | inline | native | latest_native_matrix | 18/18 · MEASURED | 0.9867 | 21600 | 0 | 18/18 |
| tespec | inline | auto | latest_same_input_and_vc | 12/12 · MEASURED | 3.2111 | 56020 | 0 | — |
| tespec | inline | itp_model | latest_same_input_and_vc | 12/12 · MEASURED | 1531.4980 | 331504.0000 | 605383 | — |
| tespec | inline | itp_coq | latest_same_input_and_vc | 12/12 · MEASURED | 7321.8524 | 1773064 | 0 | — |
| tespec | inline | itp_kernel | latest_same_input_and_vc | 12/12 · MEASURED | 589.7334 | 1877592 | 0 | — |
| tespec | inline | auto | same_input_profile_recheck_a21f363a | 12/12 · MEASURED | 2.5043 | 55972 | 0 | — |
| tespec | modular | layout_prepare | latest_native_matrix | 18/18 · MEASURED | 0.9961 | 18132 | 0 | — |
| tespec | modular | batch_auto | latest_native_matrix | 1/1 · MEASURED | 0.0948 | 52308 | 0 | — |
| tespec | modular | native | latest_native_matrix | 18/18 · MEASURED | 2.7614 | 21088 | 0 | 18/18 |
| tespec | modular | auto | latest_same_input_and_vc | 1/1 · MEASURED | 0.1494 | 52060 | 0 | — |
| tespec | modular | itp_model | latest_same_input_and_vc | 1/1 · MEASURED | 0 | — | 0 | — |
| tespec | modular | itp_coq | latest_same_input_and_vc | 1/1 · MEASURED | 5.2192 | 564096 | 0 | — |
| tespec | modular | itp_kernel | latest_same_input_and_vc | 1/1 · MEASURED | 145.6943 | 1811240 | 0 | — |
| tespec | modular | auto | same_input_profile_recheck_a21f363a | 1/1 · MEASURED | 0.1231 | 52260 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
