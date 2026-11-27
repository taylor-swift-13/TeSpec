# slf3_basic_inplace_double 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED |
| qcp | VERIFIED_KERNEL_CHECKED |
| fulminate | 52/52 符合预期 · PASS 20、FAIL 32 |

全量 Auto 符合预期：inline 52/52，modular 52/52。[同一输入的跨工具比较](../paired-tool-comparison.md)。

另有 2 个变体输入配对进行了合同或故障诊断对照，共享输入按实际调用计费。[补充证据](../fulminate-contract-companions.json)

| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |
|---|---:|---:|---:|---:|---:|
| inline | 50 | 2 | 2 | 0 | 50 |
| modular | 50 | 2 | 2 | 0 | 50 |

以下为旧冻结双路线批次。

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 52 | 52 | 50 | 2 | 2 |
| modular | 52 | 52 | 50 | 2 | 2 |

| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | archived_cost | 一次主程序验证 · MEASURED | 0.2152 | 43916.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | archived_cost | 已测工作总量 · MEASURED | 0.0081 | 5092.0000 | 0 | — |
| qcp | — | agent 填写证明 | archived_cost | 一次主程序验证 · MEASURED | 34.9690 | 191248.0000 | 55440 | — |
| qcp | — | Coq 编译与假设审计 | archived_cost | 一次主程序验证 · MEASURED | 1.8090 | 579236.0000 | 0 | — |
| qcp | — | 独立内核检查 | archived_cost | 一次主程序验证 · MEASURED | 125.9261 | 2026528.0000 | 0 | — |
| qcp | — | ITP 平均合计 | archived_cost | 一次主程序验证 · MEASURED | 162.7042 | 2026528.0000 | 55440 | — |
| fulminate | — | 插桩、编译与首次执行 | archived_cost | 已测工作总量 · MEASURED | 5.9678 | 44392.0000 | 0 | — |
| fulminate | — | 单独运行测试 | archived_cost | 已测工作总量 · MEASURED | 0.1996 | 1404.0000 | 0 | — |
| tespec | inline | native | current_execution | 52/52 · MEASURED | 8.3591 | 21180 | 0 | 52/52 |
| tespec | inline | auto | current_execution | 2/2 · MEASURED | 0.1807 | 55428 | 0 | — |
| tespec | inline | itp_model | current_execution | 2/2 · MEASURED | 0 | — | 0 | — |
| tespec | inline | itp_coq | current_execution | 2/2 · MEASURED | 18.5444 | 650108 | 0 | — |
| tespec | inline | itp_kernel | current_execution | 2/2 · MEASURED | 476.6048 | 1878996 | 0 | — |
| tespec | modular | native | current_execution | 52/52 · MEASURED | 8.2306 | 21144 | 0 | 52/52 |
| tespec | modular | auto | current_execution | 2/2 · MEASURED | 0.1781 | 55392 | 0 | — |
| tespec | modular | itp_model | current_execution | 2/2 · MEASURED | 0 | — | 0 | — |
| tespec | modular | itp_coq | current_execution | 2/2 · MEASURED | 19.4069 | 650256 | 0 | — |
| tespec | modular | itp_kernel | current_execution | 2/2 · MEASURED | 441.5395 | 1878204 | 0 | — |
| tespec | inline | auto | auto_on_itp_roots | 2/2 · MEASURED | 0.2504 | 55120 | 0 | — |
| tespec | modular | auto | auto_on_itp_roots | 2/2 · MEASURED | 0.2440 | 55276 | 0 | — |
| tespec | inline | layout_prepare | latest_native_matrix | 8/8 · MEASURED | 0.5598 | 17936 | 0 | — |
| tespec | inline | batch_auto | latest_native_matrix | 1/1 · MEASURED | 0.1135 | 55376 | 0 | — |
| tespec | inline | native | latest_native_matrix | 52/52 · MEASURED | 2.1120 | 21132 | 0 | 52/52 |
| tespec | inline | auto | latest_same_input_and_vc | 2/2 · MEASURED | 0.3561 | 55316 | 0 | — |
| tespec | inline | itp_model | latest_same_input_and_vc | 2/2 · MEASURED | 0 | — | 0 | — |
| tespec | inline | itp_coq | latest_same_input_and_vc | 2/2 · MEASURED | 0 | — | 0 | — |
| tespec | inline | itp_kernel | latest_same_input_and_vc | 2/2 · MEASURED | 0 | — | 0 | — |
| tespec | inline | itp_binding | latest_same_input_and_vc | 2/2 · MEASURED | 1.1714 | 37476 | 0 | — |
| tespec | inline | shared_check | shared_original_check | 2/2 · MEASURED | 496.3471 | 1878996 | 0 | — |
| tespec | inline | auto | same_input_profile_recheck_a21f363a | 2/2 · MEASURED | 0.2074 | 55452 | 0 | — |
| tespec | modular | layout_prepare | latest_native_matrix | 8/8 · MEASURED | 0.5842 | 17784 | 0 | — |
| tespec | modular | batch_auto | latest_native_matrix | 1/1 · MEASURED | 0.1336 | 55556 | 0 | — |
| tespec | modular | native | latest_native_matrix | 52/52 · MEASURED | 2.1529 | 21132 | 0 | 52/52 |
| tespec | modular | auto | latest_same_input_and_vc | 2/2 · MEASURED | 0.4020 | 55276 | 0 | — |
| tespec | modular | itp_model | latest_same_input_and_vc | 2/2 · MEASURED | 0 | — | 0 | — |
| tespec | modular | itp_coq | latest_same_input_and_vc | 2/2 · MEASURED | 7.2116 | 649684 | 0 | — |
| tespec | modular | itp_kernel | latest_same_input_and_vc | 2/2 · MEASURED | 169.4811 | 1879484 | 0 | — |
| tespec | modular | itp_binding | latest_same_input_and_vc | 1/1 · MEASURED | 0.4506 | 37600 | 0 | — |
| tespec | modular | shared_check | shared_original_check | 1/1 · MEASURED | 212.3735 | 1878204 | 0 | — |
| tespec | modular | auto | same_input_profile_recheck_a21f363a | 2/2 · MEASURED | 0.2207 | 55372 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
