# queue_all 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | ORIGINAL_MODULE_REJECTED |
| qcp | NATIVE_GENERATION_INCOMPLETE |
| fulminate | 0/34 符合预期 · NOT_BUILT 34 |

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 34 | 12 | 6 | 11 | 0 |
| modular | 34 | 14 | 6 | 15 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 · MEASURED | 0.0645 | 45800.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 · MEASURED | 0.0080 | 5320.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | 独立内核检查 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 · PENDING | — | — | — | — |
| fulminate | — | 插桩、编译与首次执行 | 已测工作总量 · MEASURED | 2.1971 | 46008.0000 | 0 | — |
| fulminate | — | 单独运行测试 | 0/34 · NOT_BUILT | — | — | 0 | — |
| tespec | inline | native | 34/34 · MEASURED | 126.7643 | 21204 | 0 | 30/34 |
| tespec | inline | auto | 11/11 · MEASURED | 1.1781 | 56936 | 0 | — |
| tespec | inline | itp_model | 0/11 · PENDING | — | — | — | — |
| tespec | inline | itp_coq | 0/11 · PENDING | — | — | — | — |
| tespec | inline | itp_kernel | 0/11 · PENDING | — | — | — | — |
| tespec | modular | native | 34/34 · MEASURED | 6.9391 | 21188 | 0 | 34/34 |
| tespec | modular | auto | 15/15 · MEASURED | 1.6462 | 56872 | 0 | — |
| tespec | modular | itp_model | 0/15 · PENDING | — | — | — | — |
| tespec | modular | itp_coq | 0/15 · PENDING | — | — | — | — |
| tespec | modular | itp_kernel | 0/15 · PENDING | — | — | — | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
