# slf18_two_dice 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | ORIGINAL_CN_MODULE_REJECTED |
| qcp | VERIFIED_KERNEL_CHECKED |
| fulminate | {"case_pairs": 14, "correct": 14, "native_status_counts": {"PASS": 14}} |

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 14 | 14 | 0 | 14 | 0 |
| modular | 14 | 14 | 2 | 12 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 | 0.1650 | 44408.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 | 0.0329 | 5852.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 | 73.7030 | 192200.0000 | 140223 | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 | 3.1488 | 587828.0000 | 0 | — |
| qcp | — | 独立内核检查 | 一次主程序验证 | 125.2866 | 1808032.0000 | 0 | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 | 202.1385 | 1808032.0000 | 140223 | — |
| fulminate | — | 插桩、编译与首次执行 | 已测工作总量 | 1.7072 | 44692.0000 | 0 | — |
| fulminate | — | 单独运行测试 | 已测工作总量 | 0.0535 | 1132.0000 | 0 | — |
| tespec | inline | native | 14/14 current_execution | 2.0703 | 21152 | 0 | 14/14 |
| tespec | inline | auto | 14/14 current_execution | 1.3960 | 55352 | 0 | — |
| tespec | inline | itp_model | 0/14 current_execution | — | — | — | — |
| tespec | inline | itp_coq | 0/14 current_execution | — | — | — | — |
| tespec | inline | itp_kernel | 0/14 current_execution | — | — | — | — |
| tespec | modular | native | 14/14 current_execution | 2.0839 | 21052 | 0 | 14/14 |
| tespec | modular | auto | 12/12 current_execution | 1.2242 | 54508 | 0 | — |
| tespec | modular | itp_model | 0/12 current_execution | — | — | — | — |
| tespec | modular | itp_coq | 0/12 current_execution | — | — | — | — |
| tespec | modular | itp_kernel | 0/12 current_execution | — | — | — | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
