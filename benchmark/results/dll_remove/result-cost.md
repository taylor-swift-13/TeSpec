# dll_remove 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED_WITH_COMPAT_HEADERS |
| qcp | VERIFIED_KERNEL_CHECKED_WITH_RUNTIME_LIBRARY_ASSUMPTIONS |
| fulminate | 18/18 符合预期 |

全量 Auto 符合预期：inline 9/9，modular 9/9。[同一输入的跨工具比较](../paired-tool-comparison.md)。

| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |
|---|---:|---:|---:|---:|---:|
| inline | 0 | 9 | 9 | 0 | 9 |
| modular | 0 | 9 | 4 | 5 | 4 |

以下为旧冻结双路线批次。

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 9 | 9 | 9 | 9 | 9 |
| modular | 9 | 9 | 9 | 9 | 9 |

| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | archived_cost | 一次主程序验证 · MEASURED | 0.0651 | 43784.0000 | 0 | — |
| cn | — | 主程序验证（当前兼容头文件） | tool_receipt | 1/1 · one verification | 2.6839 | 46296 | 0 | — |
| qcp | — | VC 生成与自动处理 | archived_cost | 已测工作总量 · MEASURED | 0.3153 | 9652.0000 | 0 | — |
| qcp | — | agent 填写证明 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | 独立内核检查 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | ITP 平均合计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | 完整原始目标证明（含历史尝试） | proof_receipt | charged proof attempts; missing fields unknown · VERIFIED_KERNEL_CHECKED_WITH_RUNTIME_LIBRARY_ASSUMPTIONS | — | — | 738383 | — |
| qcp | — | 当前 QCP 原始目标生成（含全部尝试） | local_replay | native generation; compare against archived certificate · DIFFERENT_GOAL | 1.4515 | 90604 | 0 | — |
| qcp | — | coq | local_replay | local replay · KERNEL_REPLAYED | 19.3515 | 695292 | 0 | — |
| qcp | — | kernel | local_replay | local replay · KERNEL_REPLAYED | 135.3046 | 1737404 | 0 | — |
| qcp | — | standalone_generation | standalone_qcp | 1/1 · one verification | 0.8378 | 90344 | 0 | — |
| fulminate | — | pipeline | tool_receipt | 18/18 · stage total | 6.5091 | 46652 | 0 | — |
| fulminate | — | test | tool_receipt | 18/18 · stage total | 0.0617 | 1920 | 0 | — |
| fulminate | — | preflight | tool_receipt | 2/2 · stage total | 0.0966 | 45588 | 0 | — |
| tespec | inline | native | current_execution | 9/9 · MEASURED | 1.7214 | 21128 | 0 | 9/9 |
| tespec | inline | auto | current_execution | 9/9 · MEASURED | 1.1870 | 57388 | 0 | — |
| tespec | inline | itp_model | current_execution | 9/9 · MEASURED | 0 | — | 0 | — |
| tespec | inline | itp_coq | current_execution | 9/9 · MEASURED | 66.0267 | 657236 | 0 | — |
| tespec | inline | itp_kernel | current_execution | 9/9 · MEASURED | 1211.3040 | 2047816 | 0 | — |
| tespec | modular | native | current_execution | 9/9 · MEASURED | 1.7251 | 21184 | 0 | 9/9 |
| tespec | modular | auto | current_execution | 9/9 · MEASURED | 1.2041 | 57600 | 0 | — |
| tespec | modular | itp_model | current_execution | 9/9 · MEASURED | 0 | — | 0 | — |
| tespec | modular | itp_coq | current_execution | 9/9 · MEASURED | 64.6246 | 657056 | 0 | — |
| tespec | modular | itp_kernel | current_execution | 9/9 · MEASURED | 1200.6048 | 2047564 | 0 | — |
| tespec | inline | auto | auto_on_itp_roots | 9/9 · MEASURED | 1.3674 | 57324 | 0 | — |
| tespec | modular | auto | auto_on_itp_roots | 9/9 · MEASURED | 1.3579 | 57544 | 0 | — |
| tespec | inline | layout_prepare | latest_native_matrix | 1/1 · MEASURED | 0.1456 | 19740 | 0 | — |
| tespec | inline | batch_auto | latest_native_matrix | 1/1 · MEASURED | 0.5364 | 58972 | 0 | — |
| tespec | inline | native | latest_native_matrix | 9/9 · MEASURED | 1.2244 | 21008 | 0 | 9/9 |
| tespec | inline | auto | latest_same_input_and_vc | 9/9 · MEASURED | 1.8197 | 57456 | 0 | — |
| tespec | inline | itp_model | latest_same_input_and_vc | 9/9 · MEASURED | 0 | — | 0 | — |
| tespec | inline | itp_coq | latest_same_input_and_vc | 9/9 · MEASURED | 82.0064 | 657440 | 0 | — |
| tespec | inline | itp_kernel | latest_same_input_and_vc | 9/9 · MEASURED | 1577.9219 | 2052372 | 0 | — |
| tespec | inline | auto | same_input_profile_recheck_a21f363a | 9/9 · MEASURED | 1.4663 | 57288 | 0 | — |
| tespec | modular | layout_prepare | latest_native_matrix | 1/1 · MEASURED | 0.1539 | 19936 | 0 | — |
| tespec | modular | batch_auto | latest_native_matrix | 1/1 · MEASURED | 0.5300 | 59180 | 0 | — |
| tespec | modular | native | latest_native_matrix | 9/9 · MEASURED | 1.2275 | 21340 | 0 | 9/9 |
| tespec | modular | auto | latest_same_input_and_vc | 9/9 · MEASURED | 1.9451 | 57332 | 0 | — |
| tespec | modular | itp_model | latest_same_input_and_vc | 4/9 · PARTIAL | 0 | — | 0 | — |
| tespec | modular | itp_coq | latest_same_input_and_vc | 4/9 · PARTIAL | 37.2071 | 574636 | 0 | — |
| tespec | modular | itp_kernel | latest_same_input_and_vc | 4/9 · PARTIAL | 779.5688 | 2052836 | 0 | — |
| tespec | modular | auto | same_input_profile_recheck_a21f363a | 9/9 · MEASURED | 1.4561 | 57448 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
