# dll_add 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED_WITH_COMPAT_HEADERS |
| qcp | VERIFIED_KERNEL_CHECKED_WITH_RUNTIME_LIBRARY_ASSUMPTIONS |
| fulminate | {"input_pairs": 24, "PASS": 24} |

全量 Auto 符合预期：inline 12/12，modular 12/12。[同一输入的跨工具比较](../paired-tool-comparison.md)。

| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |
|---|---:|---:|---:|---:|---:|
| inline | 7 | 5 | 5 | 0 | 12 |
| modular | 7 | 5 | 5 | 0 | 12 |

以下为旧冻结双路线批次。

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 12 | 12 | 12 | 5 | 5 |
| modular | 12 | 12 | 12 | 5 | 5 |

| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---|---:|---:|---:|---:|
| cn | — | native | tool_receipt | 1/1 · stage total | 1.2644 | 46260 | 0 | — |
| qcp | — | native | tool_receipt | 3/3 · stage total | 0.5295 | 57068 | 0 | — |
| qcp | — | coq | tool_receipt | 17/17 · stage total | 29.4466 | 634492 | 0 | — |
| qcp | — | agent | tool_receipt | 3/3 · stage total | 603.3910 | 318340.0000 | 423525 | — |
| qcp | — | kernel | tool_receipt | 1/1 · stage total | 132.5572 | 2072964 | 0 | — |
| fulminate | — | pipeline | tool_receipt | 24/24 · stage total | 6.5513 | 47384 | 0 | — |
| fulminate | — | test | tool_receipt | 24/24 · stage total | 0.0659 | 1920 | 0 | — |
| tespec | inline | native | current_execution | 12/12 · MEASURED | 1.9892 | 21128 | 0 | 12/12 |
| tespec | inline | auto | current_execution | 5/5 · MEASURED | 0.6144 | 56028 | 0 | — |
| tespec | inline | itp_model | current_execution | 5/5 · MEASURED | 0 | — | 0 | — |
| tespec | inline | itp_coq | current_execution | 5/5 · MEASURED | 41.4866 | 618372 | 0 | — |
| tespec | inline | itp_kernel | current_execution | 5/5 · MEASURED | 730.2568 | 2050888 | 0 | — |
| tespec | modular | native | current_execution | 12/12 · MEASURED | 1.9763 | 21116 | 0 | 12/12 |
| tespec | modular | auto | current_execution | 5/5 · MEASURED | 0.6176 | 56116 | 0 | — |
| tespec | modular | itp_model | current_execution | 5/5 · MEASURED | 0 | — | 0 | — |
| tespec | modular | itp_coq | current_execution | 5/5 · MEASURED | 41.7892 | 618224 | 0 | — |
| tespec | modular | itp_kernel | current_execution | 5/5 · MEASURED | 729.9885 | 2050548 | 0 | — |
| tespec | inline | auto | auto_on_itp_roots | 5/5 · MEASURED | 0.7736 | 55880 | 0 | — |
| tespec | modular | auto | auto_on_itp_roots | 5/5 · MEASURED | 0.7428 | 55796 | 0 | — |
| tespec | inline | layout_prepare | latest_native_matrix | 1/1 · MEASURED | 0.1247 | 20000 | 0 | — |
| tespec | inline | batch_auto | latest_native_matrix | 1/1 · MEASURED | 0.3286 | 58476 | 0 | — |
| tespec | inline | native | latest_native_matrix | 12/12 · MEASURED | 1.1092 | 21308 | 0 | 12/12 |
| tespec | inline | auto | latest_same_input_and_vc | 5/5 · MEASURED | 1.1019 | 56148 | 0 | — |
| tespec | inline | itp_model | latest_same_input_and_vc | 5/5 · MEASURED | 0 | — | 0 | — |
| tespec | inline | itp_coq | latest_same_input_and_vc | 5/5 · MEASURED | 66.7124 | 618128 | 0 | — |
| tespec | inline | itp_kernel | latest_same_input_and_vc | 5/5 · MEASURED | 1210.5290 | 2052100 | 0 | — |
| tespec | inline | auto | same_input_profile_recheck_a21f363a | 5/5 · MEASURED | 0.8405 | 55724 | 0 | — |
| tespec | modular | layout_prepare | latest_native_matrix | 1/1 · MEASURED | 0.1310 | 19808 | 0 | — |
| tespec | modular | batch_auto | latest_native_matrix | 1/1 · MEASURED | 0.3340 | 58252 | 0 | — |
| tespec | modular | native | latest_native_matrix | 12/12 · MEASURED | 1.0223 | 21668 | 0 | 12/12 |
| tespec | modular | auto | latest_same_input_and_vc | 5/5 · MEASURED | 1.0777 | 55808 | 0 | — |
| tespec | modular | itp_model | latest_same_input_and_vc | 5/5 · MEASURED | 0 | — | 0 | — |
| tespec | modular | itp_coq | latest_same_input_and_vc | 5/5 · MEASURED | 53.1863 | 618280 | 0 | — |
| tespec | modular | itp_kernel | latest_same_input_and_vc | 5/5 · MEASURED | 950.1581 | 2052204 | 0 | — |
| tespec | modular | auto | same_input_profile_recheck_a21f363a | 5/5 · MEASURED | 0.8626 | 56012 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
