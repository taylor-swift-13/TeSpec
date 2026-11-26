# read 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED |
| qcp | VERIFIED_KERNEL_CHECKED |
| fulminate | {"accuracy": 0.9836065573770492, "case_pairs": 61, "correct": 60, "status_counts": {"PASS": 23, "RUNTIME_FAILURE": 38}} |

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 61 | 61 | 49 | 12 | 0 |
| modular | 61 | 61 | 49 | 12 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 | 0.0787 | 44060.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 | 0.0064 | 4544.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 | 49.3910 | 193936.0000 | 126128 | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 | 1.6964 | 526940.0000 | 0 | — |
| qcp | — | 独立内核检查 | 一次主程序验证 | 126.6930 | 2043932.0000 | 0 | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 | 177.7804 | 2043932.0000 | 126128 | — |
| fulminate | — | 插桩、编译与首次执行 | 已测工作总量 | 7.0446 | 44280.0000 | 0 | — |
| fulminate | — | 单独运行测试 | 已测工作总量 | 0.2346 | 1400.0000 | 0 | — |
| tespec | inline | native | 61/61 current_execution | 8.7644 | 21192 | 0 | 61/61 |
| tespec | inline | auto | 12/12 current_execution | 1.1932 | 55180 | 0 | — |
| tespec | inline | itp_model | 0/12 current_execution | — | — | — | — |
| tespec | inline | itp_coq | 0/12 current_execution | — | — | — | — |
| tespec | inline | itp_kernel | 0/12 current_execution | — | — | — | — |
| tespec | modular | native | 61/61 current_execution | 8.6668 | 21180 | 0 | 61/61 |
| tespec | modular | auto | 12/12 current_execution | 1.1880 | 55216 | 0 | — |
| tespec | modular | itp_model | 0/12 current_execution | — | — | — | — |
| tespec | modular | itp_coq | 0/12 current_execution | — | — | — | — |
| tespec | modular | itp_kernel | 0/12 current_execution | — | — | — | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
