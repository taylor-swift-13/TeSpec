# abs_mem_struct 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED |
| qcp | VERIFIED_KERNEL_CHECKED |
| fulminate | 7/7 符合预期 · PASS 7 |

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 7 | 7 | 7 | 0 | 0 |
| modular | 7 | 7 | 7 | 0 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 · MEASURED | 0.3153 | 43840.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 · MEASURED | 0.0162 | 5780.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 · MEASURED | 383.3580 | 195836.0000 | 668848 | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 · MEASURED | 14.5669 | 585440.0000 | 0 | — |
| qcp | — | 独立内核检查 | 一次主程序验证 · MEASURED | 132.3717 | 2081044.0000 | 0 | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 · MEASURED | 530.2966 | 2081044.0000 | 668848 | — |
| fulminate | — | 插桩、编译与首次执行 | 已测工作总量 · MEASURED | 0.8532 | 44468.0000 | 0 | — |
| fulminate | — | 单独运行测试 | 已测工作总量 · MEASURED | 0.0254 | 1132.0000 | 0 | — |
| tespec | inline | native | 7/7 · MEASURED | 0.9008 | 21048 | 0 | 7/7 |
| tespec | inline | auto | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_model | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_coq | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_kernel | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | native | 7/7 · MEASURED | 0.8745 | 21140 | 0 | 7/7 |
| tespec | modular | auto | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_model | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_coq | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_kernel | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
