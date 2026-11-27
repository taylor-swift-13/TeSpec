# slf3_basic_inplace_double 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED |
| qcp | VERIFIED_KERNEL_CHECKED |
| fulminate | 52/52 符合预期 · PASS 20、FAIL 32 |

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 52 | 52 | 50 | 2 | 0 |
| modular | 52 | 52 | 50 | 2 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 · MEASURED | 0.2152 | 43916.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 · MEASURED | 0.0081 | 5092.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 · MEASURED | 34.9690 | 191248.0000 | 55440 | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 · MEASURED | 1.8090 | 579236.0000 | 0 | — |
| qcp | — | 独立内核检查 | 一次主程序验证 · MEASURED | 125.9261 | 2026528.0000 | 0 | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 · MEASURED | 162.7042 | 2026528.0000 | 55440 | — |
| fulminate | — | 插桩、编译与首次执行 | 已测工作总量 · MEASURED | 5.9678 | 44392.0000 | 0 | — |
| fulminate | — | 单独运行测试 | 已测工作总量 · MEASURED | 0.1996 | 1404.0000 | 0 | — |
| tespec | inline | native | 52/52 · MEASURED | 8.3591 | 21180 | 0 | 52/52 |
| tespec | inline | auto | 2/2 · MEASURED | 0.1807 | 55428 | 0 | — |
| tespec | inline | itp_model | 0/2 · PENDING | — | — | — | — |
| tespec | inline | itp_coq | 0/2 · PENDING | — | — | — | — |
| tespec | inline | itp_kernel | 0/2 · PENDING | — | — | — | — |
| tespec | modular | native | 52/52 · MEASURED | 8.2306 | 21144 | 0 | 52/52 |
| tespec | modular | auto | 2/2 · MEASURED | 0.1781 | 55392 | 0 | — |
| tespec | modular | itp_model | 0/2 · PENDING | — | — | — | — |
| tespec | modular | itp_coq | 0/2 · PENDING | — | — | — | — |
| tespec | modular | itp_kernel | 0/2 · PENDING | — | — | — | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
