# runtime-extras__down_malloc_up_free 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | ACCEPTED_TARGETS_TRUSTED |
| qcp | STANDALONE_NATIVE_REJECTED |
| fulminate | 28/28 符合预期 · PASS 28 |

最新 Auto 补测的 2 次中，0 次符合预期。[状态、分支与实际成本](tespec/auto-remaining.json)

全量 Auto 符合预期：inline 27/28，modular 27/28。[同一输入的跨工具比较](../paired-tool-comparison.md)。

| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |
|---|---:|---:|---:|---:|---:|
| inline | 27 | 1 | 1 | 0 | 27 |
| modular | 28 | 0 | 0 | 0 | 27 |

以下为旧冻结双路线批次。

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 28 | 27 | 27 | 1 | 1 |
| modular | 28 | 27 | 27 | 0 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | archived_cost | 一次主程序验证 · MEASURED | 0.1147 | 44808.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | archived_cost | 已测工作总量 · MEASURED | 0.0163 | 5572.0000 | 0 | — |
| qcp | — | agent 填写证明 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | 独立内核检查 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | ITP 平均合计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | vc_generation_and_automatic_processing | standalone_qcp | 1/1 · measured invocations | 0.0185 | 7932 | 0 | — |
| qcp | — | prior_invocations | standalone_qcp | 1/1 · measured invocations | 0.0026 | 1920 | 0 | — |
| fulminate | — | 插桩、编译与首次执行 | archived_cost | 已测工作总量 · MEASURED | 3.2123 | 44812.0000 | 0 | — |
| fulminate | — | 单独运行测试 | archived_cost | 已测工作总量 · MEASURED | 0.1119 | 1132.0000 | 0 | — |
| tespec | inline | native | current_execution | 28/28 · MEASURED | 4.2069 | 21128 | 0 | 28/28 |
| tespec | inline | auto | current_execution | 1/1 · MEASURED | 0.1020 | 54068 | 0 | — |
| tespec | inline | itp_model | current_execution | 1/1 · MEASURED | 47.5470 | 162824.0000 | 19950 | — |
| tespec | inline | itp_coq | current_execution | 1/1 · MEASURED | 4.0886 | 563300 | 0 | — |
| tespec | inline | itp_kernel | current_execution | 1/1 · MEASURED | 0 | — | 0 | — |
| tespec | modular | native | current_execution | 28/28 · MEASURED | 4.2376 | 21044 | 0 | 28/28 |
| tespec | modular | auto | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_model | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_coq | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_kernel | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | layout_prepare | fresh_auto_remaining | 1/1 · MEASURED | 0.0795 | 17744 | 0 | — |
| tespec | inline | native | fresh_auto_remaining | 1/1 · MEASURED | 0.2431 | 20684 | 0 | 1/1 |
| tespec | inline | auto | fresh_auto_remaining | 1/1 · MEASURED | 0.1837 | 54120 | 0 | — |
| tespec | modular | layout_prepare | fresh_auto_remaining | 1/1 · MEASURED | 0.0960 | 17692 | 0 | — |
| tespec | modular | native | fresh_auto_remaining | 1/1 · MEASURED | 0.2389 | 20640 | 0 | 1/1 |
| tespec | inline | auto | auto_on_itp_roots | 1/1 · MEASURED | 0.1258 | 54188 | 0 | — |
| tespec | inline | layout_prepare | latest_native_matrix | 8/8 · MEASURED | 0.5275 | 18152 | 0 | — |
| tespec | inline | batch_auto | latest_native_matrix | 1/1 · MEASURED | 0.1837 | 54120 | 0 | — |
| tespec | inline | native | latest_native_matrix | 28/28 · MEASURED | 1.6755 | 21156 | 0 | 28/28 |
| tespec | inline | auto | latest_same_input_and_vc | 1/1 · MEASURED | 0.1955 | 54208 | 0 | — |
| tespec | inline | itp_model | latest_same_input_and_vc | 1/1 · MEASURED | 260.1560 | 166008.0000 | 80984 | — |
| tespec | inline | itp_coq | latest_same_input_and_vc | 1/1 · MEASURED | 199.9717 | 13939748 | 0 | — |
| tespec | inline | itp_kernel | latest_same_input_and_vc | 1/1 · MEASURED | 0 | — | 0 | — |
| tespec | inline | candidate_precheck | current_resource_recheck_subset | 1/1 · MEASURED | 0.0649 | 16916 | 0 | — |
| tespec | inline | version | current_resource_recheck_subset | 1/1 · MEASURED | 0.2155 | 31136 | 0 | — |
| tespec | inline | compile_Goal.v | current_resource_recheck_subset | 1/1 · MEASURED | 1.3192 | 563132 | 0 | — |
| tespec | inline | compile_Candidate.v | current_resource_recheck_subset | 1/1 · MEASURED | 48.2714 | 3966456 | 0 | — |
| tespec | inline | auto | same_input_profile_recheck_a21f363a | 1/1 · MEASURED | 0.1198 | 53828 | 0 | — |
| tespec | inline | auto | source_transition_diagnostic | 1/1 · MEASURED | 0.1383 | 54192 | 0 | — |
| tespec | inline | auto | additional_budget_diagnostic | 1/1 · MEASURED | 0.1261 | 54012 | 0 | — |
| tespec | modular | layout_prepare | latest_native_matrix | 8/8 · MEASURED | 0.5099 | 18136 | 0 | — |
| tespec | modular | batch_auto | latest_native_matrix | 0/0 · NOT_INVOKED | — | — | 0 | — |
| tespec | modular | native | latest_native_matrix | 28/28 · MEASURED | 1.6314 | 21068 | 0 | 28/28 |
| tespec | modular | auto | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_model | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_coq | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_kernel | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
