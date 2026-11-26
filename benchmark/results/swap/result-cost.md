# swap 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED |
| qcp | VERIFIED_KERNEL_CHECKED |
| fulminate | {"case_pairs": 10, "correct": 10, "native_status_counts": {"PASS": 10}} |

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 10 | 10 | 10 | 0 | 0 |
| modular | 10 | 10 | 10 | 0 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 | 0.1649 | 43240.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 | 0.0083 | 4804.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 | 21.3600 | 191464.0000 | 53655 | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 | 1.3636 | 526624.0000 | 0 | — |
| qcp | — | 独立内核检查 | 一次主程序验证 | 125.4517 | 2029576.0000 | 0 | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 | 148.1753 | 2029576.0000 | 53655 | — |
| fulminate | — | 插桩、编译与首次执行 | 已测工作总量 | 1.1976 | 44072.0000 | 0 | — |
| fulminate | — | 单独运行测试 | 已测工作总量 | 0.0398 | 1132.0000 | 0 | — |
| tespec | inline | native | 10/10 current_execution | 1.4625 | 21112 | 0 | 10/10 |
| tespec | inline | auto | 0/0 current_execution | 0 | — | 0 | — |
| tespec | inline | itp_model | 0/0 current_execution | 0 | — | 0 | — |
| tespec | inline | itp_coq | 0/0 current_execution | 0 | — | 0 | — |
| tespec | inline | itp_kernel | 0/0 current_execution | 0 | — | 0 | — |
| tespec | modular | native | 10/10 current_execution | 1.4850 | 21160 | 0 | 10/10 |
| tespec | modular | auto | 0/0 current_execution | 0 | — | 0 | — |
| tespec | modular | itp_model | 0/0 current_execution | 0 | — | 0 | — |
| tespec | modular | itp_coq | 0/0 current_execution | 0 | — | 0 | — |
| tespec | modular | itp_kernel | 0/0 current_execution | 0 | — | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
