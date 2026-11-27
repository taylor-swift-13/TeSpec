# queue_all 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | ORIGINAL_MODULE_REJECTED |
| qcp | NATIVE_GENERATION_INCOMPLETE |
| fulminate | 0/34 符合预期 · NOT_BUILT 34 |

默认 Auto 布局绑定后，38/68 次符合预期。原字段地址未绑定的 10 次中，10 次入口 SAT，10 次整次符合预期。[逐执行结果与成本](tespec/auto-layout.json)

下表的双路线对照保留原 VC；默认 Auto 的成本在阶段表中标记为 default_auto_layout。

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
| tespec | inline | layout_prepare | 10/10 · MEASURED | 53.1148 | 569420 | 0 | — |
| tespec | inline | layout_check | 34/34 · MEASURED | 1.7049 | 18184 | 0 | — |
| tespec | inline | native | 34/34 · MEASURED | 128.0992 | 21660 | 0 | 30/34 |
| tespec | inline | auto | 11/11 · MEASURED | 1.9803 | 59644 | 0 | — |
| tespec | inline | prior_native_attempt | 7/7 · MEASURED | 1.6741 | 21572 | 0 | — |
| tespec | modular | layout_prepare | 10/10 · MEASURED | 52.9528 | 569244 | 0 | — |
| tespec | modular | layout_check | 34/34 · MEASURED | 1.6386 | 18040 | 0 | — |
| tespec | modular | native | 34/34 · MEASURED | 8.0984 | 21672 | 0 | 34/34 |
| tespec | modular | auto | 15/15 · MEASURED | 3.0927 | 59652 | 0 | — |
| tespec | modular | prior_native_attempt | 13/13 · MEASURED | 2.9999 | 21568 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
