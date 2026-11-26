# dll_remove 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED_WITH_COMPAT_HEADERS |
| qcp | VERIFIED_KERNEL_CHECKED_WITH_RUNTIME_LIBRARY_ASSUMPTIONS |
| fulminate | {"PASS": 18, "body_only": 9, "concrete_driver_oracles": 18, "contracts_checked": 9, "expected_matches": 18, "input_pairs": 18} |

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 9 | 9 | 3 | 9 | 3 |
| modular | 9 | 9 | 2 | 9 | 2 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 | 0.0651 | 43784.0000 | 0 | — |
| cn | — | 主程序验证（当前兼容头文件） | 1/1 tool_receipt | 2.6839 | 46296 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 | 0.3153 | 9652.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 | — | — | — | — |
| qcp | — | 独立内核检查 | 一次主程序验证 | — | — | — | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 | — | — | — | — |
| qcp | — | 完整原始目标证明（含历史尝试） | charged proof attempts; missing fields unknown | — | — | 738383 | — |
| fulminate | — | pipeline | 18/18 tool_receipt | 6.5091 | 46652 | 0 | — |
| fulminate | — | test | 18/18 tool_receipt | 0.0617 | 1920 | 0 | — |
| fulminate | — | preflight | 2/2 tool_receipt | 0.0966 | 45588 | 0 | — |
| tespec | inline | native | 9/9 current_execution | 1.7214 | 21128 | 0 | 9/9 |
| tespec | inline | auto | 9/9 current_execution | 1.2454 | 57388 | 0 | — |
| tespec | inline | itp_model | 3/9 current_execution | 0 | — | 0 | — |
| tespec | inline | itp_coq | 3/9 current_execution | 21.2044 | 574752 | 0 | — |
| tespec | inline | itp_kernel | 3/9 current_execution | 403.9238 | 2047816 | 0 | — |
| tespec | modular | native | 9/9 current_execution | 1.7251 | 21184 | 0 | 9/9 |
| tespec | modular | auto | 9/9 current_execution | 1.0878 | 57304 | 0 | — |
| tespec | modular | itp_model | 2/9 current_execution | 0 | — | 0 | — |
| tespec | modular | itp_coq | 2/9 current_execution | 13.1490 | 574800 | 0 | — |
| tespec | modular | itp_kernel | 2/9 current_execution | 270.5801 | 2047564 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
