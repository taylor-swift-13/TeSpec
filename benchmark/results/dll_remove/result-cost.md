# dll_remove 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED_WITH_COMPAT_HEADERS |
| qcp | VERIFIED_KERNEL_CHECKED_WITH_RUNTIME_LIBRARY_ASSUMPTIONS |
| fulminate | 18/18 符合预期 |

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 9 | 9 | 9 | 9 | 9 |
| modular | 9 | 9 | 9 | 9 | 9 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 · MEASURED | 0.0651 | 43784.0000 | 0 | — |
| cn | — | 主程序验证（当前兼容头文件） | 1/1 · one verification | 2.6839 | 46296 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 · MEASURED | 0.3153 | 9652.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | 独立内核检查 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | 完整原始目标证明（含历史尝试） | charged proof attempts; missing fields unknown · VERIFIED_KERNEL_CHECKED_WITH_RUNTIME_LIBRARY_ASSUMPTIONS | — | — | 738383 | — |
| qcp | — | 当前 QCP 原始目标生成（含全部尝试） | native generation; compare against archived certificate · DIFFERENT_GOAL | 1.4515 | 90604 | 0 | — |
| qcp | — | coq | local replay · KERNEL_REPLAYED | 19.3515 | 695292 | 0 | — |
| qcp | — | kernel | local replay · KERNEL_REPLAYED | 135.3046 | 1737404 | 0 | — |
| fulminate | — | pipeline | 18/18 · stage total | 6.5091 | 46652 | 0 | — |
| fulminate | — | test | 18/18 · stage total | 0.0617 | 1920 | 0 | — |
| fulminate | — | preflight | 2/2 · stage total | 0.0966 | 45588 | 0 | — |
| tespec | inline | native | 9/9 · MEASURED | 1.7214 | 21128 | 0 | 9/9 |
| tespec | inline | auto | 9/9 · MEASURED | 1.1870 | 57388 | 0 | — |
| tespec | inline | itp_model | 9/9 · MEASURED | 0 | — | 0 | — |
| tespec | inline | itp_coq | 9/9 · MEASURED | 66.0267 | 657236 | 0 | — |
| tespec | inline | itp_kernel | 9/9 · MEASURED | 1211.3040 | 2047816 | 0 | — |
| tespec | modular | native | 9/9 · MEASURED | 1.7251 | 21184 | 0 | 9/9 |
| tespec | modular | auto | 9/9 · MEASURED | 1.2041 | 57600 | 0 | — |
| tespec | modular | itp_model | 9/9 · MEASURED | 0 | — | 0 | — |
| tespec | modular | itp_coq | 9/9 · MEASURED | 64.6246 | 657056 | 0 | — |
| tespec | modular | itp_kernel | 9/9 · MEASURED | 1200.6048 | 2047564 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
