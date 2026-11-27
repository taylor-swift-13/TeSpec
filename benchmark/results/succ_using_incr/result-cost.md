# succ_using_incr 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | ORIGINAL_CN_MODULE_REJECTED |
| qcp | VERIFIED_KERNEL_CHECKED_WITH_RUNTIME_LIBRARY_ASSUMPTIONS |
| fulminate | 19/19 符合预期 · PASS 13、FAIL 6 |

全量 Auto 符合预期：inline 19/19，modular 19/19。[同一输入的跨工具比较](../paired-tool-comparison.md)。

另有 1 个变体输入配对进行了合同或故障诊断对照，共享输入按实际调用计费。[补充证据](../fulminate-contract-companions.json)

| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |
|---|---:|---:|---:|---:|---:|
| inline | 13 | 6 | 6 | 0 | 13 |
| modular | 13 | 6 | 6 | 0 | 13 |

以下为旧冻结双路线批次。

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 19 | 19 | 13 | 6 | 0 |
| modular | 19 | 19 | 13 | 6 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | archived_cost | 一次主程序验证 · MEASURED | 0.2651 | 44468.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | archived_cost | 已测工作总量 · MEASURED | 0.0325 | 6344.0000 | 0 | — |
| qcp | — | agent 填写证明 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | 独立内核检查 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | ITP 平均合计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | vc_generation_and_automatic_processing | standalone_qcp | 1/1 · measured invocations | 0.0455 | 15356 | 0 | — |
| qcp | — | coq_compilation_and_assumption_audit | standalone_qcp | 2/2 · measured invocations | 4.9101 | 575616 | 0 | — |
| qcp | — | independent_kernel_check | standalone_qcp | 1/1 · measured invocations | 297.8651 | 2043024 | 0 | — |
| qcp | — | prior_invocations | standalone_qcp | 5/5 · measured invocations | 606.2921 | 2050924 | 0 | — |
| fulminate | — | 插桩、编译与首次执行 | archived_cost | 已测工作总量 · MEASURED | 2.2811 | 44752.0000 | 0 | — |
| fulminate | — | 单独运行测试 | archived_cost | 已测工作总量 · MEASURED | 0.0735 | 1408.0000 | 0 | — |
| tespec | inline | native | current_execution | 19/19 · MEASURED | 2.7883 | 21124 | 0 | 19/19 |
| tespec | inline | auto | current_execution | 6/6 · MEASURED | 0.6530 | 55692 | 0 | — |
| tespec | inline | itp_model | current_execution | 0/6 · PENDING | — | — | — | — |
| tespec | inline | itp_coq | current_execution | 0/6 · PENDING | — | — | — | — |
| tespec | inline | itp_kernel | current_execution | 0/6 · PENDING | — | — | — | — |
| tespec | modular | native | current_execution | 19/19 · MEASURED | 2.7112 | 21168 | 0 | 19/19 |
| tespec | modular | auto | current_execution | 6/6 · MEASURED | 0.7062 | 55316 | 0 | — |
| tespec | modular | itp_model | current_execution | 0/6 · PENDING | — | — | — | — |
| tespec | modular | itp_coq | current_execution | 0/6 · PENDING | — | — | — | — |
| tespec | modular | itp_kernel | current_execution | 0/6 · PENDING | — | — | — | — |
| tespec | inline | auto | auto_on_itp_roots | 6/6 · MEASURED | 0.8749 | 55820 | 0 | — |
| tespec | modular | auto | auto_on_itp_roots | 6/6 · MEASURED | 0.9886 | 55384 | 0 | — |
| fulminate | — | pipeline | supplemental_measured_companion | 1/1 · distinct supplemental inputs | 0.2985 | 44516 | 0 | — |
| fulminate | — | test | supplemental_measured_companion | 1/1 · distinct supplemental inputs | 0.0038 | 1920 | 0 | — |
| tespec | inline | layout_prepare | latest_native_matrix | 4/4 · MEASURED | 0.2607 | 18124 | 0 | — |
| tespec | inline | batch_auto | latest_native_matrix | 1/1 · MEASURED | 0.1959 | 56392 | 0 | — |
| tespec | inline | native | latest_native_matrix | 19/19 · MEASURED | 0.9835 | 21380 | 0 | 19/19 |
| tespec | inline | auto | latest_same_input_and_vc | 6/6 · MEASURED | 1.1392 | 55716 | 0 | — |
| tespec | inline | itp_model | latest_same_input_and_vc | 6/6 · MEASURED | 1343.9690 | 333892.0000 | 539392 | — |
| tespec | inline | itp_coq | latest_same_input_and_vc | 6/6 · MEASURED | 93.4734 | 563760 | 0 | — |
| tespec | inline | itp_kernel | latest_same_input_and_vc | 6/6 · MEASURED | 0 | — | 0 | — |
| tespec | inline | auto | same_input_profile_recheck_a21f363a | 6/6 · MEASURED | 0.6915 | 55764 | 0 | — |
| tespec | modular | layout_prepare | latest_native_matrix | 4/4 · MEASURED | 0.2219 | 18212 | 0 | — |
| tespec | modular | batch_auto | latest_native_matrix | 1/1 · MEASURED | 0.2955 | 55964 | 0 | — |
| tespec | modular | native | latest_native_matrix | 19/19 · MEASURED | 0.8782 | 20968 | 0 | 19/19 |
| tespec | modular | auto | latest_same_input_and_vc | 6/6 · MEASURED | 1.3493 | 55464 | 0 | — |
| tespec | modular | itp_model | latest_same_input_and_vc | 6/6 · MEASURED | 1333.4830 | 332404.0000 | 491776 | — |
| tespec | modular | itp_coq | latest_same_input_and_vc | 6/6 · MEASURED | 75.8376 | 563432 | 0 | — |
| tespec | modular | itp_kernel | latest_same_input_and_vc | 6/6 · MEASURED | 0 | — | 0 | — |
| tespec | modular | auto | same_input_profile_recheck_a21f363a | 6/6 · MEASURED | 0.7956 | 55476 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
