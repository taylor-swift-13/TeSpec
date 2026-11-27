# list_all 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | ORIGINAL_MODULE_REJECTED |
| qcp | STANDALONE_NATIVE_REJECTED |
| fulminate | 94/94 符合预期 · PASS 94 |

默认 Auto 布局绑定后，92/188 次符合预期。原字段地址未绑定的 65 次中，65 次入口 SAT，51 次整次符合预期。[逐执行结果与成本](tespec/auto-layout.json)

下表的双路线对照保留原 VC；默认 Auto 的成本在阶段表中标记为 default_auto_layout。

本次 Auto 投影复核覆盖此前仍为 UNKNOWN 的输入，PASS 13、UNKNOWN 1。[逐输入 VC、分支和成本](tespec/auto-guards.json)。最终环境复核耗时已包含在 native 阶段。

同名局部变量专项复用原生 VC，再次执行 Auto 得到 PASS 1。[逐输入结果、原始目标与新增成本](tespec/auto-original-roots.json)

最新 Auto 补测的 82 次中，73 次符合预期。[状态、分支与实际成本](tespec/auto-remaining.json)

全量 Auto 符合预期：inline 90/94，modular 89/94。[同一输入的跨工具比较](../paired-tool-comparison.md)。

| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |
|---|---:|---:|---:|---:|---:|
| inline | 8 | 86 | 8 | 78 | 6 |
| modular | 10 | 84 | 6 | 78 | 6 |

以下为旧冻结双路线批次。

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 94 | 21 | 7 | 47 | 47 |
| modular | 94 | 20 | 7 | 47 | 47 |

| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | archived_cost | 一次主程序验证 · MEASURED | 0.0646 | 46108.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | archived_cost | 已测工作总量 · MEASURED | 0.0644 | 11172.0000 | 0 | — |
| qcp | — | agent 填写证明 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | 独立内核检查 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | ITP 平均合计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | vc_generation_and_automatic_processing | standalone_qcp | 1/1 · measured invocations | 0.1165 | 37892 | 0 | — |
| qcp | — | prior_invocations | standalone_qcp | 1/1 · measured invocations | 0.0032 | 1960 | 0 | — |
| fulminate | — | 插桩、编译与首次执行 | archived_cost | 已测工作总量 · MEASURED | 6.0729 | 46648.0000 | 0 | — |
| fulminate | — | 单独运行测试 | archived_cost | 已测工作总量 · PENDING | — | — | 0 | — |
| fulminate | — | locked_original_build | fulminate_compatibility | 94/94 · measured invocations | 13.0025 | 47620 | 0 | — |
| fulminate | — | compatibility_instrument_compile_first_run | fulminate_compatibility | 94/94 · measured invocations | 75.3806 | 49760 | 0 | — |
| fulminate | — | compatibility_execution | fulminate_compatibility | 94/94 · measured invocations | 0.6859 | 1972 | 0 | — |
| fulminate | — | prior_compatibility_build | fulminate_compatibility | 94/94 · measured invocations | 64.2955 | 49780 | 0 | — |
| fulminate | — | prior_compatibility_test | fulminate_compatibility | 94/94 · measured invocations | 0.5691 | 1920 | 0 | — |
| tespec | inline | native | current_execution | 94/94 · MEASURED | 81.5831 | 32020 | 0 | 92/94 |
| tespec | inline | auto | current_execution | 47/47 · MEASURED | 73.5073 | 415440 | 0 | — |
| tespec | inline | itp_model | current_execution | 47/47 · MEASURED | 3652.8680 | 331892.0000 | 1225510 | — |
| tespec | inline | itp_coq | current_execution | 47/47 · MEASURED | 547.7843 | 577200 | 0 | — |
| tespec | inline | itp_kernel | current_execution | 47/47 · MEASURED | 248.8221 | 2042240 | 0 | — |
| tespec | modular | native | current_execution | 94/94 · MEASURED | 15.3603 | 21180 | 0 | 94/94 |
| tespec | modular | auto | current_execution | 47/47 · MEASURED | 60.2749 | 416364 | 0 | — |
| tespec | modular | itp_model | current_execution | 47/47 · MEASURED | 3675.6710 | 332892.0000 | 1114981 | — |
| tespec | modular | itp_coq | current_execution | 47/47 · MEASURED | 518.2437 | 571888 | 0 | — |
| tespec | modular | itp_kernel | current_execution | 47/47 · MEASURED | 264.3344 | 2044264 | 0 | — |
| tespec | inline | layout_prepare | default_auto_layout | 25/25 · MEASURED | 174.7093 | 569472 | 0 | — |
| tespec | inline | layout_check | default_auto_layout | 94/94 · MEASURED | 4.9891 | 18228 | 0 | — |
| tespec | inline | native | default_auto_layout | 94/94 · MEASURED | 87.3616 | 31760 | 0 | 92/94 |
| tespec | inline | auto | default_auto_layout | 47/47 · MEASURED | 31.6253 | 419028 | 0 | — |
| tespec | modular | layout_prepare | default_auto_layout | 25/25 · MEASURED | 175.0244 | 569424 | 0 | — |
| tespec | modular | layout_check | default_auto_layout | 94/94 · MEASURED | 4.7281 | 19548 | 0 | — |
| tespec | modular | native | default_auto_layout | 94/94 · MEASURED | 17.5721 | 21684 | 0 | 94/94 |
| tespec | modular | auto | default_auto_layout | 47/47 · MEASURED | 23.9254 | 419024 | 0 | — |
| tespec | modular | prior_native_attempt | default_auto_layout | 37/37 · MEASURED | 7.3475 | 21644 | 0 | — |
| tespec | inline | guard_prepare | auto_checked_guards | 8/8 · MEASURED | 162.9508 | 569432 | 0 | — |
| tespec | inline | native_including_guard_check | auto_checked_guards | 8/8 · MEASURED | 49.6143 | 569364 | 0 | 8/8 |
| tespec | inline | final_guard_check_subset | auto_checked_guards | 2/2 · MEASURED | 46.8532 | 569364 | 0 | — |
| tespec | inline | auto | auto_checked_guards | 8/8 · MEASURED | 24.9706 | 418928 | 0 | — |
| tespec | modular | guard_prepare | auto_checked_guards | 6/6 · MEASURED | 121.4184 | 569420 | 0 | — |
| tespec | modular | native_including_guard_check | auto_checked_guards | 6/6 · MEASURED | 48.8977 | 569412 | 0 | 6/6 |
| tespec | modular | final_guard_check_subset | auto_checked_guards | 2/2 · MEASURED | 46.8459 | 569412 | 0 | — |
| tespec | modular | auto | auto_checked_guards | 6/6 · MEASURED | 13.2678 | 418880 | 0 | — |
| tespec | inline | auto | auto_original_roots | 2/2 · MEASURED | 50.2273 | 573396 | 0 | — |
| tespec | inline | layout_prepare | timeout_diagnostic_120s | 2/2 · MEASURED | 43.9723 | 569332 | 0 | — |
| tespec | inline | native | timeout_diagnostic_120s | 2/2 · MEASURED | 145.3160 | 35080 | 0 | 2/2 |
| tespec | inline | auto | timeout_diagnostic_120s | 2/2 · MEASURED | 0.9311 | 57176 | 0 | — |
| tespec | inline | layout_prepare | fresh_auto_remaining | 41/41 · MEASURED | 815.4401 | 569564 | 0 | — |
| tespec | inline | native | fresh_auto_remaining | 41/41 · MEASURED | 141.0598 | 568884 | 0 | 39/41 |
| tespec | inline | auto | fresh_auto_remaining | 39/39 · MEASURED | 154.6253 | 569312 | 0 | — |
| tespec | modular | layout_prepare | fresh_auto_remaining | 41/41 · MEASURED | 842.6249 | 569476 | 0 | — |
| tespec | modular | native | fresh_auto_remaining | 41/41 · MEASURED | 68.3837 | 568796 | 0 | 41/41 |
| tespec | modular | auto | fresh_auto_remaining | 37/37 · MEASURED | 31.7911 | 417680 | 0 | — |
| tespec | inline | auto | auto_on_itp_roots | 47/47 · MEASURED | 81.4021 | 415576 | 0 | — |
| tespec | modular | auto | auto_on_itp_roots | 47/47 · MEASURED | 67.0878 | 416348 | 0 | — |
| tespec | inline | layout_prepare | latest_native_matrix | 74/74 · MEASURED | 1353.4477 | 569564 | 0 | — |
| tespec | inline | batch_auto | latest_native_matrix | 69/69 · MEASURED | 194.3876 | 573396 | 0 | — |
| tespec | inline | native | latest_native_matrix | 94/94 · MEASURED | 229.2476 | 569364 | 0 | 92/94 |
| tespec | inline | auto | latest_same_input_and_vc | 86/86 · MEASURED | 277.3045 | 571860 | 0 | — |
| tespec | inline | itp_model | latest_same_input_and_vc | 8/86 · PARTIAL | 1021.4220 | 334032.0000 | 574485 | — |
| tespec | inline | itp_coq | latest_same_input_and_vc | 8/86 · PARTIAL | 232.9901 | 602000 | 0 | — |
| tespec | inline | itp_kernel | latest_same_input_and_vc | 8/86 · PARTIAL | 0 | — | 0 | — |
| tespec | inline | auto | same_input_profile_recheck_a21f363a | 86/86 · MEASURED | 204.1518 | 573296 | 0 | — |
| tespec | inline | auto | same_budget_diagnostic | 1/1 · MEASURED | 53.1394 | 569432 | 0 | — |
| tespec | inline | auto | additional_budget_diagnostic | 3/3 · MEASURED | 215.4773 | 590340 | 0 | — |
| tespec | inline | auto | source_transition_diagnostic | 2/2 · MEASURED | 164.0681 | 590308 | 0 | — |
| tespec | modular | layout_prepare | latest_native_matrix | 71/71 · MEASURED | 1322.9287 | 569476 | 0 | — |
| tespec | modular | batch_auto | latest_native_matrix | 64/64 · MEASURED | 53.2495 | 419116 | 0 | — |
| tespec | modular | native | latest_native_matrix | 94/94 · MEASURED | 155.7496 | 569440 | 0 | 94/94 |
| tespec | modular | auto | latest_same_input_and_vc | 84/84 · MEASURED | 78.0320 | 419020 | 0 | — |
| tespec | modular | itp_model | latest_same_input_and_vc | 6/84 · PARTIAL | 680.3730 | 328232.0000 | 334038 | — |
| tespec | modular | itp_coq | latest_same_input_and_vc | 6/84 · PARTIAL | 169.0966 | 569348 | 0 | — |
| tespec | modular | itp_kernel | latest_same_input_and_vc | 6/84 · PARTIAL | 0 | — | 0 | — |
| tespec | modular | auto | same_input_profile_recheck_a21f363a | 84/84 · MEASURED | 64.6985 | 418916 | 0 | — |
| tespec | modular | auto | same_budget_diagnostic | 1/1 · MEASURED | 8.2876 | 419076 | 0 | — |
| tespec | modular | auto | additional_budget_diagnostic | 2/2 · MEASURED | 17.9785 | 418728 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
