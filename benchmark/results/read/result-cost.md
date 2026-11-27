# read 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED |
| qcp | VERIFIED_KERNEL_CHECKED |
| fulminate | 60/61 符合预期 · PASS 23、RUNTIME_FAILURE 38 |

全量 Auto 符合预期：inline 61/61，modular 61/61。[同一输入的跨工具比较](../paired-tool-comparison.md)。

另有 8 个变体输入配对进行了合同或故障诊断对照，共享输入按实际调用计费。[补充证据](../fulminate-contract-companions.json)

| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |
|---|---:|---:|---:|---:|---:|
| inline | 49 | 12 | 12 | 0 | 49 |
| modular | 49 | 12 | 12 | 0 | 49 |

以下为旧冻结双路线批次。

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 61 | 61 | 49 | 12 | 12 |
| modular | 61 | 61 | 49 | 12 | 12 |

| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | archived_cost | 一次主程序验证 · MEASURED | 0.0787 | 44060.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | archived_cost | 已测工作总量 · MEASURED | 0.0064 | 4544.0000 | 0 | — |
| qcp | — | agent 填写证明 | archived_cost | 一次主程序验证 · MEASURED | 49.3910 | 193936.0000 | 126128 | — |
| qcp | — | Coq 编译与假设审计 | archived_cost | 一次主程序验证 · MEASURED | 1.6964 | 526940.0000 | 0 | — |
| qcp | — | 独立内核检查 | archived_cost | 一次主程序验证 · MEASURED | 126.6930 | 2043932.0000 | 0 | — |
| qcp | — | ITP 平均合计 | archived_cost | 一次主程序验证 · MEASURED | 177.7804 | 2043932.0000 | 126128 | — |
| fulminate | — | 插桩、编译与首次执行 | archived_cost | 已测工作总量 · MEASURED | 7.0446 | 44280.0000 | 0 | — |
| fulminate | — | 单独运行测试 | archived_cost | 已测工作总量 · MEASURED | 0.2346 | 1400.0000 | 0 | — |
| tespec | inline | native | current_execution | 61/61 · MEASURED | 8.7644 | 21192 | 0 | 61/61 |
| tespec | inline | auto | current_execution | 12/12 · MEASURED | 1.0774 | 55516 | 0 | — |
| tespec | inline | itp_model | current_execution | 12/12 · MEASURED | 1721.5340 | 333040.0000 | 470637 | — |
| tespec | inline | itp_coq | current_execution | 12/12 · MEASURED | 175.8419 | 647800 | 0 | — |
| tespec | inline | itp_kernel | current_execution | 12/12 · MEASURED | 3102.9037 | 1880276 | 0 | — |
| tespec | modular | native | current_execution | 61/61 · MEASURED | 8.6668 | 21180 | 0 | 61/61 |
| tespec | modular | auto | current_execution | 12/12 · MEASURED | 1.0971 | 55512 | 0 | — |
| tespec | modular | itp_model | current_execution | 12/12 · MEASURED | 1862.3250 | 331404.0000 | 484165 | — |
| tespec | modular | itp_coq | current_execution | 12/12 · MEASURED | 177.2114 | 647748 | 0 | — |
| tespec | modular | itp_kernel | current_execution | 12/12 · MEASURED | 3271.2553 | 2096912 | 0 | — |
| tespec | inline | auto | auto_on_itp_roots | 12/12 · MEASURED | 1.5186 | 55492 | 0 | — |
| tespec | modular | auto | auto_on_itp_roots | 12/12 · MEASURED | 1.5855 | 55424 | 0 | — |
| tespec | inline | layout_prepare | latest_native_matrix | 10/10 · MEASURED | 0.6509 | 17996 | 0 | — |
| tespec | inline | batch_auto | latest_native_matrix | 2/2 · MEASURED | 0.3112 | 55800 | 0 | — |
| tespec | inline | native | latest_native_matrix | 61/61 · MEASURED | 2.2956 | 21112 | 0 | 61/61 |
| tespec | inline | auto | latest_same_input_and_vc | 12/12 · MEASURED | 1.9701 | 55428 | 0 | — |
| tespec | inline | itp_model | latest_same_input_and_vc | 12/12 · MEASURED | 0 | — | 0 | — |
| tespec | inline | itp_coq | latest_same_input_and_vc | 12/12 · MEASURED | 20.0891 | 646856 | 0 | — |
| tespec | inline | itp_kernel | latest_same_input_and_vc | 12/12 · MEASURED | 392.4186 | 1877676 | 0 | — |
| tespec | inline | itp_binding | latest_same_input_and_vc | 10/10 · MEASURED | 5.3912 | 39636 | 0 | — |
| tespec | inline | shared_check | shared_original_check | 10/10 · MEASURED | 2071.4414 | 1880276 | 0 | — |
| tespec | inline | auto | same_input_profile_recheck_a21f363a | 12/12 · MEASURED | 1.3789 | 55480 | 0 | — |
| tespec | modular | layout_prepare | latest_native_matrix | 10/10 · MEASURED | 0.6259 | 17984 | 0 | — |
| tespec | modular | batch_auto | latest_native_matrix | 2/2 · MEASURED | 0.3011 | 55616 | 0 | — |
| tespec | modular | native | latest_native_matrix | 61/61 · MEASURED | 2.2674 | 21104 | 0 | 61/61 |
| tespec | modular | auto | latest_same_input_and_vc | 12/12 · MEASURED | 1.9236 | 55432 | 0 | — |
| tespec | modular | itp_model | latest_same_input_and_vc | 12/12 · MEASURED | 0 | — | 0 | — |
| tespec | modular | itp_coq | latest_same_input_and_vc | 12/12 · MEASURED | 12.9259 | 646524 | 0 | — |
| tespec | modular | itp_kernel | latest_same_input_and_vc | 12/12 · MEASURED | 195.5823 | 1877996 | 0 | — |
| tespec | modular | itp_binding | latest_same_input_and_vc | 11/11 · MEASURED | 5.7624 | 39660 | 0 | — |
| tespec | modular | shared_check | shared_original_check | 11/11 · MEASURED | 2332.6941 | 1880036 | 0 | — |
| tespec | modular | auto | same_input_profile_recheck_a21f363a | 12/12 · MEASURED | 1.3862 | 55492 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
