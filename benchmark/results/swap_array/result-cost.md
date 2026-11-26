# swap_array 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED |
| qcp | VERIFIED_KERNEL_CHECKED_WITH_RUNTIME_LIBRARY_ASSUMPTIONS |
| fulminate | 20/20 符合预期 · PASS 20 |

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 20 | 20 | 20 | 0 | 0 |
| modular | 20 | 20 | 20 | 0 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 · MEASURED | 0.3151 | 44524.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 · MEASURED | 0.0323 | 6852.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 · MEASURED | 105.8900 | 303144.0000 | 196860 | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 · MEASURED | 5.3648 | 594436.0000 | 0 | — |
| qcp | — | 独立内核检查 | 一次主程序验证 · MEASURED | 125.7672 | 2081824.0000 | 0 | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 · MEASURED | 237.0220 | 2081824.0000 | 196860 | — |
| fulminate | — | 插桩、编译与首次执行 | 已测工作总量 · MEASURED | 2.3446 | 44360.0000 | 0 | — |
| fulminate | — | 单独运行测试 | 已测工作总量 · MEASURED | 0.0783 | 1136.0000 | 0 | — |
| tespec | inline | native | 20/20 · MEASURED | 3.0626 | 21132 | 0 | 20/20 |
| tespec | inline | auto | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_model | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_coq | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_kernel | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | native | 20/20 · MEASURED | 3.0282 | 21188 | 0 | 20/20 |
| tespec | modular | auto | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_model | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_coq | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_kernel | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
