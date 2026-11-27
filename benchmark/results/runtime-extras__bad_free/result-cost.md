# runtime-extras__bad_free 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | ACCEPTED_TARGETS_TRUSTED |
| qcp | NATIVE_GENERATION_INCOMPLETE |
| fulminate | 8/8 符合预期 · FAIL 7、PASS 1 |

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 8 | 8 | 7 | 1 | 0 |
| modular | 8 | 8 | 7 | 1 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 · MEASURED | 0.1147 | 44036.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 · MEASURED | 0.0080 | 5016.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | 独立内核检查 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 · PENDING | — | — | — | — |
| fulminate | — | 插桩、编译与首次执行 | 已测工作总量 · MEASURED | 0.9176 | 44212.0000 | 0 | — |
| fulminate | — | 单独运行测试 | 已测工作总量 · MEASURED | 0.0311 | 1400.0000 | 0 | — |
| tespec | inline | native | 8/8 · MEASURED | 1.1810 | 21116 | 0 | 8/8 |
| tespec | inline | auto | 1/1 · MEASURED | 0.1027 | 55604 | 0 | — |
| tespec | inline | itp_model | 0/1 · PENDING | — | — | — | — |
| tespec | inline | itp_coq | 0/1 · PENDING | — | — | — | — |
| tespec | inline | itp_kernel | 0/1 · PENDING | — | — | — | — |
| tespec | modular | native | 8/8 · MEASURED | 1.1263 | 21116 | 0 | 8/8 |
| tespec | modular | auto | 1/1 · MEASURED | 0.0882 | 55012 | 0 | — |
| tespec | modular | itp_model | 0/1 · PENDING | — | — | — | — |
| tespec | modular | itp_coq | 0/1 · PENDING | — | — | — | — |
| tespec | modular | itp_kernel | 0/1 · PENDING | — | — | — | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
