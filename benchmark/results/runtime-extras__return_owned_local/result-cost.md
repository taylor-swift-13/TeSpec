# runtime-extras__return_owned_local 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | ACCEPTED_WITH_NEGATIVE_TARGETS_TRUSTED |
| qcp | NEGATIVE_MODULE_GENERATED_CURRENT_AUDIT_PENDING |
| fulminate | 13/13 符合预期 · PASS 6、FAIL 7 |

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 13 | 13 | 6 | 7 | 0 |
| modular | 13 | 13 | 6 | 7 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 · MEASURED | 0.1654 | 43244.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 · MEASURED | 0.0163 | 5848.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | 独立内核检查 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 · PENDING | — | — | — | — |
| fulminate | — | 插桩、编译与首次执行 | 已测工作总量 · MEASURED | 1.5423 | 44512.0000 | 0 | — |
| fulminate | — | 单独运行测试 | 已测工作总量 · MEASURED | 0.0518 | 1412.0000 | 0 | — |
| tespec | inline | native | 13/13 · MEASURED | 1.8856 | 21160 | 0 | 13/13 |
| tespec | inline | auto | 7/7 · MEASURED | 0.7550 | 55352 | 0 | — |
| tespec | inline | itp_model | 0/7 · PENDING | — | — | — | — |
| tespec | inline | itp_coq | 0/7 · PENDING | — | — | — | — |
| tespec | inline | itp_kernel | 0/7 · PENDING | — | — | — | — |
| tespec | modular | native | 13/13 · MEASURED | 1.8235 | 21144 | 0 | 13/13 |
| tespec | modular | auto | 7/7 · MEASURED | 0.7362 | 55640 | 0 | — |
| tespec | modular | itp_model | 0/7 · PENDING | — | — | — | — |
| tespec | modular | itp_coq | 0/7 · PENDING | — | — | — | — |
| tespec | modular | itp_kernel | 0/7 · PENDING | — | — | — | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
