# slf18_two_dice 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | ORIGINAL_CN_MODULE_REJECTED |
| qcp | VERIFIED_KERNEL_CHECKED |
| fulminate | 14/14 符合预期 · PASS 14 |

全量 Auto 符合预期：inline 14/14，modular 14/14。[同一输入的跨工具比较](../paired-tool-comparison.md)。

| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |
|---|---:|---:|---:|---:|---:|
| inline | 0 | 14 | 14 | 0 | 4 |
| modular | 2 | 12 | 12 | 0 | 5 |

以下为旧冻结双路线批次。

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 14 | 14 | 0 | 14 | 0 |
| modular | 14 | 14 | 2 | 12 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | archived_cost | 一次主程序验证 · MEASURED | 0.1650 | 44408.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | archived_cost | 已测工作总量 · MEASURED | 0.0329 | 5852.0000 | 0 | — |
| qcp | — | agent 填写证明 | archived_cost | 一次主程序验证 · MEASURED | 73.7030 | 192200.0000 | 140223 | — |
| qcp | — | Coq 编译与假设审计 | archived_cost | 一次主程序验证 · MEASURED | 3.1488 | 587828.0000 | 0 | — |
| qcp | — | 独立内核检查 | archived_cost | 一次主程序验证 · MEASURED | 125.2866 | 1808032.0000 | 0 | — |
| qcp | — | ITP 平均合计 | archived_cost | 一次主程序验证 · MEASURED | 202.1385 | 1808032.0000 | 140223 | — |
| fulminate | — | 插桩、编译与首次执行 | archived_cost | 已测工作总量 · MEASURED | 1.7072 | 44692.0000 | 0 | — |
| fulminate | — | 单独运行测试 | archived_cost | 已测工作总量 · MEASURED | 0.0535 | 1132.0000 | 0 | — |
| tespec | inline | native | current_execution | 14/14 · MEASURED | 2.0703 | 21152 | 0 | 14/14 |
| tespec | inline | auto | current_execution | 14/14 · MEASURED | 1.2477 | 55596 | 0 | — |
| tespec | inline | itp_model | current_execution | 0/14 · PENDING | — | — | — | — |
| tespec | inline | itp_coq | current_execution | 0/14 · PENDING | — | — | — | — |
| tespec | inline | itp_kernel | current_execution | 0/14 · PENDING | — | — | — | — |
| tespec | modular | native | current_execution | 14/14 · MEASURED | 2.0839 | 21052 | 0 | 14/14 |
| tespec | modular | auto | current_execution | 12/12 · MEASURED | 1.0340 | 54784 | 0 | — |
| tespec | modular | itp_model | current_execution | 0/12 · PENDING | — | — | — | — |
| tespec | modular | itp_coq | current_execution | 0/12 · PENDING | — | — | — | — |
| tespec | modular | itp_kernel | current_execution | 0/12 · PENDING | — | — | — | — |
| tespec | inline | auto | auto_on_itp_roots | 14/14 · MEASURED | 1.7960 | 55772 | 0 | — |
| tespec | modular | auto | auto_on_itp_roots | 12/12 · MEASURED | 1.4621 | 54860 | 0 | — |
| tespec | inline | layout_prepare | latest_native_matrix | 4/4 · MEASURED | 0.2520 | 18168 | 0 | — |
| tespec | inline | batch_auto | latest_native_matrix | 4/4 · MEASURED | 0.5181 | 55572 | 0 | — |
| tespec | inline | native | latest_native_matrix | 14/14 · MEASURED | 1.0043 | 21172 | 0 | 14/14 |
| tespec | inline | auto | latest_same_input_and_vc | 14/14 · MEASURED | 2.4951 | 55548 | 0 | — |
| tespec | inline | itp_model | latest_same_input_and_vc | 14/14 · MEASURED | 1725.0930 | 332064.0000 | 574320 | — |
| tespec | inline | itp_coq | latest_same_input_and_vc | 14/14 · MEASURED | 73.6482 | 575564 | 0 | — |
| tespec | inline | itp_kernel | latest_same_input_and_vc | 14/14 · MEASURED | 539.7380 | 2079492 | 0 | — |
| tespec | inline | auto | same_input_profile_recheck_a21f363a | 14/14 · MEASURED | 1.5096 | 55728 | 0 | — |
| tespec | modular | layout_prepare | latest_native_matrix | 4/4 · MEASURED | 0.2764 | 18000 | 0 | — |
| tespec | modular | batch_auto | latest_native_matrix | 2/2 · MEASURED | 0.2781 | 55004 | 0 | — |
| tespec | modular | native | latest_native_matrix | 14/14 · MEASURED | 0.9368 | 20932 | 0 | 14/14 |
| tespec | modular | auto | latest_same_input_and_vc | 12/12 · MEASURED | 1.9652 | 54836 | 0 | — |
| tespec | modular | itp_model | latest_same_input_and_vc | 12/12 · MEASURED | 0 | — | 0 | — |
| tespec | modular | itp_coq | latest_same_input_and_vc | 12/12 · MEASURED | 53.3911 | 572444 | 0 | — |
| tespec | modular | itp_kernel | latest_same_input_and_vc | 12/12 · MEASURED | 433.6574 | 2079692 | 0 | — |
| tespec | modular | auto | same_input_profile_recheck_a21f363a | 12/12 · MEASURED | 1.2925 | 54784 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
