# quadruple 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED |
| qcp | VERIFIED_KERNEL_CHECKED |
| fulminate | 120/120 符合预期 · PASS 46、FAIL 74 |

全量 Auto 符合预期：inline 120/120，modular 120/120。[同一输入的跨工具比较](../paired-tool-comparison.md)。

| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |
|---|---:|---:|---:|---:|---:|
| inline | 120 | 0 | 0 | 0 | 120 |
| modular | 120 | 0 | 0 | 0 | 120 |

以下为旧冻结双路线批次。

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 120 | 120 | 120 | 0 | 0 |
| modular | 120 | 120 | 120 | 0 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | archived_cost | 一次主程序验证 · MEASURED | 0.1148 | 43408.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | archived_cost | 已测工作总量 · MEASURED | 0.0081 | 5060.0000 | 0 | — |
| qcp | — | agent 填写证明 | archived_cost | 一次主程序验证 · MEASURED | 38.2660 | 196152.0000 | 54643 | — |
| qcp | — | Coq 编译与假设审计 | archived_cost | 一次主程序验证 · MEASURED | 1.6100 | 576484.0000 | 0 | — |
| qcp | — | 独立内核检查 | archived_cost | 一次主程序验证 · MEASURED | 132.5395 | 2046032.0000 | 0 | — |
| qcp | — | ITP 平均合计 | archived_cost | 一次主程序验证 · MEASURED | 172.4155 | 2046032.0000 | 54643 | — |
| fulminate | — | 插桩、编译与首次执行 | archived_cost | 已测工作总量 · MEASURED | 13.7739 | 43116.0000 | 0 | — |
| fulminate | — | 单独运行测试 | archived_cost | 已测工作总量 · MEASURED | 0.4789 | 1400.0000 | 0 | — |
| tespec | inline | native | current_execution | 120/120 · MEASURED | 16.8345 | 21196 | 0 | 120/120 |
| tespec | inline | auto | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_model | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_coq | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_kernel | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | native | current_execution | 120/120 · MEASURED | 16.7621 | 21200 | 0 | 120/120 |
| tespec | modular | auto | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_model | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_coq | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_kernel | current_execution | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | layout_prepare | latest_native_matrix | 16/16 · MEASURED | 0.9112 | 18236 | 0 | — |
| tespec | inline | batch_auto | latest_native_matrix | 0/0 · NOT_INVOKED | — | — | 0 | — |
| tespec | inline | native | latest_native_matrix | 120/120 · MEASURED | 3.5176 | 21168 | 0 | 120/120 |
| tespec | inline | auto | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_model | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_coq | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | itp_kernel | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | layout_prepare | latest_native_matrix | 16/16 · MEASURED | 0.9068 | 18232 | 0 | — |
| tespec | modular | batch_auto | latest_native_matrix | 0/0 · NOT_INVOKED | — | — | 0 | — |
| tespec | modular | native | latest_native_matrix | 120/120 · MEASURED | 3.4931 | 21160 | 0 | 120/120 |
| tespec | modular | auto | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_model | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_coq | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | modular | itp_kernel | latest_same_input_and_vc | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
