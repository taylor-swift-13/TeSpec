# const_example 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED |
| qcp | VERIFIED_KERNEL_CHECKED |
| fulminate | 7/7 符合预期 · PASS 7 |

全量 Auto 符合预期：inline 7/7，modular 7/7。[同一输入的跨工具比较](../paired-tool-comparison.md)。

| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |
|---|---:|---:|---:|---:|---:|
| inline | 7 | 0 | 0 | 0 | 7 |
| modular | 7 | 0 | 0 | 0 | 7 |

以下为旧冻结双路线批次。

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 7 | 7 | 7 | 0 | 0 |
| modular | 7 | 7 | 7 | 0 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | archived_cost | 一次主程序验证 · MEASURED | 0.1145 | 42896.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | archived_cost | 已测工作总量 · MEASURED | 0.0161 | 4888.0000 | 0 | — |
| qcp | — | agent 填写证明 | archived_cost | 一次主程序验证 · MEASURED | 39.6250 | 196060.0000 | 53629 | — |
| qcp | — | Coq 编译与假设审计 | archived_cost | 一次主程序验证 · MEASURED | 1.9494 | 577088.0000 | 0 | — |
| qcp | — | 独立内核检查 | archived_cost | 一次主程序验证 · MEASURED | 131.1420 | 2030500.0000 | 0 | — |
| qcp | — | ITP 平均合计 | archived_cost | 一次主程序验证 · MEASURED | 172.7165 | 2030500.0000 | 53629 | — |
| fulminate | — | 插桩、编译与首次执行 | archived_cost | 已测工作总量 · MEASURED | 0.9042 | 42920.0000 | 0 | — |
| fulminate | — | 单独运行测试 | archived_cost | 已测工作总量 · MEASURED | 0.0274 | 1132.0000 | 0 | — |
| tespec | inline | native | current_execution | 7/7 · MEASURED | 0.8211 | 21020 | 0 | 7/7 |
| tespec | inline | auto | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_model | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_coq | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_kernel | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | native | current_execution | 7/7 · MEASURED | 0.8465 | 20908 | 0 | 7/7 |
| tespec | modular | auto | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_model | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_coq | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_kernel | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | layout_prepare | latest_native_matrix | 1/1 · MEASURED | 0.0585 | 17548 | 0 | — |
| tespec | inline | batch_auto | latest_native_matrix | 0/0 · NOT_INVOKED | — | — | 0 | — |
| tespec | inline | native | latest_native_matrix | 7/7 · MEASURED | 0.2131 | 21132 | 0 | 7/7 |
| tespec | inline | auto | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_model | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_coq | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_kernel | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | layout_prepare | latest_native_matrix | 1/1 · MEASURED | 0.0662 | 17712 | 0 | — |
| tespec | modular | batch_auto | latest_native_matrix | 0/0 · NOT_INVOKED | — | — | 0 | — |
| tespec | modular | native | latest_native_matrix | 7/7 · MEASURED | 0.2572 | 20592 | 0 | 7/7 |
| tespec | modular | auto | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_model | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_coq | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_kernel | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
