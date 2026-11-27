# incr 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED |
| qcp | VERIFIED_KERNEL_CHECKED |
| fulminate | 97/103 符合预期 · PASS 34、FAIL 69 |

全量 Auto 符合预期：inline 103/103，modular 103/103。[同一输入的跨工具比较](../paired-tool-comparison.md)。

另有 13 个变体输入配对进行了合同或故障诊断对照，共享输入按实际调用计费。[补充证据](../fulminate-contract-companions.json)

| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |
|---|---:|---:|---:|---:|---:|
| inline | 90 | 13 | 13 | 0 | 90 |
| modular | 90 | 13 | 13 | 0 | 90 |

以下为旧冻结双路线批次。

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 103 | 103 | 90 | 13 | 13 |
| modular | 103 | 103 | 90 | 13 | 13 |

| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | archived_cost | 一次主程序验证 · MEASURED | 0.1149 | 43364.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | archived_cost | 已测工作总量 · MEASURED | 0.0080 | 5036.0000 | 0 | — |
| qcp | — | agent 填写证明 | archived_cost | 一次主程序验证 · MEASURED | 45.1560 | 196352.0000 | 75692 | — |
| qcp | — | Coq 编译与假设审计 | archived_cost | 一次主程序验证 · MEASURED | 2.1223 | 578560.0000 | 0 | — |
| qcp | — | 独立内核检查 | archived_cost | 一次主程序验证 · MEASURED | 140.9171 | 2048052.0000 | 0 | — |
| qcp | — | ITP 平均合计 | archived_cost | 一次主程序验证 · MEASURED | 188.1954 | 2048052.0000 | 75692 | — |
| fulminate | — | 插桩、编译与首次执行 | archived_cost | 已测工作总量 · MEASURED | 11.8205 | 43124.0000 | 0 | — |
| fulminate | — | 单独运行测试 | archived_cost | 已测工作总量 · MEASURED | 0.4099 | 1400.0000 | 0 | — |
| tespec | inline | native | current_execution | 103/103 · MEASURED | 13.4200 | 21184 | 0 | 103/103 |
| tespec | inline | auto | current_execution | 13/13 · MEASURED | 1.2021 | 55412 | 0 | — |
| tespec | inline | itp_model | current_execution | 13/13 · MEASURED | 1292.6720 | 167148.0000 | 984342 | — |
| tespec | inline | itp_coq | current_execution | 13/13 · MEASURED | 258.4407 | 651028 | 0 | — |
| tespec | inline | itp_kernel | current_execution | 13/13 · MEASURED | 3157.3550 | 1878788 | 0 | — |
| tespec | modular | native | current_execution | 103/103 · MEASURED | 13.6030 | 21176 | 0 | 103/103 |
| tespec | modular | auto | current_execution | 13/13 · MEASURED | 1.1993 | 55380 | 0 | — |
| tespec | modular | itp_model | current_execution | 13/13 · MEASURED | 1238.0600 | 165208.0000 | 964205 | — |
| tespec | modular | itp_coq | current_execution | 13/13 · MEASURED | 254.3494 | 650676 | 0 | — |
| tespec | modular | itp_kernel | current_execution | 13/13 · MEASURED | 3161.4307 | 1879160 | 0 | — |
| tespec | inline | auto | auto_on_itp_roots | 13/13 · MEASURED | 1.3324 | 55480 | 0 | — |
| tespec | modular | auto | auto_on_itp_roots | 13/13 · MEASURED | 1.3472 | 55432 | 0 | — |
| tespec | inline | layout_prepare | latest_native_matrix | 18/18 · MEASURED | 1.1112 | 18016 | 0 | — |
| tespec | inline | batch_auto | latest_native_matrix | 2/2 · MEASURED | 0.3298 | 55956 | 0 | — |
| tespec | inline | native | latest_native_matrix | 103/103 · MEASURED | 4.0229 | 21008 | 0 | 103/103 |
| tespec | inline | auto | latest_same_input_and_vc | 13/13 · MEASURED | 1.8715 | 55460 | 0 | — |
| tespec | inline | itp_model | latest_same_input_and_vc | 13/13 · MEASURED | 0 | — | 0 | — |
| tespec | inline | itp_coq | latest_same_input_and_vc | 13/13 · MEASURED | 8.5202 | 563952 | 0 | — |
| tespec | inline | itp_kernel | latest_same_input_and_vc | 13/13 · MEASURED | 0 | — | 0 | — |
| tespec | inline | itp_binding | latest_same_input_and_vc | 13/13 · MEASURED | 8.2699 | 37496 | 0 | — |
| tespec | inline | shared_check | shared_original_check | 13/13 · MEASURED | 3292.1211 | 1878788 | 0 | — |
| tespec | inline | auto | same_input_profile_recheck_a21f363a | 13/13 · MEASURED | 1.5104 | 55396 | 0 | — |
| tespec | modular | layout_prepare | latest_native_matrix | 18/18 · MEASURED | 1.0994 | 17996 | 0 | — |
| tespec | modular | batch_auto | latest_native_matrix | 2/2 · MEASURED | 0.3337 | 55904 | 0 | — |
| tespec | modular | native | latest_native_matrix | 103/103 · MEASURED | 4.0314 | 21168 | 0 | 103/103 |
| tespec | modular | auto | latest_same_input_and_vc | 13/13 · MEASURED | 1.9318 | 55436 | 0 | — |
| tespec | modular | itp_model | latest_same_input_and_vc | 13/13 · MEASURED | 0 | — | 0 | — |
| tespec | modular | itp_coq | latest_same_input_and_vc | 13/13 · MEASURED | 8.3663 | 563828 | 0 | — |
| tespec | modular | itp_kernel | latest_same_input_and_vc | 13/13 · MEASURED | 0 | — | 0 | — |
| tespec | modular | itp_binding | latest_same_input_and_vc | 13/13 · MEASURED | 7.6197 | 37556 | 0 | — |
| tespec | modular | shared_check | shared_original_check | 13/13 · MEASURED | 3294.4303 | 1879160 | 0 | — |
| tespec | modular | auto | same_input_profile_recheck_a21f363a | 13/13 · MEASURED | 1.5635 | 55412 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
