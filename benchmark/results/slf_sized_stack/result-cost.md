# slf_sized_stack 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | ORIGINAL_MODULE_REJECTED |
| qcp | VERIFIED_KERNEL_CHECKED_WITH_RUNTIME_LIBRARY_ASSUMPTIONS |
| fulminate | 47/47 符合预期 · PASS 47 |

默认 Auto 布局绑定后，62/94 次符合预期。原字段地址未绑定的 70 次中，70 次入口 SAT，42 次整次符合预期。[逐执行结果与成本](tespec/auto-layout.json)

下表的双路线对照保留原 VC；默认 Auto 的成本在阶段表中标记为 default_auto_layout。

本次 Auto 投影复核覆盖此前仍为 UNKNOWN 的输入，PASS 28。[逐输入 VC、分支和成本](tespec/auto-guards.json)。最终环境复核耗时已包含在 native 阶段。

最新 Auto 补测的 4 次中，4 次符合预期。[状态、分支与实际成本](tespec/auto-remaining.json)

全量 Auto 符合预期：inline 47/47，modular 47/47。[同一输入的跨工具比较](../paired-tool-comparison.md)。

| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |
|---|---:|---:|---:|---:|---:|
| inline | 3 | 44 | 44 | 0 | 6 |
| modular | 3 | 44 | 44 | 0 | 6 |

