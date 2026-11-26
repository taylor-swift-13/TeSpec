# slf_quadruple_mem 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED |
| qcp | VERIFIED_KERNEL_CHECKED |
| fulminate | {"case_pairs": 7, "correct": 7, "native_status_counts": {"PASS": 7}} |

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 7 | 7 | 7 | 0 | 0 |
| modular | 7 | 7 | 7 | 0 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 | 0.1146 | 42932.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 | 0.0080 | 5028.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 | 28.8910 | 196360.0000 | 55340 | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 | 1.9596 | 580244.0000 | 0 | — |
| qcp | — | 独立内核检查 | 一次主程序验证 | 125.6015 | 1809644.0000 | 0 | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 | 156.4520 | 1809644.0000 | 55340 | — |
| fulminate | — | 插桩、编译与首次执行 | 已测工作总量 | 0.8029 | 43208.0000 | 0 | — |
| fulminate | — | 单独运行测试 | 已测工作总量 | 0.0277 | 1132.0000 | 0 | — |
| tespec | inline | native | 7/7 current_execution | 1.0148 | 20920 | 0 | 7/7 |
| tespec | inline | auto | 0/0 current_execution | 0 | — | 0 | — |
| tespec | inline | itp_model | 0/0 current_execution | 0 | — | 0 | — |
| tespec | inline | itp_coq | 0/0 current_execution | 0 | — | 0 | — |
| tespec | inline | itp_kernel | 0/0 current_execution | 0 | — | 0 | — |
| tespec | modular | native | 7/7 current_execution | 0.9852 | 21104 | 0 | 7/7 |
| tespec | modular | auto | 0/0 current_execution | 0 | — | 0 | — |
| tespec | modular | itp_model | 0/0 current_execution | 0 | — | 0 | — |
| tespec | modular | itp_coq | 0/0 current_execution | 0 | — | 0 | — |
| tespec | modular | itp_kernel | 0/0 current_execution | 0 | — | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
