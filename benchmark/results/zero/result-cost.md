# zero 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED |
| qcp | VERIFIED_KERNEL_CHECKED |
| fulminate | 44/46 符合预期 · PASS 21、FAIL 25 |

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 46 | 46 | 44 | 2 | 0 |
| modular | 46 | 46 | 44 | 2 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 · MEASURED | 0.1146 | 44092.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 · MEASURED | 0.0082 | 4792.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 · MEASURED | 28.6720 | 191672.0000 | 54264 | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 · MEASURED | 2.0077 | 577472.0000 | 0 | — |
| qcp | — | 独立内核检查 | 一次主程序验证 · MEASURED | 123.9252 | 1810292.0000 | 0 | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 · MEASURED | 154.6049 | 1810292.0000 | 54264 | — |
| fulminate | — | 插桩、编译与首次执行 | 已测工作总量 · MEASURED | 5.2767 | 44380.0000 | 0 | — |
| fulminate | — | 单独运行测试 | 已测工作总量 · MEASURED | 0.1828 | 1400.0000 | 0 | — |
| tespec | inline | native | 46/46 · MEASURED | 6.3657 | 21192 | 0 | 46/46 |
| tespec | inline | auto | 2/2 · MEASURED | 0.1992 | 54756 | 0 | — |
| tespec | inline | itp_model | 0/2 · PENDING | — | — | — | — |
| tespec | inline | itp_coq | 0/2 · PENDING | — | — | — | — |
| tespec | inline | itp_kernel | 0/2 · PENDING | — | — | — | — |
| tespec | modular | native | 46/46 · MEASURED | 6.2701 | 21164 | 0 | 46/46 |
| tespec | modular | auto | 2/2 · MEASURED | 0.1865 | 54776 | 0 | — |
| tespec | modular | itp_model | 0/2 · PENDING | — | — | — | — |
| tespec | modular | itp_coq | 0/2 · PENDING | — | — | — | — |
| tespec | modular | itp_kernel | 0/2 · PENDING | — | — | — | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
