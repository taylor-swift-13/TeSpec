# mergesort 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | ORIGINAL_MODULE_REJECTED |
| qcp | VC_GENERATED_PROOF_OR_REFUTATION_PENDING |
| fulminate | 0/17 符合预期 · NOT_BUILT 17 |

默认 Auto 布局绑定后，18/34 次符合预期。原字段地址未绑定的 18 次中，18 次入口 SAT，10 次整次符合预期。[逐执行结果与成本](tespec/auto-layout.json)

下表的双路线对照保留原 VC；默认 Auto 的成本在阶段表中标记为 default_auto_layout。

本次 Auto 投影复核覆盖此前仍为 UNKNOWN 的输入，PASS 7、UNKNOWN 1。[逐输入 VC、分支和成本](tespec/auto-guards.json)。最终环境复核耗时已包含在 native 阶段。

同名局部变量专项复用原生 VC，再次执行 Auto 得到 PASS 1。[逐输入结果、原始目标与新增成本](tespec/auto-original-roots.json)

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 17 | 4 | 1 | 12 | 0 |
| modular | 17 | 4 | 1 | 12 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 · MEASURED | 0.0644 | 44824.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 · MEASURED | 0.1148 | 11992.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | 独立内核检查 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 · PENDING | — | — | — | — |
| fulminate | — | 插桩、编译与首次执行 | 已测工作总量 · MEASURED | 1.0968 | 45340.0000 | 0 | — |
| fulminate | — | 单独运行测试 | 0/17 · NOT_BUILT | — | — | 0 | — |
| tespec | inline | native | 17/17 · MEASURED | 2.9912 | 31308 | 0 | 17/17 |
| tespec | inline | auto | 12/12 · MEASURED | 45.2808 | 415476 | 0 | — |
| tespec | inline | itp_model | 0/12 · PENDING | — | — | — | — |
| tespec | inline | itp_coq | 0/12 · PENDING | — | — | — | — |
| tespec | inline | itp_kernel | 0/12 · PENDING | — | — | — | — |
| tespec | modular | native | 17/17 · MEASURED | 2.8588 | 21152 | 0 | 17/17 |
| tespec | modular | auto | 12/12 · MEASURED | 35.6113 | 416188 | 0 | — |
| tespec | modular | itp_model | 0/12 · PENDING | — | — | — | — |
| tespec | modular | itp_coq | 0/12 · PENDING | — | — | — | — |
| tespec | modular | itp_kernel | 0/12 · PENDING | — | — | — | — |
| tespec | inline | layout_prepare | 5/5 · MEASURED | 33.7335 | 569272 | 0 | — |
| tespec | inline | layout_check | 17/17 · MEASURED | 0.9351 | 17944 | 0 | — |
| tespec | inline | native | 17/17 · MEASURED | 4.1507 | 31148 | 0 | 17/17 |
| tespec | inline | auto | 12/12 · MEASURED | 25.0374 | 418916 | 0 | — |
| tespec | modular | layout_prepare | 5/5 · MEASURED | 33.6926 | 569456 | 0 | — |
| tespec | modular | layout_check | 17/17 · MEASURED | 0.8416 | 17908 | 0 | — |
| tespec | modular | native | 17/17 · MEASURED | 3.5382 | 21640 | 0 | 17/17 |
| tespec | modular | auto | 12/12 · MEASURED | 19.1659 | 418824 | 0 | — |
| tespec | modular | prior_native_attempt | 4/4 · MEASURED | 0.9284 | 21460 | 0 | — |
| tespec | inline | guard_prepare | 4/4 · MEASURED | 85.6923 | 569448 | 0 | — |
| tespec | inline | native_including_guard_check | 4/4 · MEASURED | 47.4584 | 569408 | 0 | 4/4 |
| tespec | inline | final_guard_check_subset | 2/2 · MEASURED | 45.7791 | 569408 | 0 | — |
| tespec | inline | auto | 4/4 · MEASURED | 25.7971 | 418880 | 0 | — |
| tespec | modular | guard_prepare | 5/5 · MEASURED | 96.3053 | 569464 | 0 | — |
| tespec | modular | native_including_guard_check | 5/5 · MEASURED | 61.2864 | 569436 | 0 | 5/5 |
| tespec | modular | final_guard_check_subset | 3/3 · MEASURED | 59.5637 | 569436 | 0 | — |
| tespec | modular | auto | 5/5 · MEASURED | 18.4120 | 418912 | 0 | — |
| tespec | inline | auto | 2/2 · MEASURED | 47.6174 | 573420 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
