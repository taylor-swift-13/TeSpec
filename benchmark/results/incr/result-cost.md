# incr 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED |
| qcp | VERIFIED_KERNEL_CHECKED |
| fulminate | {"case_pairs": 103, "correct": 97, "native_status_counts": {"FAIL": 69, "PASS": 34}} |

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 103 | 103 | 90 | 13 | 0 |
| modular | 103 | 103 | 90 | 13 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 | 0.1149 | 43364.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 | 0.0080 | 5036.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 | 45.1560 | 196352.0000 | 75692 | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 | 2.1223 | 578560.0000 | 0 | — |
| qcp | — | 独立内核检查 | 一次主程序验证 | 140.9171 | 2048052.0000 | 0 | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 | 188.1954 | 2048052.0000 | 75692 | — |
| fulminate | — | 插桩、编译与首次执行 | 已测工作总量 | 11.8205 | 43124.0000 | 0 | — |
| fulminate | — | 单独运行测试 | 已测工作总量 | 0.4099 | 1400.0000 | 0 | — |
| tespec | inline | native | 103/103 current_execution | 13.4200 | 21184 | 0 | 103/103 |
| tespec | inline | auto | 13/13 current_execution | 1.1862 | 55256 | 0 | — |
| tespec | inline | itp_model | 0/13 current_execution | — | — | — | — |
| tespec | inline | itp_coq | 0/13 current_execution | — | — | — | — |
| tespec | inline | itp_kernel | 0/13 current_execution | — | — | — | — |
| tespec | modular | native | 103/103 current_execution | 13.6030 | 21176 | 0 | 103/103 |
| tespec | modular | auto | 13/13 current_execution | 1.1866 | 55232 | 0 | — |
| tespec | modular | itp_model | 0/13 current_execution | — | — | — | — |
| tespec | modular | itp_coq | 0/13 current_execution | — | — | — | — |
| tespec | modular | itp_kernel | 0/13 current_execution | — | — | — | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
