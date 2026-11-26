# ref 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED |
| qcp | VERIFIED_KERNEL_CHECKED |
| fulminate | {"case_pairs": 24, "correct": 24, "native_status_counts": {"PASS": 24}} |

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 24 | 24 | 24 | 0 | 0 |
| modular | 24 | 24 | 24 | 0 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 | 0.1148 | 44484.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 | 0.0081 | 5324.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 | 47.9210 | 191808.0000 | 108756 | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 | 3.4756 | 527720.0000 | 0 | — |
| qcp | — | 独立内核检查 | 一次主程序验证 | 125.4554 | 2085476.0000 | 0 | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 | 176.8520 | 2085476.0000 | 108756 | — |
| fulminate | — | 插桩、编译与首次执行 | 已测工作总量 | 2.8021 | 44800.0000 | 0 | — |
| fulminate | — | 单独运行测试 | 已测工作总量 | 0.0937 | 1132.0000 | 0 | — |
| tespec | inline | native | 24/24 current_execution | 3.3570 | 21188 | 0 | 24/24 |
| tespec | inline | auto | 0/0 current_execution | 0 | — | 0 | — |
| tespec | inline | itp_model | 0/0 current_execution | 0 | — | 0 | — |
| tespec | inline | itp_coq | 0/0 current_execution | 0 | — | 0 | — |
| tespec | inline | itp_kernel | 0/0 current_execution | 0 | — | 0 | — |
| tespec | modular | native | 24/24 current_execution | 3.3024 | 21096 | 0 | 24/24 |
| tespec | modular | auto | 0/0 current_execution | 0 | — | 0 | — |
| tespec | modular | itp_model | 0/0 current_execution | 0 | — | 0 | — |
| tespec | modular | itp_coq | 0/0 current_execution | 0 | — | 0 | — |
| tespec | modular | itp_kernel | 0/0 current_execution | 0 | — | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
