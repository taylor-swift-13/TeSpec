# runway__funcs2 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | ORIGINAL_MODULE_REJECTED |
| qcp | 主程序生成 248 个原始目标；独立检查覆盖已记录的证明子集 |
| fulminate | {"case_pairs": 150, "correct": 0, "native_status_counts": {"NOT_BUILT": 150}} |

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 150 | 120 | 120 | 0 | 0 |
| modular | 150 | 120 | 120 | 0 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 | 0.0646 | 42764.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 | 7.6375 | 102096.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 | 1.1080 | 550548.0000 | 0 | — |
| qcp | — | 独立内核检查 | 一次主程序验证 | — | — | — | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 | — | — | — | — |
| fulminate | — | 插桩、编译与首次执行 | 已测工作总量 | 6.3237 | 45680.0000 | 0 | — |
| fulminate | — | 单独运行测试 | 已测工作总量 | — | — | 0 | — |
| tespec | inline | native | 150/150 current_execution | 31.4814 | 35556 | 0 | 150/150 |
| tespec | inline | auto | 0/0 current_execution | 0 | — | 0 | — |
| tespec | inline | itp_model | 0/0 current_execution | 0 | — | 0 | — |
| tespec | inline | itp_coq | 0/0 current_execution | 0 | — | 0 | — |
| tespec | inline | itp_kernel | 0/0 current_execution | 0 | — | 0 | — |
| tespec | modular | native | 150/150 current_execution | 88.2863 | 22224 | 0 | 150/150 |
| tespec | modular | auto | 0/0 current_execution | 0 | — | 0 | — |
| tespec | modular | itp_model | 0/0 current_execution | 0 | — | 0 | — |
| tespec | modular | itp_coq | 0/0 current_execution | 0 | — | 0 | — |
| tespec | modular | itp_kernel | 0/0 current_execution | 0 | — | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
