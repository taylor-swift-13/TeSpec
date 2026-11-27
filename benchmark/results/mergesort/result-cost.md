# mergesort 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | ORIGINAL_MODULE_REJECTED |
| qcp | STANDALONE_NATIVE_REJECTED |
| fulminate | 17/17 符合预期 · PASS 17 |

默认 Auto 布局绑定后，18/34 次符合预期。原字段地址未绑定的 18 次中，18 次入口 SAT，10 次整次符合预期。[逐执行结果与成本](tespec/auto-layout.json)

下表的双路线对照保留原 VC；默认 Auto 的成本在阶段表中标记为 default_auto_layout。

本次 Auto 投影复核覆盖此前仍为 UNKNOWN 的输入，PASS 7、UNKNOWN 1。[逐输入 VC、分支和成本](tespec/auto-guards.json)。最终环境复核耗时已包含在 native 阶段。

同名局部变量专项复用原生 VC，再次执行 Auto 得到 PASS 1。[逐输入结果、原始目标与新增成本](tespec/auto-original-roots.json)

最新 Auto 补测的 8 次中，5 次符合预期。[状态、分支与实际成本](tespec/auto-remaining.json)

全量 Auto 符合预期：inline 15/17，modular 16/17。[同一输入的跨工具比较](../paired-tool-comparison.md)。

| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |
|---|---:|---:|---:|---:|---:|
| inline | 1 | 16 | 16 | 0 | 4 |
| modular | 1 | 16 | 16 | 0 | 4 |

以下为旧冻结双路线批次。

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 17 | 4 | 1 | 12 | 1 |
| modular | 17 | 4 | 1 | 12 | 2 |

| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | archived_cost | 一次主程序验证 · MEASURED | 0.0644 | 44824.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | archived_cost | 已测工作总量 · MEASURED | 0.1148 | 11992.0000 | 0 | — |
| qcp | — | agent 填写证明 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | 独立内核检查 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | ITP 平均合计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | vc_generation_and_automatic_processing | standalone_qcp | 1/1 · measured invocations | 0.0103 | 5108 | 0 | — |
| qcp | — | prior_invocations | standalone_qcp | 1/1 · measured invocations | 0.0033 | 1920 | 0 | — |
| fulminate | — | 插桩、编译与首次执行 | archived_cost | 已测工作总量 · MEASURED | 1.0968 | 45340.0000 | 0 | — |
| fulminate | — | 单独运行测试 | archived_cost | 已测工作总量 · PENDING | — | — | 0 | — |
| fulminate | — | locked_original_build | fulminate_compatibility | 17/17 · measured invocations | 2.2776 | 46236 | 0 | — |
| fulminate | — | compatibility_instrument_compile_first_run | fulminate_compatibility | 17/17 · measured invocations | 7.6508 | 47008 | 0 | — |
| fulminate | — | compatibility_execution | fulminate_compatibility | 17/17 · measured invocations | 0.0949 | 1920 | 0 | — |
| tespec | inline | native | current_execution | 17/17 · MEASURED | 2.9912 | 31308 | 0 | 17/17 |
| tespec | inline | auto | current_execution | 12/12 · MEASURED | 45.2808 | 415476 | 0 | — |
| tespec | inline | itp_model | current_execution | 1/12 · PARTIAL | 57.4530 | 330352.0000 | 20954 | — |
| tespec | inline | itp_coq | current_execution | 1/12 · PARTIAL | 15.5724 | 570932 | 0 | — |
| tespec | inline | itp_kernel | current_execution | 1/12 · PARTIAL | 0 | — | 0 | — |
| tespec | modular | native | current_execution | 17/17 · MEASURED | 2.8588 | 21152 | 0 | 17/17 |
| tespec | modular | auto | current_execution | 12/12 · MEASURED | 35.6113 | 416188 | 0 | — |
| tespec | modular | itp_model | current_execution | 2/12 · PARTIAL | 116.9220 | 327028.0000 | 44067 | — |
| tespec | modular | itp_coq | current_execution | 2/12 · PARTIAL | 24.2984 | 571744 | 0 | — |
| tespec | modular | itp_kernel | current_execution | 2/12 · PARTIAL | 0 | — | 0 | — |
| tespec | inline | layout_prepare | default_auto_layout | 5/5 · MEASURED | 33.7335 | 569272 | 0 | — |
| tespec | inline | layout_check | default_auto_layout | 17/17 · MEASURED | 0.9351 | 17944 | 0 | — |
| tespec | inline | native | default_auto_layout | 17/17 · MEASURED | 4.1507 | 31148 | 0 | 17/17 |
| tespec | inline | auto | default_auto_layout | 12/12 · MEASURED | 25.0374 | 418916 | 0 | — |
| tespec | modular | layout_prepare | default_auto_layout | 5/5 · MEASURED | 33.6926 | 569456 | 0 | — |
| tespec | modular | layout_check | default_auto_layout | 17/17 · MEASURED | 0.8416 | 17908 | 0 | — |
| tespec | modular | native | default_auto_layout | 17/17 · MEASURED | 3.5382 | 21640 | 0 | 17/17 |
| tespec | modular | auto | default_auto_layout | 12/12 · MEASURED | 19.1659 | 418824 | 0 | — |
| tespec | modular | prior_native_attempt | default_auto_layout | 4/4 · MEASURED | 0.9284 | 21460 | 0 | — |
| tespec | inline | guard_prepare | auto_checked_guards | 4/4 · MEASURED | 85.6923 | 569448 | 0 | — |
| tespec | inline | native_including_guard_check | auto_checked_guards | 4/4 · MEASURED | 47.4584 | 569408 | 0 | 4/4 |
| tespec | inline | final_guard_check_subset | auto_checked_guards | 2/2 · MEASURED | 45.7791 | 569408 | 0 | — |
| tespec | inline | auto | auto_checked_guards | 4/4 · MEASURED | 25.7971 | 418880 | 0 | — |
| tespec | modular | guard_prepare | auto_checked_guards | 5/5 · MEASURED | 96.3053 | 569464 | 0 | — |
| tespec | modular | native_including_guard_check | auto_checked_guards | 5/5 · MEASURED | 61.2864 | 569436 | 0 | 5/5 |
| tespec | modular | final_guard_check_subset | auto_checked_guards | 3/3 · MEASURED | 59.5637 | 569436 | 0 | — |
| tespec | modular | auto | auto_checked_guards | 5/5 · MEASURED | 18.4120 | 418912 | 0 | — |
| tespec | inline | auto | auto_original_roots | 2/2 · MEASURED | 47.6174 | 573420 | 0 | — |
| tespec | inline | layout_prepare | fresh_auto_remaining | 4/4 · MEASURED | 74.1660 | 569300 | 0 | — |
| tespec | inline | native | fresh_auto_remaining | 4/4 · MEASURED | 45.2074 | 569176 | 0 | 4/4 |
| tespec | inline | auto | fresh_auto_remaining | 4/4 · MEASURED | 161.4108 | 569176 | 0 | — |
| tespec | modular | layout_prepare | fresh_auto_remaining | 4/4 · MEASURED | 74.9438 | 569304 | 0 | — |
| tespec | modular | native | fresh_auto_remaining | 4/4 · MEASURED | 45.1766 | 569248 | 0 | 4/4 |
| tespec | modular | auto | fresh_auto_remaining | 4/4 · MEASURED | 22.0050 | 417732 | 0 | — |
| tespec | inline | auto | auto_on_itp_roots | 12/12 · MEASURED | 57.4018 | 415512 | 0 | — |
| tespec | modular | auto | auto_on_itp_roots | 12/12 · MEASURED | 45.0556 | 416224 | 0 | — |
| tespec | inline | layout_prepare | latest_native_matrix | 13/13 · MEASURED | 232.2921 | 569480 | 0 | — |
| tespec | inline | batch_auto | latest_native_matrix | 12/12 · MEASURED | 195.1112 | 573396 | 0 | — |
| tespec | inline | native | latest_native_matrix | 17/17 · MEASURED | 126.6980 | 569408 | 0 | 17/17 |
| tespec | inline | auto | latest_same_input_and_vc | 16/16 · MEASURED | 262.2911 | 570012 | 0 | — |
| tespec | inline | itp_model | latest_same_input_and_vc | 16/16 · MEASURED | 1806.1690 | 331992.0000 | 1477076 | — |
| tespec | inline | itp_coq | latest_same_input_and_vc | 16/16 · MEASURED | 490.2180 | 1002584 | 0 | — |
| tespec | inline | itp_kernel | latest_same_input_and_vc | 16/16 · MEASURED | 540.1193 | 2042424 | 0 | — |
| tespec | inline | auto | same_input_profile_recheck_a21f363a | 16/16 · MEASURED | 191.0777 | 573316 | 0 | — |
| tespec | inline | auto | same_budget_diagnostic | 1/1 · MEASURED | 51.1585 | 572088 | 0 | — |
| tespec | inline | auto | additional_budget_diagnostic | 3/3 · MEASURED | 200.4159 | 590124 | 0 | — |
| tespec | inline | auto | source_transition_diagnostic | 2/2 · MEASURED | 167.3037 | 590316 | 0 | — |
| tespec | modular | layout_prepare | latest_native_matrix | 13/13 · MEASURED | 221.9831 | 569464 | 0 | — |
| tespec | modular | batch_auto | latest_native_matrix | 12/12 · MEASURED | 39.4873 | 419060 | 0 | — |
| tespec | modular | native | latest_native_matrix | 17/17 · MEASURED | 115.8076 | 569436 | 0 | 17/17 |
| tespec | modular | auto | latest_same_input_and_vc | 16/16 · MEASURED | 67.2998 | 418872 | 0 | — |
| tespec | modular | itp_model | latest_same_input_and_vc | 16/16 · MEASURED | 1499.6420 | 329736.0000 | 748728 | — |
| tespec | modular | itp_coq | latest_same_input_and_vc | 16/16 · MEASURED | 355.3462 | 571732 | 0 | — |
| tespec | modular | itp_kernel | latest_same_input_and_vc | 16/16 · MEASURED | 569.2703 | 2045204 | 0 | — |
| tespec | modular | auto | same_input_profile_recheck_a21f363a | 16/16 · MEASURED | 53.4050 | 418948 | 0 | — |
| tespec | modular | auto | same_budget_diagnostic | 1/1 · MEASURED | 8.2417 | 418832 | 0 | — |
| tespec | modular | auto | additional_budget_diagnostic | 2/2 · MEASURED | 18.0744 | 419016 | 0 | — |
| tespec | modular | auto | source_transition_diagnostic | 1/1 · MEASURED | 9.9100 | 417480 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
