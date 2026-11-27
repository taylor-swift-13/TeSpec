# zero 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED |
| qcp | VERIFIED_KERNEL_CHECKED |
| fulminate | 44/46 符合预期 · PASS 21、FAIL 25 |

全量 Auto 符合预期：inline 46/46，modular 46/46。[同一输入的跨工具比较](../paired-tool-comparison.md)。

| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |
|---|---:|---:|---:|---:|---:|
| inline | 44 | 2 | 2 | 0 | 44 |
| modular | 44 | 2 | 2 | 0 | 44 |

以下为旧冻结双路线批次。

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 46 | 46 | 44 | 2 | 2 |
| modular | 46 | 46 | 44 | 2 | 2 |

| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | archived_cost | 一次主程序验证 · MEASURED | 0.1146 | 44092.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | archived_cost | 已测工作总量 · MEASURED | 0.0082 | 4792.0000 | 0 | — |
| qcp | — | agent 填写证明 | archived_cost | 一次主程序验证 · MEASURED | 28.6720 | 191672.0000 | 54264 | — |
| qcp | — | Coq 编译与假设审计 | archived_cost | 一次主程序验证 · MEASURED | 2.0077 | 577472.0000 | 0 | — |
| qcp | — | 独立内核检查 | archived_cost | 一次主程序验证 · MEASURED | 123.9252 | 1810292.0000 | 0 | — |
| qcp | — | ITP 平均合计 | archived_cost | 一次主程序验证 · MEASURED | 154.6049 | 1810292.0000 | 54264 | — |
| fulminate | — | 插桩、编译与首次执行 | archived_cost | 已测工作总量 · MEASURED | 5.2767 | 44380.0000 | 0 | — |
| fulminate | — | 单独运行测试 | archived_cost | 已测工作总量 · MEASURED | 0.1828 | 1400.0000 | 0 | — |
| tespec | inline | native | current_execution | 46/46 · MEASURED | 6.3657 | 21192 | 0 | 46/46 |
| tespec | inline | auto | current_execution | 2/2 · MEASURED | 0.1850 | 54824 | 0 | — |
| tespec | inline | itp_model | current_execution | 2/2 · MEASURED | 0 | — | 0 | — |
| tespec | inline | itp_coq | current_execution | 2/2 · MEASURED | 7.8940 | 627300 | 0 | — |
| tespec | inline | itp_kernel | current_execution | 2/2 · MEASURED | 0 | — | 0 | — |
| tespec | modular | native | current_execution | 46/46 · MEASURED | 6.2701 | 21164 | 0 | 46/46 |
| tespec | modular | auto | current_execution | 2/2 · MEASURED | 0.1802 | 54664 | 0 | — |
| tespec | modular | itp_model | current_execution | 2/2 · MEASURED | 0 | — | 0 | — |
| tespec | modular | itp_coq | current_execution | 2/2 · MEASURED | 8.1436 | 627772 | 0 | — |
| tespec | modular | itp_kernel | current_execution | 2/2 · MEASURED | 0 | — | 0 | — |
| tespec | inline | auto | auto_on_itp_roots | 2/2 · MEASURED | 0.2485 | 54932 | 0 | — |
| tespec | modular | auto | auto_on_itp_roots | 2/2 · MEASURED | 0.2469 | 54824 | 0 | — |
| tespec | inline | layout_prepare | latest_native_matrix | 9/9 · MEASURED | 0.5385 | 18212 | 0 | — |
| tespec | inline | batch_auto | latest_native_matrix | 1/1 · MEASURED | 0.1165 | 54640 | 0 | — |
| tespec | inline | native | latest_native_matrix | 46/46 · MEASURED | 1.8486 | 21172 | 0 | 46/46 |
| tespec | inline | auto | latest_same_input_and_vc | 2/2 · MEASURED | 0.3219 | 54884 | 0 | — |
| tespec | inline | itp_model | latest_same_input_and_vc | 2/2 · MEASURED | 0 | — | 0 | — |
| tespec | inline | itp_coq | latest_same_input_and_vc | 2/2 · MEASURED | 18.2415 | 645880 | 0 | — |
| tespec | inline | itp_kernel | latest_same_input_and_vc | 2/2 · MEASURED | 354.4572 | 1964040 | 0 | — |
| tespec | inline | auto | same_input_profile_recheck_a21f363a | 2/2 · MEASURED | 0.2036 | 54840 | 0 | — |
| tespec | modular | layout_prepare | latest_native_matrix | 9/9 · MEASURED | 0.5273 | 18128 | 0 | — |
| tespec | modular | batch_auto | latest_native_matrix | 1/1 · MEASURED | 0.1182 | 54968 | 0 | — |
| tespec | modular | native | latest_native_matrix | 46/46 · MEASURED | 1.7598 | 21104 | 0 | 46/46 |
| tespec | modular | auto | latest_same_input_and_vc | 2/2 · MEASURED | 0.3408 | 54904 | 0 | — |
| tespec | modular | itp_model | latest_same_input_and_vc | 2/2 · MEASURED | 0 | — | 0 | — |
| tespec | modular | itp_coq | latest_same_input_and_vc | 2/2 · MEASURED | 17.9959 | 646264 | 0 | — |
| tespec | modular | itp_kernel | latest_same_input_and_vc | 2/2 · MEASURED | 325.8911 | 1964836 | 0 | — |
| tespec | modular | auto | same_input_profile_recheck_a21f363a | 2/2 · MEASURED | 0.2109 | 54932 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
