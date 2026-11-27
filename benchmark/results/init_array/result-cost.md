# init_array 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED |
| qcp | CURRENT_GENERATOR_REJECTED_HISTORICAL_PROOF_RETAINED |
| fulminate | 18/18 符合预期 · PASS 18 |

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 18 | 18 | 6 | 12 | 0 |
| modular | 18 | 1 | 1 | 1 | 1 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 · MEASURED | 0.3153 | 44700.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 · MEASURED | 0.0244 | 5796.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | 独立内核检查 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 · PENDING | — | — | — | — |
| fulminate | — | 插桩、编译与首次执行 | 已测工作总量 · MEASURED | 2.1140 | 44480.0000 | 0 | — |
| fulminate | — | 单独运行测试 | 已测工作总量 · MEASURED | 0.0710 | 1132.0000 | 0 | — |
| tespec | inline | native | 18/18 · MEASURED | 2.6482 | 21352 | 0 | 18/18 |
| tespec | inline | auto | 12/12 · MEASURED | 2.0547 | 56116 | 0 | — |
| tespec | inline | itp_model | 0/12 · PENDING | — | — | — | — |
| tespec | inline | itp_coq | 0/12 · PENDING | — | — | — | — |
| tespec | inline | itp_kernel | 0/12 · PENDING | — | — | — | — |
| tespec | modular | native | 18/18 · MEASURED | 2.4662 | 21132 | 0 | 18/18 |
| tespec | modular | auto | 1/1 · MEASURED | 0.0897 | 51972 | 0 | — |
| tespec | modular | itp_model | 1/1 · MEASURED | 114.6250 | 172052.0000 | 432498 | — |
| tespec | modular | itp_coq | 1/1 · MEASURED | 4.4655 | 564008 | 0 | — |
| tespec | modular | itp_kernel | 1/1 · MEASURED | 128.3313 | 1809652 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
