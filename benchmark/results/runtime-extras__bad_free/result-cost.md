# runtime-extras__bad_free 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | ACCEPTED_TARGETS_TRUSTED |
| qcp | STANDALONE_NATIVE_REJECTED |
| fulminate | 8/8 符合预期 · FAIL 7、PASS 1 |

全量 Auto 符合预期：inline 8/8，modular 8/8。[同一输入的跨工具比较](../paired-tool-comparison.md)。

| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |
|---|---:|---:|---:|---:|---:|
| inline | 7 | 1 | 1 | 0 | 7 |
| modular | 7 | 1 | 1 | 0 | 7 |

以下为旧冻结双路线批次。

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 8 | 8 | 7 | 1 | 1 |
| modular | 8 | 8 | 7 | 1 | 1 |

| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | archived_cost | 一次主程序验证 · MEASURED | 0.1147 | 44036.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | archived_cost | 已测工作总量 · MEASURED | 0.0080 | 5016.0000 | 0 | — |
| qcp | — | agent 填写证明 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | 独立内核检查 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | ITP 平均合计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | vc_generation_and_automatic_processing | standalone_qcp | 1/1 · measured invocations | 0.0080 | 4852 | 0 | — |
| qcp | — | prior_invocations | standalone_qcp | 1/1 · measured invocations | 0.0032 | 1920 | 0 | — |
| fulminate | — | 插桩、编译与首次执行 | archived_cost | 已测工作总量 · MEASURED | 0.9176 | 44212.0000 | 0 | — |
| fulminate | — | 单独运行测试 | archived_cost | 已测工作总量 · MEASURED | 0.0311 | 1400.0000 | 0 | — |
| tespec | inline | native | current_execution | 8/8 · MEASURED | 1.1810 | 21116 | 0 | 8/8 |
| tespec | inline | auto | current_execution | 1/1 · MEASURED | 0.1027 | 55604 | 0 | — |
| tespec | inline | itp_model | current_execution | 1/1 · MEASURED | 161.3130 | 331732.0000 | 39968 | — |
| tespec | inline | itp_coq | current_execution | 1/1 · MEASURED | 6.8206 | 527616 | 0 | — |
| tespec | inline | itp_kernel | current_execution | 1/1 · MEASURED | 0 | — | 0 | — |
| tespec | modular | native | current_execution | 8/8 · MEASURED | 1.1263 | 21116 | 0 | 8/8 |
| tespec | modular | auto | current_execution | 1/1 · MEASURED | 0.0882 | 55012 | 0 | — |
| tespec | modular | itp_model | current_execution | 1/1 · MEASURED | 122.8600 | 330996.0000 | 38036 | — |
| tespec | modular | itp_coq | current_execution | 1/1 · MEASURED | 7.8766 | 527464 | 0 | — |
| tespec | modular | itp_kernel | current_execution | 1/1 · MEASURED | 0 | — | 0 | — |
| tespec | inline | auto | auto_on_itp_roots | 1/1 · MEASURED | 0.1400 | 55708 | 0 | — |
| tespec | modular | auto | auto_on_itp_roots | 1/1 · MEASURED | 0.1311 | 54916 | 0 | — |
| tespec | inline | layout_prepare | latest_native_matrix | 3/3 · MEASURED | 0.2006 | 17872 | 0 | — |
| tespec | inline | batch_auto | latest_native_matrix | 1/1 · MEASURED | 0.1125 | 55404 | 0 | — |
| tespec | inline | native | latest_native_matrix | 8/8 · MEASURED | 0.5744 | 20900 | 0 | 8/8 |
| tespec | inline | auto | latest_same_input_and_vc | 1/1 · MEASURED | 0.1832 | 55640 | 0 | — |
| tespec | inline | itp_model | latest_same_input_and_vc | 1/1 · MEASURED | 225.4210 | 332876.0000 | 80571 | — |
| tespec | inline | itp_coq | latest_same_input_and_vc | 1/1 · MEASURED | 542.9442 | 11466236 | 0 | — |
| tespec | inline | itp_kernel | latest_same_input_and_vc | 1/1 · MEASURED | 0 | — | 0 | — |
| tespec | inline | candidate_precheck | current_resource_recheck_subset | 2/2 · MEASURED | 0.1302 | 17004 | 0 | — |
| tespec | inline | version | current_resource_recheck_subset | 2/2 · MEASURED | 0.4308 | 31320 | 0 | — |
| tespec | inline | compile_Goal.v | current_resource_recheck_subset | 2/2 · MEASURED | 2.4878 | 526404 | 0 | — |
| tespec | inline | compile_Candidate.v | current_resource_recheck_subset | 2/2 · MEASURED | 148.3405 | 3966792 | 0 | — |
| tespec | inline | auto | same_input_profile_recheck_a21f363a | 1/1 · MEASURED | 0.1391 | 55464 | 0 | — |
| tespec | modular | layout_prepare | latest_native_matrix | 3/3 · MEASURED | 0.1860 | 17760 | 0 | — |
| tespec | modular | batch_auto | latest_native_matrix | 1/1 · MEASURED | 0.1008 | 55092 | 0 | — |
| tespec | modular | native | latest_native_matrix | 8/8 · MEASURED | 0.5855 | 21092 | 0 | 8/8 |
| tespec | modular | auto | latest_same_input_and_vc | 1/1 · MEASURED | 0.1924 | 54912 | 0 | — |
| tespec | modular | itp_model | latest_same_input_and_vc | 1/1 · MEASURED | 218.7500 | 332824.0000 | 75829 | — |
| tespec | modular | itp_coq | latest_same_input_and_vc | 1/1 · MEASURED | 15.6084 | 527624 | 0 | — |
| tespec | modular | itp_kernel | latest_same_input_and_vc | 1/1 · MEASURED | 0 | — | 0 | — |
| tespec | modular | auto | same_input_profile_recheck_a21f363a | 1/1 · MEASURED | 0.1085 | 55012 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
