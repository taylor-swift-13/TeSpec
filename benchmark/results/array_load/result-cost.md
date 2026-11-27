# array_load 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED |
| qcp | VERIFIED_KERNEL_CHECKED_WITH_RUNTIME_LIBRARY_ASSUMPTIONS |
| fulminate | 67/67 符合预期 · PASS 67 |

最新 Auto 补测的 1 次中，0 次符合预期。[状态、分支与实际成本](tespec/auto-remaining.json)

全量 Auto 符合预期：inline 67/67，modular 66/67。[同一输入的跨工具比较](../paired-tool-comparison.md)。

| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |
|---|---:|---:|---:|---:|---:|
| inline | 65 | 2 | 0 | 2 | 65 |
| modular | 65 | 2 | 2 | 0 | 66 |

以下为旧冻结双路线批次。

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 67 | 67 | 65 | 2 | 2 |
| modular | 67 | 66 | 66 | 2 | 2 |

| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | archived_cost | 一次主程序验证 · MEASURED | 0.2654 | 46704.0000 | 0 | — |
| cn | — | 历史拒绝与兼容诊断 | archived_cost | 额外9次实际阶段合计；与最终批次分列 · MEASURED | 1.5550 | 52076.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | archived_cost | 已测工作总量 · MEASURED | 0.0161 | 6084.0000 | 0 | — |
| qcp | — | agent 填写证明 | archived_cost | 一次主程序验证 · MEASURED | 56.9530 | 192324.0000 | 96252 | — |
| qcp | — | Coq 编译与假设审计 | archived_cost | 一次主程序验证 · MEASURED | 3.1520 | 584132.0000 | 0 | — |
| qcp | — | 独立内核检查 | archived_cost | 一次主程序验证 · MEASURED | 127.8688 | 2085756.0000 | 0 | — |
| qcp | — | ITP 平均合计 | archived_cost | 一次主程序验证 · MEASURED | 187.9738 | 2085756.0000 | 96252 | — |
| fulminate | — | 插桩、编译与首次执行 | archived_cost | 已测工作总量 · MEASURED | 17.7643 | 45540.0000 | 0 | — |
| fulminate | — | 单独运行测试 | archived_cost | 已测工作总量 · MEASURED | 0.2273 | 1136.0000 | 0 | — |
| fulminate | — | 历史及修复：插桩/编译/首次执行 | archived_cost | 额外201次实际阶段合计；与最终批次分列 · MEASURED | 27.1481 | 46424.0000 | 0 | — |
| fulminate | — | 历史及修复：独立测试 | archived_cost | 额外127次实际阶段合计；与最终批次分列 · MEASURED | 0.4782 | 1136.0000 | 0 | — |
| fulminate | — | CN兼容诊断：插桩/编译/首次执行 | archived_cost | 额外5次实际阶段合计；与最终批次分列 · MEASURED | 1.3253 | 46988.0000 | 0 | — |
| fulminate | — | CN兼容诊断：独立测试 | archived_cost | 额外5次实际阶段合计；与最终批次分列 · MEASURED | 0.0192 | 1200.0000 | 0 | — |
| tespec | inline | native | current_execution | 67/67 · MEASURED | 8.9561 | 21156 | 0 | 67/67 |
| tespec | inline | auto | current_execution | 2/2 · MEASURED | 0.2141 | 56152 | 0 | — |
| tespec | inline | itp_model | current_execution | 2/2 · MEASURED | 110.3450 | 164908.0000 | 95696 | — |
| tespec | inline | itp_coq | current_execution | 2/2 · MEASURED | 14.3284 | 570180 | 0 | — |
| tespec | inline | itp_kernel | current_execution | 2/2 · MEASURED | 0 | — | 0 | — |
| tespec | modular | native | current_execution | 67/67 · MEASURED | 8.9474 | 21184 | 0 | 67/67 |
| tespec | modular | auto | current_execution | 2/2 · MEASURED | 0.3947 | 57816 | 0 | — |
| tespec | modular | itp_model | current_execution | 2/2 · MEASURED | 56.5310 | 162124.0000 | 81560 | — |
| tespec | modular | itp_coq | current_execution | 2/2 · MEASURED | 12.0359 | 564532 | 0 | — |
| tespec | modular | itp_kernel | current_execution | 2/2 · MEASURED | 151.1240 | 1878828 | 0 | — |
| tespec | modular | layout_prepare | fresh_auto_remaining | 1/1 · MEASURED | 0.0631 | 17628 | 0 | — |
| tespec | modular | native | fresh_auto_remaining | 1/1 · MEASURED | 0.2082 | 20836 | 0 | 1/1 |
| tespec | modular | auto | fresh_auto_remaining | 1/1 · MEASURED | 0.3425 | 57892 | 0 | — |
| tespec | inline | auto | auto_on_itp_roots | 2/2 · MEASURED | 0.2308 | 56064 | 0 | — |
| tespec | modular | auto | auto_on_itp_roots | 2/2 · MEASURED | 0.4044 | 57920 | 0 | — |
| tespec | inline | layout_prepare | latest_native_matrix | 17/17 · MEASURED | 1.0849 | 18180 | 0 | — |
| tespec | inline | batch_auto | latest_native_matrix | 2/2 · MEASURED | 0.2301 | 55828 | 0 | — |
| tespec | inline | native | latest_native_matrix | 67/67 · MEASURED | 3.9209 | 21172 | 0 | 67/67 |
| tespec | inline | auto | latest_same_input_and_vc | 2/2 · MEASURED | 0.3697 | 55768 | 0 | — |
| tespec | inline | itp_model | latest_same_input_and_vc | 0/2 · PENDING | — | — | — | — |
| tespec | inline | itp_coq | latest_same_input_and_vc | 0/2 · PENDING | — | — | — | — |
| tespec | inline | itp_kernel | latest_same_input_and_vc | 0/2 · PENDING | — | — | — | — |
| tespec | inline | auto | same_input_profile_recheck_a21f363a | 2/2 · MEASURED | 0.2477 | 56080 | 0 | — |
| tespec | modular | layout_prepare | latest_native_matrix | 17/17 · MEASURED | 1.0538 | 18156 | 0 | — |
| tespec | modular | batch_auto | latest_native_matrix | 2/2 · MEASURED | 0.4521 | 57892 | 0 | — |
| tespec | modular | native | latest_native_matrix | 67/67 · MEASURED | 4.0942 | 21176 | 0 | 67/67 |
| tespec | modular | auto | latest_same_input_and_vc | 2/2 · MEASURED | 0.6539 | 57936 | 0 | — |
| tespec | modular | itp_model | latest_same_input_and_vc | 2/2 · MEASURED | 243.6410 | 328816.0000 | 110264 | — |
| tespec | modular | itp_coq | latest_same_input_and_vc | 2/2 · MEASURED | 21.7664 | 564248 | 0 | — |
| tespec | modular | itp_kernel | latest_same_input_and_vc | 2/2 · MEASURED | 249.8576 | 1874192 | 0 | — |
| tespec | modular | auto | same_input_profile_recheck_a21f363a | 2/2 · MEASURED | 0.4327 | 58140 | 0 | — |
| tespec | modular | auto | source_transition_diagnostic | 1/1 · MEASURED | 0.4447 | 57756 | 0 | — |
| tespec | modular | auto | additional_budget_diagnostic | 1/1 · MEASURED | 0.3871 | 57624 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