以下为旧冻结双路线批次。

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 47 | 10 | 3 | 42 | 0 |
| modular | 47 | 10 | 3 | 42 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | archived_cost | 一次主程序验证 · MEASURED | 0.0646 | 44868.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | archived_cost | 已测工作总量 · MEASURED | 0.0645 | 9076.0000 | 0 | — |
| qcp | — | agent 填写证明 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | 独立内核检查 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | ITP 平均合计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | vc_generation_and_automatic_processing | standalone_qcp | 1/1 · measured invocations | 0.3084 | 42504 | 0 | — |
| qcp | — | coq_compilation_and_assumption_audit | standalone_qcp | 3/3 · measured invocations | 22.0030 | 618992 | 0 | — |
| qcp | — | independent_kernel_check | standalone_qcp | 1/1 · measured invocations | 306.5724 | 2032544 | 0 | — |
| qcp | — | prior_invocations | standalone_qcp | 10/10 · measured invocations | 47.7947 | 571436 | 0 | — |
| fulminate | — | 插桩、编译与首次执行 | archived_cost | 已测工作总量 · MEASURED | 3.0861 | 45128.0000 | 0 | — |
| fulminate | — | 单独运行测试 | archived_cost | 已测工作总量 · PENDING | — | — | 0 | — |
| fulminate | — | locked_original_build | fulminate_compatibility | 47/47 · measured invocations | 4.9152 | 46300 | 0 | — |
| fulminate | — | compatibility_instrument_compile_first_run | fulminate_compatibility | 47/47 · measured invocations | 29.7297 | 46884 | 0 | — |
| fulminate | — | compatibility_execution | fulminate_compatibility | 47/47 · measured invocations | 0.3581 | 1920 | 0 | — |
| fulminate | — | prior_compatibility_build | fulminate_compatibility | 47/47 · measured invocations | 20.2771 | 46860 | 0 | — |
| fulminate | — | prior_compatibility_test | fulminate_compatibility | 47/47 · measured invocations | 0.2565 | 1972 | 0 | — |
| tespec | inline | native | current_execution | 47/47 · MEASURED | 8.3502 | 21132 | 0 | 47/47 |
| tespec | inline | auto | current_execution | 42/42 · MEASURED | 3.9008 | 54584 | 0 | — |
| tespec | inline | itp_model | current_execution | 0/42 · PENDING | — | — | — | — |
| tespec | inline | itp_coq | current_execution | 0/42 · PENDING | — | — | — | — |
| tespec | inline | itp_kernel | current_execution | 0/42 · PENDING | — | — | — | — |
| tespec | modular | native | current_execution | 47/47 · MEASURED | 8.0466 | 21136 | 0 | 47/47 |
| tespec | modular | auto | current_execution | 42/42 · MEASURED | 3.7089 | 54652 | 0 | — |
| tespec | modular | itp_model | current_execution | 0/42 · PENDING | — | — | — | — |
| tespec | modular | itp_coq | current_execution | 0/42 · PENDING | — | — | — | — |
| tespec | modular | itp_kernel | current_execution | 0/42 · PENDING | — | — | — | — |
| tespec | inline | layout_prepare | default_auto_layout | 14/14 · MEASURED | 82.5780 | 569540 | 0 | — |
| tespec | inline | layout_check | default_auto_layout | 47/47 · MEASURED | 2.4903 | 18092 | 0 | — |
| tespec | inline | native | default_auto_layout | 47/47 · MEASURED | 10.1106 | 21616 | 0 | 47/47 |
| tespec | inline | auto | default_auto_layout | 42/42 · MEASURED | 30.9705 | 190732 | 0 | — |
| tespec | modular | layout_prepare | default_auto_layout | 14/14 · MEASURED | 82.3107 | 569456 | 0 | — |
| tespec | modular | layout_check | default_auto_layout | 47/47 · MEASURED | 2.5362 | 19408 | 0 | — |
| tespec | modular | native | default_auto_layout | 47/47 · MEASURED | 9.6756 | 21600 | 0 | 47/47 |
| tespec | modular | auto | default_auto_layout | 42/42 · MEASURED | 17.7809 | 99984 | 0 | — |
| tespec | modular | prior_native_attempt | default_auto_layout | 2/2 · MEASURED | 0.3704 | 21596 | 0 | — |
| tespec | inline | guard_prepare | auto_checked_guards | 16/16 · MEASURED | 266.0106 | 569260 | 0 | — |
| tespec | inline | native_including_guard_check | auto_checked_guards | 16/16 · MEASURED | 4.7635 | 21596 | 0 | 16/16 |
| tespec | inline | auto | auto_checked_guards | 16/16 · MEASURED | 3.4025 | 57400 | 0 | — |
| tespec | modular | guard_prepare | auto_checked_guards | 12/12 · MEASURED | 192.9897 | 569216 | 0 | — |
| tespec | modular | native_including_guard_check | auto_checked_guards | 12/12 · MEASURED | 3.2332 | 21616 | 0 | 12/12 |
| tespec | modular | auto | auto_checked_guards | 12/12 · MEASURED | 2.3752 | 57380 | 0 | — |
| tespec | inline | layout_prepare | fresh_auto_remaining | 2/2 · MEASURED | 35.4685 | 569280 | 0 | — |
| tespec | inline | native | fresh_auto_remaining | 2/2 · MEASURED | 0.6442 | 21380 | 0 | 2/2 |
| tespec | inline | auto | fresh_auto_remaining | 2/2 · MEASURED | 0.4809 | 56676 | 0 | — |
| tespec | modular | layout_prepare | fresh_auto_remaining | 2/2 · MEASURED | 35.4107 | 568988 | 0 | — |
| tespec | modular | native | fresh_auto_remaining | 2/2 · MEASURED | 0.6832 | 21408 | 0 | 2/2 |
| tespec | modular | auto | fresh_auto_remaining | 2/2 · MEASURED | 0.4376 | 56868 | 0 | — |
| tespec | inline | auto | auto_on_itp_roots | 42/42 · MEASURED | 5.6527 | 54720 | 0 | — |
| tespec | modular | auto | auto_on_itp_roots | 42/42 · MEASURED | 5.2832 | 54740 | 0 | — |
| tespec | inline | layout_prepare | latest_native_matrix | 32/32 · MEASURED | 503.6990 | 569472 | 0 | — |
| tespec | inline | batch_auto | latest_native_matrix | 29/29 · MEASURED | 4.6565 | 57820 | 0 | — |
| tespec | inline | native | latest_native_matrix | 47/47 · MEASURED | 9.7023 | 21708 | 0 | 47/47 |
| tespec | inline | auto | latest_same_input_and_vc | 44/44 · MEASURED | 9.6069 | 57376 | 0 | — |
| tespec | inline | itp_model | latest_same_input_and_vc | 44/44 · MEASURED | 5073.9270 | 334536.0000 | 2234158 | — |
| tespec | inline | itp_coq | latest_same_input_and_vc | 44/44 · MEASURED | 742.6848 | 569532 | 0 | — |
| tespec | inline | itp_kernel | latest_same_input_and_vc | 44/44 · MEASURED | 465.6438 | 2017524 | 0 | — |
| tespec | inline | auto | same_input_profile_recheck_a21f363a | 44/44 · MEASURED | 6.4813 | 57600 | 0 | — |
| tespec | modular | layout_prepare | latest_native_matrix | 28/28 · MEASURED | 429.6763 | 569380 | 0 | — |
| tespec | modular | batch_auto | latest_native_matrix | 25/25 · MEASURED | 4.1856 | 57928 | 0 | — |
| tespec | modular | native | latest_native_matrix | 47/47 · MEASURED | 8.3863 | 21668 | 0 | 47/47 |
| tespec | modular | auto | latest_same_input_and_vc | 44/44 · MEASURED | 9.8702 | 57248 | 0 | — |
| tespec | modular | itp_model | latest_same_input_and_vc | 44/44 · MEASURED | 4703.1160 | 334332.0000 | 2102814 | — |
| tespec | modular | itp_coq | latest_same_input_and_vc | 44/44 · MEASURED | 743.3128 | 569540 | 0 | — |
| tespec | modular | itp_kernel | latest_same_input_and_vc | 44/44 · MEASURED | 441.8071 | 2017648 | 0 | — |
| tespec | modular | auto | same_input_profile_recheck_a21f363a | 44/44 · MEASURED | 6.4951 | 57296 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
