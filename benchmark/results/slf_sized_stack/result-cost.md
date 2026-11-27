# slf_sized_stack 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | ORIGINAL_MODULE_REJECTED |
| qcp | VC_GENERATED_PROOF_OR_REFUTATION_PENDING |
| fulminate | 0/47 符合预期 · NOT_BUILT 47 |

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 47 | 10 | 3 | 42 | 0 |
| modular | 47 | 10 | 3 | 42 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 · MEASURED | 0.0646 | 44868.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 · MEASURED | 0.0645 | 9076.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | 独立内核检查 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 · PENDING | — | — | — | — |
| fulminate | — | 插桩、编译与首次执行 | 已测工作总量 · MEASURED | 3.0861 | 45128.0000 | 0 | — |
| fulminate | — | 单独运行测试 | 0/47 · NOT_BUILT | — | — | 0 | — |
| tespec | inline | native | 47/47 · MEASURED | 8.3502 | 21132 | 0 | 47/47 |
| tespec | inline | auto | 42/42 · MEASURED | 3.9008 | 54584 | 0 | — |
| tespec | inline | itp_model | 0/42 · PENDING | — | — | — | — |
| tespec | inline | itp_coq | 0/42 · PENDING | — | — | — | — |
| tespec | inline | itp_kernel | 0/42 · PENDING | — | — | — | — |
| tespec | modular | native | 47/47 · MEASURED | 8.0466 | 21136 | 0 | 47/47 |
| tespec | modular | auto | 42/42 · MEASURED | 3.7089 | 54652 | 0 | — |
| tespec | modular | itp_model | 0/42 · PENDING | — | — | — | — |
| tespec | modular | itp_coq | 0/42 · PENDING | — | — | — | — |
| tespec | modular | itp_kernel | 0/42 · PENDING | — | — | — | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
