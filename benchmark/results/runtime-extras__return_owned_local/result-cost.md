# runtime-extras__return_owned_local 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | ACCEPTED_WITH_NEGATIVE_TARGETS_TRUSTED |
| qcp | REFUTED_KERNEL_CHECKED |
| fulminate | 13/13 符合预期 · PASS 6、FAIL 7 |

全量 Auto 符合预期：inline 13/13，modular 13/13。[同一输入的跨工具比较](../paired-tool-comparison.md)。

1 个客户端输入另有内部断言的实际运行记录。[覆盖范围与结果](../fulminate-client-boundaries.json)

另有 1 个变体输入配对进行了合同或故障诊断对照，共享输入按实际调用计费。[补充证据](../fulminate-contract-companions.json)

| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |
|---|---:|---:|---:|---:|---:|
| inline | 6 | 7 | 7 | 0 | 6 |
| modular | 6 | 7 | 7 | 0 | 6 |

以下为旧冻结双路线批次。

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 13 | 13 | 6 | 7 | 3 |
| modular | 13 | 13 | 6 | 7 | 2 |

| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | archived_cost | 一次主程序验证 · MEASURED | 0.1654 | 43244.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | archived_cost | 已测工作总量 · MEASURED | 0.0163 | 5848.0000 | 0 | — |
| qcp | — | agent 填写证明 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | 独立内核检查 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | ITP 平均合计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | vc_generation_and_automatic_processing | standalone_qcp | 1/1 · measured invocations | 0.0258 | 9744 | 0 | — |
| qcp | — | coq_compilation_and_assumption_audit | standalone_qcp | 4/4 · measured invocations | 9.1288 | 580476 | 0 | — |
| qcp | — | independent_kernel_check | standalone_qcp | 1/1 · measured invocations | 296.1986 | 2052608 | 0 | — |
| qcp | — | prior_invocations | standalone_qcp | 7/7 · measured invocations | 496.2528 | 2053940 | 0 | — |
| fulminate | — | 插桩、编译与首次执行 | archived_cost | 已测工作总量 · MEASURED | 1.5423 | 44512.0000 | 0 | — |
| fulminate | — | 单独运行测试 | archived_cost | 已测工作总量 · MEASURED | 0.0518 | 1412.0000 | 0 | — |
| tespec | inline | native | current_execution | 13/13 · MEASURED | 1.8856 | 21160 | 0 | 13/13 |
| tespec | inline | auto | current_execution | 7/7 · MEASURED | 0.7529 | 55564 | 0 | — |
| tespec | inline | itp_model | current_execution | 3/7 · PARTIAL | 339.4820 | 332456.0000 | 110901 | — |
| tespec | inline | itp_coq | current_execution | 3/7 · PARTIAL | 32.6873 | 527668 | 0 | — |
| tespec | inline | itp_kernel | current_execution | 3/7 · PARTIAL | 0 | — | 0 | — |
| tespec | modular | native | current_execution | 13/13 · MEASURED | 1.8235 | 21144 | 0 | 13/13 |
| tespec | modular | auto | current_execution | 7/7 · MEASURED | 0.7426 | 55584 | 0 | — |
| tespec | modular | itp_model | current_execution | 2/7 · PARTIAL | 221.9220 | 163440.0000 | 75174 | — |
| tespec | modular | itp_coq | current_execution | 2/7 · PARTIAL | 23.2484 | 527652 | 0 | — |
| tespec | modular | itp_kernel | current_execution | 2/7 · PARTIAL | 0 | — | 0 | — |
| tespec | inline | auto | auto_on_itp_roots | 7/7 · MEASURED | 1.0522 | 55372 | 0 | — |
| tespec | modular | auto | auto_on_itp_roots | 7/7 · MEASURED | 1.0146 | 55472 | 0 | — |
| fulminate | — | pipeline | supplemental_measured_companion | 1/1 · distinct supplemental inputs | 0.3350 | 45224 | 0 | — |
| fulminate | — | test | supplemental_measured_companion | 1/1 · distinct supplemental inputs | 0.0037 | 1920 | 0 | — |
| fulminate | — | pipeline | supplemental_client_boundaries | 1/1 · explicit internal checks | 0.3249 | 45684 | 0 | — |
| fulminate | — | test | supplemental_client_boundaries | 1/1 · explicit internal checks | 0.0035 | 1920 | 0 | — |
| tespec | inline | layout_prepare | latest_native_matrix | 3/3 · MEASURED | 0.1872 | 18008 | 0 | — |
| tespec | inline | batch_auto | latest_native_matrix | 2/2 · MEASURED | 0.3600 | 56012 | 0 | — |
| tespec | inline | native | latest_native_matrix | 13/13 · MEASURED | 0.5985 | 21056 | 0 | 13/13 |
| tespec | inline | auto | latest_same_input_and_vc | 7/7 · MEASURED | 1.4576 | 55396 | 0 | — |
| tespec | inline | itp_model | latest_same_input_and_vc | 7/7 · MEASURED | 1625.3920 | 333584.0000 | 529030 | — |
| tespec | inline | itp_coq | latest_same_input_and_vc | 7/7 · MEASURED | 91.5447 | 563200 | 0 | — |
| tespec | inline | itp_kernel | latest_same_input_and_vc | 7/7 · MEASURED | 0 | — | 0 | — |
| tespec | inline | auto | same_input_profile_recheck_a21f363a | 7/7 · MEASURED | 0.8810 | 55372 | 0 | — |
| tespec | modular | layout_prepare | latest_native_matrix | 3/3 · MEASURED | 0.1795 | 18132 | 0 | — |
| tespec | modular | batch_auto | latest_native_matrix | 2/2 · MEASURED | 0.3397 | 55988 | 0 | — |
| tespec | modular | native | latest_native_matrix | 13/13 · MEASURED | 0.6075 | 21056 | 0 | 13/13 |
| tespec | modular | auto | latest_same_input_and_vc | 7/7 · MEASURED | 1.2986 | 55592 | 0 | — |
| tespec | modular | itp_model | latest_same_input_and_vc | 7/7 · MEASURED | 237.0930 | 331600.0000 | 80581 | — |
| tespec | modular | itp_coq | latest_same_input_and_vc | 7/7 · MEASURED | 58.2079 | 563388 | 0 | — |
| tespec | modular | itp_kernel | latest_same_input_and_vc | 7/7 · MEASURED | 0 | — | 0 | — |
| tespec | modular | auto | same_input_profile_recheck_a21f363a | 7/7 · MEASURED | 0.8506 | 55592 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
