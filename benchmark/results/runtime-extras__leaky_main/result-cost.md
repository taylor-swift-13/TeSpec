# runtime-extras__leaky_main 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | ACCEPTED_TARGETS_TRUSTED |
| qcp | REFUTED_KERNEL_CHECKED |
| fulminate | 6/7 符合预期 · PASS 7 |

全量 Auto 符合预期：inline 7/7，modular 7/7。[同一输入的跨工具比较](../paired-tool-comparison.md)。

1 个客户端输入另有内部断言的实际运行记录。[覆盖范围与结果](../fulminate-client-boundaries.json)

另有 1 个变体输入配对进行了合同或故障诊断对照，共享输入按实际调用计费。[补充证据](../fulminate-contract-companions.json)

| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |
|---|---:|---:|---:|---:|---:|
| inline | 6 | 1 | 1 | 0 | 6 |
| modular | 6 | 1 | 1 | 0 | 6 |

以下为旧冻结双路线批次。

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 7 | 7 | 6 | 1 | 1 |
| modular | 7 | 7 | 6 | 1 | 1 |

| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | archived_cost | 一次主程序验证 · MEASURED | 0.1149 | 44268.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | archived_cost | 已测工作总量 · MEASURED | 0.0162 | 5620.0000 | 0 | — |
| qcp | — | agent 填写证明 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | 独立内核检查 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | ITP 平均合计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | vc_generation_and_automatic_processing | standalone_qcp | 1/1 · measured invocations | 0.0237 | 9452 | 0 | — |
| qcp | — | coq_compilation_and_assumption_audit | standalone_qcp | 3/3 · measured invocations | 6.5543 | 580100 | 0 | — |
| qcp | — | independent_kernel_check | standalone_qcp | 1/1 · measured invocations | 294.8449 | 1808300 | 0 | — |
| qcp | — | prior_invocations | standalone_qcp | 6/6 · measured invocations | 490.2777 | 1808108 | 0 | — |
| fulminate | — | 插桩、编译与首次执行 | archived_cost | 已测工作总量 · MEASURED | 0.9043 | 44632.0000 | 0 | — |
| fulminate | — | 单独运行测试 | archived_cost | 已测工作总量 · MEASURED | 0.0282 | 1132.0000 | 0 | — |
| tespec | inline | native | current_execution | 7/7 · MEASURED | 1.0724 | 21084 | 0 | 7/7 |
| tespec | inline | auto | current_execution | 1/1 · MEASURED | 0.0918 | 55308 | 0 | — |
| tespec | inline | itp_model | current_execution | 1/1 · MEASURED | 105.1870 | 166024.0000 | 39183 | — |
| tespec | inline | itp_coq | current_execution | 1/1 · MEASURED | 11.0944 | 527592 | 0 | — |
| tespec | inline | itp_kernel | current_execution | 1/1 · MEASURED | 0 | — | 0 | — |
| tespec | modular | native | current_execution | 7/7 · MEASURED | 1.0426 | 21128 | 0 | 7/7 |
| tespec | modular | auto | current_execution | 1/1 · MEASURED | 0.0864 | 54928 | 0 | — |
| tespec | modular | itp_model | current_execution | 1/1 · MEASURED | 107.1570 | 165664.0000 | 38244 | — |
| tespec | modular | itp_coq | current_execution | 1/1 · MEASURED | 11.2981 | 527736 | 0 | — |
| tespec | modular | itp_kernel | current_execution | 1/1 · MEASURED | 0 | — | 0 | — |
| tespec | inline | auto | auto_on_itp_roots | 1/1 · MEASURED | 0.1238 | 55092 | 0 | — |
| tespec | modular | auto | auto_on_itp_roots | 1/1 · MEASURED | 0.1329 | 54928 | 0 | — |
| fulminate | — | pipeline | supplemental_measured_companion | 1/1 · distinct supplemental inputs | 0.3230 | 44832 | 0 | — |
| fulminate | — | test | supplemental_measured_companion | 1/1 · distinct supplemental inputs | 0.0035 | 1920 | 0 | — |
| fulminate | — | pipeline | supplemental_client_boundaries | 1/1 · explicit internal checks | 0.3246 | 44996 | 0 | — |
| fulminate | — | test | supplemental_client_boundaries | 1/1 · explicit internal checks | 0.0038 | 1920 | 0 | — |
| tespec | inline | layout_prepare | latest_native_matrix | 2/2 · MEASURED | 0.1194 | 18016 | 0 | — |
| tespec | inline | batch_auto | latest_native_matrix | 1/1 · MEASURED | 0.1013 | 54876 | 0 | — |
| tespec | inline | native | latest_native_matrix | 7/7 · MEASURED | 0.4694 | 21108 | 0 | 7/7 |
| tespec | inline | auto | latest_same_input_and_vc | 1/1 · MEASURED | 0.1749 | 54868 | 0 | — |
| tespec | inline | itp_model | latest_same_input_and_vc | 1/1 · MEASURED | 233.9840 | 165012.0000 | 78329 | — |
| tespec | inline | itp_coq | latest_same_input_and_vc | 1/1 · MEASURED | 18.0164 | 527676 | 0 | — |
| tespec | inline | itp_kernel | latest_same_input_and_vc | 1/1 · MEASURED | 0 | — | 0 | — |
| tespec | inline | auto | same_input_profile_recheck_a21f363a | 1/1 · MEASURED | 0.1420 | 55076 | 0 | — |
| tespec | modular | layout_prepare | latest_native_matrix | 2/2 · MEASURED | 0.1149 | 17888 | 0 | — |
| tespec | modular | batch_auto | latest_native_matrix | 1/1 · MEASURED | 0.0984 | 54900 | 0 | — |
| tespec | modular | native | latest_native_matrix | 7/7 · MEASURED | 0.4060 | 20928 | 0 | 7/7 |
| tespec | modular | auto | latest_same_input_and_vc | 1/1 · MEASURED | 0.2309 | 54944 | 0 | — |
| tespec | modular | itp_model | latest_same_input_and_vc | 1/1 · MEASURED | 189.2670 | 165748.0000 | 76723 | — |
| tespec | modular | itp_coq | latest_same_input_and_vc | 1/1 · MEASURED | 15.4954 | 527428 | 0 | — |
| tespec | modular | itp_kernel | latest_same_input_and_vc | 1/1 · MEASURED | 0 | — | 0 | — |
| tespec | modular | auto | same_input_profile_recheck_a21f363a | 1/1 · MEASURED | 0.1172 | 54968 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
