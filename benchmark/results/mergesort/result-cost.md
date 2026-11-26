# mergesort 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | ORIGINAL_MODULE_REJECTED |
| qcp | VC_GENERATED_PROOF_OR_REFUTATION_PENDING |
| fulminate | {"case_pairs": 17, "correct": 0, "native_status_counts": {"NOT_BUILT": 17}} |

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 17 | 1 | 1 | 12 | 0 |
| modular | 17 | 1 | 1 | 12 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 | 0.0644 | 44824.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 | 0.1148 | 11992.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 | — | — | — | — |
| qcp | — | 独立内核检查 | 一次主程序验证 | — | — | — | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 | — | — | — | — |
| fulminate | — | 插桩、编译与首次执行 | 已测工作总量 | 1.0968 | 45340.0000 | 0 | — |
| fulminate | — | 单独运行测试 | 已测工作总量 | — | — | 0 | — |
| tespec | inline | native | 17/17 current_execution | 2.9912 | 31308 | 0 | 17/17 |
| tespec | inline | auto | 12/12 current_execution | 1.1214 | 47332 | 0 | — |
| tespec | inline | itp_model | 0/12 current_execution | — | — | — | — |
| tespec | inline | itp_coq | 0/12 current_execution | — | — | — | — |
| tespec | inline | itp_kernel | 0/12 current_execution | — | — | — | — |
| tespec | modular | native | 17/17 current_execution | 2.8588 | 21152 | 0 | 17/17 |
| tespec | modular | auto | 12/12 current_execution | 1.1286 | 46952 | 0 | — |
| tespec | modular | itp_model | 0/12 current_execution | — | — | — | — |
| tespec | modular | itp_coq | 0/12 current_execution | — | — | — | — |
| tespec | modular | itp_kernel | 0/12 current_execution | — | — | — | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
