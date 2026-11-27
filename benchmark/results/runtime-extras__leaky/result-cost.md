# runtime-extras__leaky 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | ACCEPTED_TARGETS_TRUSTED |
| qcp | REFUTED_KERNEL_CHECKED |
| fulminate | 7/7 符合预期 · FAIL 7 |

最新 Auto 补测的 1 次中，0 次符合预期。[状态、分支与实际成本](tespec/auto-remaining.json)

全量 Auto 符合预期：inline 7/7，modular 6/7。[同一输入的跨工具比较](../paired-tool-comparison.md)。

| 最新 ITP | 共用原生执行 | 需 ITP | 已测 ITP | 待测 | 全部执行中符合预期 |
|---|---:|---:|---:|---:|---:|
| inline | 0 | 7 | 0 | 7 | 0 |
| modular | 1 | 6 | 0 | 6 | 0 |

以下为旧冻结双路线批次。

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 7 | 7 | 0 | 7 | 7 |
| modular | 7 | 6 | 0 | 6 | 6 |

| 工具 | 策略 | 阶段 | 数据口径 (basis) | 测量覆盖 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | archived_cost | 一次主程序验证 · MEASURED | 0.1147 | 44136.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | archived_cost | 已测工作总量 · MEASURED | 0.0163 | 5580.0000 | 0 | — |
| qcp | — | agent 填写证明 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | 独立内核检查 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | ITP 平均合计 | archived_cost | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | vc_generation_and_automatic_processing | standalone_qcp | 1/1 · measured invocations | 0.0174 | 7436 | 0 | — |
| qcp | — | coq_compilation_and_assumption_audit | standalone_qcp | 3/3 · measured invocations | 6.6245 | 579448 | 0 | — |
| qcp | — | independent_kernel_check | standalone_qcp | 1/1 · measured invocations | 296.8781 | 2058444 | 0 | — |
| qcp | — | prior_invocations | standalone_qcp | 6/6 · measured invocations | 490.8557 | 2059156 | 0 | — |
| fulminate | — | 插桩、编译与首次执行 | archived_cost | 已测工作总量 · MEASURED | 0.8038 | 44456.0000 | 0 | — |
| fulminate | — | 单独运行测试 | archived_cost | 已测工作总量 · MEASURED | 0.0278 | 1404.0000 | 0 | — |
| tespec | inline | native | current_execution | 7/7 · MEASURED | 0.9920 | 21036 | 0 | 7/7 |
| tespec | inline | auto | current_execution | 7/7 · MEASURED | 0.6769 | 55392 | 0 | — |
| tespec | inline | itp_model | current_execution | 7/7 · MEASURED | 838.5010 | 332284.0000 | 267074 | — |
| tespec | inline | itp_coq | current_execution | 7/7 · MEASURED | 69.9206 | 527724 | 0 | — |
| tespec | inline | itp_kernel | current_execution | 7/7 · MEASURED | 0 | — | 0 | — |
| tespec | modular | native | current_execution | 7/7 · MEASURED | 0.9919 | 21064 | 0 | 7/7 |
| tespec | modular | auto | current_execution | 6/6 · MEASURED | 0.5508 | 55352 | 0 | — |
| tespec | modular | itp_model | current_execution | 6/6 · MEASURED | 699.3600 | 332048.0000 | 226100 | — |
| tespec | modular | itp_coq | current_execution | 6/6 · MEASURED | 59.3314 | 527772 | 0 | — |
| tespec | modular | itp_kernel | current_execution | 6/6 · MEASURED | 0 | — | 0 | — |
| tespec | modular | layout_prepare | fresh_auto_remaining | 1/1 · MEASURED | 0.0864 | 17652 | 0 | — |
| tespec | modular | native | fresh_auto_remaining | 1/1 · MEASURED | 0.2503 | 20508 | 0 | 1/1 |
| tespec | inline | auto | auto_on_itp_roots | 7/7 · MEASURED | 0.9391 | 55432 | 0 | — |
| tespec | modular | auto | auto_on_itp_roots | 6/6 · MEASURED | 0.7541 | 55460 | 0 | — |
| tespec | inline | layout_prepare | latest_native_matrix | 2/2 · MEASURED | 0.1178 | 17956 | 0 | — |
| tespec | inline | batch_auto | latest_native_matrix | 2/2 · MEASURED | 0.2860 | 55492 | 0 | — |
| tespec | inline | native | latest_native_matrix | 7/7 · MEASURED | 0.4225 | 21048 | 0 | 7/7 |
| tespec | inline | auto | latest_same_input_and_vc | 7/7 · MEASURED | 1.3209 | 55460 | 0 | — |
| tespec | inline | itp_model | latest_same_input_and_vc | 0/7 · PENDING | — | — | — | — |
| tespec | inline | itp_coq | latest_same_input_and_vc | 0/7 · PENDING | — | — | — | — |
| tespec | inline | itp_kernel | latest_same_input_and_vc | 0/7 · PENDING | — | — | — | — |
| tespec | inline | auto | same_input_profile_recheck_a21f363a | 7/7 · MEASURED | 0.8398 | 55384 | 0 | — |
| tespec | modular | layout_prepare | latest_native_matrix | 2/2 · MEASURED | 0.1473 | 17896 | 0 | — |
| tespec | modular | batch_auto | latest_native_matrix | 1/1 · MEASURED | 0.1499 | 55952 | 0 | — |
| tespec | modular | native | latest_native_matrix | 7/7 · MEASURED | 0.4640 | 20792 | 0 | 7/7 |
| tespec | modular | auto | latest_same_input_and_vc | 6/6 · MEASURED | 1.0100 | 55420 | 0 | — |
| tespec | modular | itp_model | latest_same_input_and_vc | 0/6 · PENDING | — | — | — | — |
| tespec | modular | itp_coq | latest_same_input_and_vc | 0/6 · PENDING | — | — | — | — |
| tespec | modular | itp_kernel | latest_same_input_and_vc | 0/6 · PENDING | — | — | — | — |
| tespec | modular | auto | same_input_profile_recheck_a21f363a | 6/6 · MEASURED | 0.6963 | 55296 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
