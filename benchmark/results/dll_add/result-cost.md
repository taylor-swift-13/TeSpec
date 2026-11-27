# dll_add 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED_WITH_COMPAT_HEADERS |
| qcp | VERIFIED_KERNEL_CHECKED_WITH_RUNTIME_LIBRARY_ASSUMPTIONS |
| fulminate | {"input_pairs": 24, "PASS": 24} |

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 12 | 12 | 12 | 5 | 5 |
| modular | 12 | 12 | 12 | 5 | 5 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | native | 1/1 · stage total | 1.2644 | 46260 | 0 | — |
| qcp | — | native | 3/3 · stage total | 0.5295 | 57068 | 0 | — |
| qcp | — | coq | 17/17 · stage total | 29.4466 | 634492 | 0 | — |
| qcp | — | agent | 3/3 · stage total | 603.3910 | 318340.0000 | 423525 | — |
| qcp | — | kernel | 1/1 · stage total | 132.5572 | 2072964 | 0 | — |
| fulminate | — | pipeline | 24/24 · stage total | 6.5513 | 47384 | 0 | — |
| fulminate | — | test | 24/24 · stage total | 0.0659 | 1920 | 0 | — |
| tespec | inline | native | 12/12 · MEASURED | 1.9892 | 21128 | 0 | 12/12 |
| tespec | inline | auto | 5/5 · MEASURED | 0.6144 | 56028 | 0 | — |
| tespec | inline | itp_model | 5/5 · MEASURED | 0 | — | 0 | — |
| tespec | inline | itp_coq | 5/5 · MEASURED | 41.4866 | 618372 | 0 | — |
| tespec | inline | itp_kernel | 5/5 · MEASURED | 730.2568 | 2050888 | 0 | — |
| tespec | modular | native | 12/12 · MEASURED | 1.9763 | 21116 | 0 | 12/12 |
| tespec | modular | auto | 5/5 · MEASURED | 0.6176 | 56116 | 0 | — |
| tespec | modular | itp_model | 5/5 · MEASURED | 0 | — | 0 | — |
| tespec | modular | itp_coq | 5/5 · MEASURED | 41.7892 | 618224 | 0 | — |
| tespec | modular | itp_kernel | 5/5 · MEASURED | 729.9885 | 2050548 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
