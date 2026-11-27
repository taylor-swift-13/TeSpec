# runway__funcs2 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | ORIGINAL_MODULE_REJECTED |
| qcp | STANDALONE_NATIVE_REJECTED |
| fulminate | 150/150 符合预期 · PASS 150 |

最新 Auto 补测的 60 次中，0 次符合预期。[状态、分支与实际成本](tespec/auto-remaining.json)

全量 Auto 符合预期：inline 120/150，modular 120/150。[同一输入的跨工具比较](../paired-tool-comparison.md)。

| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |
|---|---:|---:|---:|---:|---:|
| inline | 150 | 0 | 0 | 0 | 120 |
| modular | 150 | 0 | 0 | 0 | 120 |

以下为旧冻结双路线批次。

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 150 | 120 | 120 | 0 | 0 |
| modular | 150 | 120 | 120 | 0 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | archived_cost | 一次主程序验证 · MEASURED | 0.0646 | 42764.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | archived_cost | 已测工作总量 · MEASURED | 7.6375 | 102096.0000 | 0 | — |
| qcp | — | agent 填写证明 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | archived_cost | 一次主程序验证 · MEASURED | 1.1080 | 550548.0000 | 0 | — |
| qcp | — | 独立内核检查 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | ITP 平均合计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | vc_generation_and_automatic_processing | standalone_qcp | 1/1 · measured invocations | 0.0049 | 3084 | 0 | — |
| qcp | — | prior_invocations | standalone_qcp | 1/1 · measured invocations | 0.0036 | 1920 | 0 | — |
| fulminate | — | 插桩、编译与首次执行 | archived_cost | 已测工作总量 · MEASURED | 6.3237 | 45680.0000 | 0 | — |
| fulminate | — | 单独运行测试 | archived_cost | 已测工作总量 · PENDING | — | — | 0 | — |
| fulminate | — | locked_original_build | fulminate_compatibility | 150/150 · measured invocations | 13.8135 | 44340 | 0 | — |
| fulminate | — | compatibility_instrument_compile_first_run | fulminate_compatibility | 150/150 · measured invocations | 104.3028 | 47776 | 0 | — |
| fulminate | — | compatibility_execution | fulminate_compatibility | 150/150 · measured invocations | 1.1224 | 1968 | 0 | — |
| fulminate | — | prior_compatibility_build | fulminate_compatibility | 150/150 · measured invocations | 91.5154 | 47832 | 0 | — |
| fulminate | — | prior_compatibility_test | fulminate_compatibility | 150/150 · measured invocations | 0.9833 | 1972 | 0 | — |
| tespec | inline | native | current_execution | 150/150 · MEASURED | 31.4814 | 35556 | 0 | 150/150 |
| tespec | inline | auto | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_model | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_coq | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_kernel | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | native | current_execution | 150/150 · MEASURED | 88.2863 | 22224 | 0 | 150/150 |
| tespec | modular | auto | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_model | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_coq | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_kernel | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | layout_prepare | fresh_auto_remaining | 30/30 · MEASURED | 2.6129 | 17940 | 0 | — |
| tespec | inline | native | fresh_auto_remaining | 30/30 · MEASURED | 7.2687 | 21200 | 0 | 30/30 |
| tespec | modular | layout_prepare | fresh_auto_remaining | 30/30 · MEASURED | 2.6041 | 17964 | 0 | — |
| tespec | modular | native | fresh_auto_remaining | 30/30 · MEASURED | 7.3372 | 21148 | 0 | 30/30 |
| tespec | inline | layout_prepare | latest_native_matrix | 84/84 · MEASURED | 5.9189 | 18228 | 0 | — |
| tespec | inline | batch_auto | latest_native_matrix | 0/0 · NOT_INVOKED | — | — | 0 | — |
| tespec | inline | native | latest_native_matrix | 150/150 · MEASURED | 27.0591 | 35764 | 0 | 150/150 |
| tespec | inline | auto | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_model | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_coq | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_kernel | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | layout_prepare | latest_native_matrix | 84/84 · MEASURED | 5.8698 | 18232 | 0 | — |
| tespec | modular | batch_auto | latest_native_matrix | 0/0 · NOT_INVOKED | — | — | 0 | — |
| tespec | modular | native | latest_native_matrix | 150/150 · MEASURED | 101.2741 | 22248 | 0 | 150/150 |
| tespec | modular | auto | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_model | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_coq | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_kernel | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
