# queue_all 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | ORIGINAL_MODULE_REJECTED |
| qcp | STANDALONE_NATIVE_REJECTED |
| fulminate | 34/34 符合预期 · PASS 34 |

默认 Auto 布局绑定后，38/68 次符合预期。原字段地址未绑定的 10 次中，10 次入口 SAT，10 次整次符合预期。[逐执行结果与成本](tespec/auto-layout.json)

下表的双路线对照保留原 VC；默认 Auto 的成本在阶段表中标记为 default_auto_layout。

最新 Auto 补测的 30 次中，0 次符合预期。[状态、分支与实际成本](tespec/auto-remaining.json)

全量 Auto 符合预期：inline 17/34，modular 21/34。[同一输入的跨工具比较](../paired-tool-comparison.md)。

| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |
|---|---:|---:|---:|---:|---:|
| inline | 23 | 11 | 5 | 6 | 6 |
| modular | 19 | 15 | 3 | 12 | 6 |

以下为旧冻结双路线批次。

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 34 | 12 | 6 | 11 | 2 |
| modular | 34 | 14 | 6 | 15 | 2 |

| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | archived_cost | 一次主程序验证 · MEASURED | 0.0645 | 45800.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | archived_cost | 已测工作总量 · MEASURED | 0.0080 | 5320.0000 | 0 | — |
| qcp | — | agent 填写证明 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | 独立内核检查 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | ITP 平均合计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | vc_generation_and_automatic_processing | standalone_qcp | 1/1 · measured invocations | 0.0075 | 4116 | 0 | — |
| qcp | — | prior_invocations | standalone_qcp | 1/1 · measured invocations | 0.0031 | 1920 | 0 | — |
| fulminate | — | 插桩、编译与首次执行 | archived_cost | 已测工作总量 · MEASURED | 2.1971 | 46008.0000 | 0 | — |
| fulminate | — | 单独运行测试 | archived_cost | 已测工作总量 · PENDING | — | — | 0 | — |
| fulminate | — | locked_original_build | fulminate_compatibility | 34/34 · measured invocations | 4.3895 | 46652 | 0 | — |
| fulminate | — | compatibility_instrument_compile_first_run | fulminate_compatibility | 34/34 · measured invocations | 16.2817 | 47488 | 0 | — |
| fulminate | — | compatibility_execution | fulminate_compatibility | 34/34 · measured invocations | 0.1801 | 1972 | 0 | — |
| tespec | inline | native | current_execution | 34/34 · MEASURED | 126.7643 | 21204 | 0 | 30/34 |
| tespec | inline | auto | current_execution | 11/11 · MEASURED | 1.1781 | 56936 | 0 | — |
| tespec | inline | itp_model | current_execution | 2/11 · PARTIAL | 171.5640 | 329140.0000 | 40554 | — |
| tespec | inline | itp_coq | current_execution | 2/11 · PARTIAL | 12.0651 | 554840 | 0 | — |
| tespec | inline | itp_kernel | current_execution | 2/11 · PARTIAL | 0 | — | 0 | — |
| tespec | modular | native | current_execution | 34/34 · MEASURED | 6.9391 | 21188 | 0 | 34/34 |
| tespec | modular | auto | current_execution | 15/15 · MEASURED | 1.6462 | 56872 | 0 | — |
| tespec | modular | itp_model | current_execution | 2/15 · PARTIAL | 193.7660 | 329452.0000 | 39987 | — |
| tespec | modular | itp_coq | current_execution | 2/15 · PARTIAL | 12.4711 | 554884 | 0 | — |
| tespec | modular | itp_kernel | current_execution | 2/15 · PARTIAL | 0 | — | 0 | — |
| tespec | inline | layout_prepare | default_auto_layout | 10/10 · MEASURED | 53.1148 | 569420 | 0 | — |
| tespec | inline | layout_check | default_auto_layout | 34/34 · MEASURED | 1.7049 | 18184 | 0 | — |
| tespec | inline | native | default_auto_layout | 34/34 · MEASURED | 128.0992 | 21660 | 0 | 30/34 |
| tespec | inline | auto | default_auto_layout | 11/11 · MEASURED | 1.9803 | 59644 | 0 | — |
| tespec | inline | prior_native_attempt | default_auto_layout | 7/7 · MEASURED | 1.6741 | 21572 | 0 | — |
| tespec | modular | layout_prepare | default_auto_layout | 10/10 · MEASURED | 52.9528 | 569244 | 0 | — |
| tespec | modular | layout_check | default_auto_layout | 34/34 · MEASURED | 1.6386 | 18040 | 0 | — |
| tespec | modular | native | default_auto_layout | 34/34 · MEASURED | 8.0984 | 21672 | 0 | 34/34 |
| tespec | modular | auto | default_auto_layout | 15/15 · MEASURED | 3.0927 | 59652 | 0 | — |
| tespec | modular | prior_native_attempt | default_auto_layout | 13/13 · MEASURED | 2.9999 | 21568 | 0 | — |
| tespec | inline | layout_prepare | timeout_diagnostic_120s | 4/4 · MEASURED | 38.5311 | 555008 | 0 | — |
| tespec | inline | native | timeout_diagnostic_120s | 4/4 · MEASURED | 481.3225 | 21224 | 0 | 0/4 |
| tespec | inline | auto | timeout_diagnostic_120s | 0/0 · NOT_REQUIRED | 0 | — | 0 | — |
| tespec | inline | layout_prepare | fresh_auto_remaining | 17/17 · MEASURED | 256.9421 | 569428 | 0 | — |
| tespec | inline | native | fresh_auto_remaining | 17/17 · MEASURED | 132.0616 | 21660 | 0 | 13/17 |
| tespec | modular | layout_prepare | fresh_auto_remaining | 13/13 · MEASURED | 180.2189 | 569424 | 0 | — |
| tespec | modular | native | fresh_auto_remaining | 13/13 · MEASURED | 10.8503 | 21632 | 0 | 13/13 |
| tespec | inline | auto | auto_on_itp_roots | 11/11 · MEASURED | 1.6280 | 56816 | 0 | — |
| tespec | modular | auto | auto_on_itp_roots | 15/15 · MEASURED | 2.2233 | 56828 | 0 | — |
| tespec | inline | layout_prepare | latest_native_matrix | 25/25 · MEASURED | 357.9170 | 569488 | 0 | — |
| tespec | inline | batch_auto | latest_native_matrix | 6/6 · MEASURED | 1.4184 | 60388 | 0 | — |
| tespec | inline | native | latest_native_matrix | 34/34 · MEASURED | 136.5027 | 21660 | 0 | 30/34 |
| tespec | inline | auto | latest_same_input_and_vc | 11/11 · MEASURED | 3.1338 | 59416 | 0 | — |
| tespec | inline | itp_model | latest_same_input_and_vc | 5/11 · PARTIAL | 586.7960 | 331396.0000 | 266619 | — |
| tespec | inline | itp_coq | latest_same_input_and_vc | 5/11 · PARTIAL | 94.9660 | 569404 | 0 | — |
| tespec | inline | itp_kernel | latest_same_input_and_vc | 5/11 · PARTIAL | 0 | — | 0 | — |
| tespec | inline | auto | same_input_profile_recheck_a21f363a | 11/11 · MEASURED | 2.0705 | 59524 | 0 | — |
| tespec | modular | layout_prepare | latest_native_matrix | 22/22 · MEASURED | 294.6575 | 569424 | 0 | — |
| tespec | modular | batch_auto | latest_native_matrix | 7/7 · MEASURED | 1.9802 | 60228 | 0 | — |
| tespec | modular | native | latest_native_matrix | 34/34 · MEASURED | 16.1311 | 21684 | 0 | 34/34 |
| tespec | modular | auto | latest_same_input_and_vc | 15/15 · MEASURED | 4.3808 | 59556 | 0 | — |
| tespec | modular | itp_model | latest_same_input_and_vc | 3/15 · PARTIAL | 346.6720 | 323436.0000 | 152952 | — |
| tespec | modular | itp_coq | latest_same_input_and_vc | 3/15 · PARTIAL | 56.1930 | 569448 | 0 | — |
| tespec | modular | itp_kernel | latest_same_input_and_vc | 3/15 · PARTIAL | 0 | — | 0 | — |
| tespec | modular | auto | same_input_profile_recheck_a21f363a | 15/15 · MEASURED | 3.0738 | 59512 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
