# list_all 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | ORIGINAL_MODULE_REJECTED |
| qcp | NATIVE_GENERATION_INCOMPLETE |
| fulminate | 0/94 符合预期 · NOT_BUILT 94 |

默认 Auto 布局绑定后，92/188 次符合预期。原字段地址未绑定的 65 次中，65 次入口 SAT，51 次整次符合预期。[逐执行结果与成本](tespec/auto-layout.json)

下表的双路线对照保留原 VC；默认 Auto 的成本在阶段表中标记为 default_auto_layout。

本次 Auto 投影复核覆盖此前仍为 UNKNOWN 的输入，PASS 13、UNKNOWN 1。[逐输入 VC、分支和成本](tespec/auto-guards.json)。最终环境复核耗时已包含在 native 阶段。

同名局部变量专项复用原生 VC，再次执行 Auto 得到 PASS 1。[逐输入结果、原始目标与新增成本](tespec/auto-original-roots.json)

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 94 | 21 | 6 | 47 | 0 |
| modular | 94 | 20 | 6 | 47 | 0 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 · MEASURED | 0.0646 | 46108.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 · MEASURED | 0.0644 | 11172.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | 独立内核检查 | 一次主程序验证 · PENDING | — | — | — | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 · PENDING | — | — | — | — |
| fulminate | — | 插桩、编译与首次执行 | 已测工作总量 · MEASURED | 6.0729 | 46648.0000 | 0 | — |
| fulminate | — | 单独运行测试 | 0/94 · NOT_BUILT | — | — | 0 | — |
| tespec | inline | native | 94/94 · MEASURED | 81.5831 | 32020 | 0 | 92/94 |
| tespec | inline | auto | 47/47 · MEASURED | 73.5073 | 415440 | 0 | — |
| tespec | inline | itp_model | 0/47 · PENDING | — | — | — | — |
| tespec | inline | itp_coq | 0/47 · PENDING | — | — | — | — |
| tespec | inline | itp_kernel | 0/47 · PENDING | — | — | — | — |
| tespec | modular | native | 94/94 · MEASURED | 15.3603 | 21180 | 0 | 94/94 |
| tespec | modular | auto | 47/47 · MEASURED | 60.2749 | 416364 | 0 | — |
| tespec | modular | itp_model | 0/47 · PENDING | — | — | — | — |
| tespec | modular | itp_coq | 0/47 · PENDING | — | — | — | — |
| tespec | modular | itp_kernel | 0/47 · PENDING | — | — | — | — |
| tespec | inline | layout_prepare | 25/25 · MEASURED | 174.7093 | 569472 | 0 | — |
| tespec | inline | layout_check | 94/94 · MEASURED | 4.9891 | 18228 | 0 | — |
| tespec | inline | native | 94/94 · MEASURED | 87.3616 | 31760 | 0 | 92/94 |
| tespec | inline | auto | 47/47 · MEASURED | 31.6253 | 419028 | 0 | — |
| tespec | modular | layout_prepare | 25/25 · MEASURED | 175.0244 | 569424 | 0 | — |
| tespec | modular | layout_check | 94/94 · MEASURED | 4.7281 | 19548 | 0 | — |
| tespec | modular | native | 94/94 · MEASURED | 17.5721 | 21684 | 0 | 94/94 |
| tespec | modular | auto | 47/47 · MEASURED | 23.9254 | 419024 | 0 | — |
| tespec | modular | prior_native_attempt | 37/37 · MEASURED | 7.3475 | 21644 | 0 | — |
| tespec | inline | guard_prepare | 8/8 · MEASURED | 162.9508 | 569432 | 0 | — |
| tespec | inline | native_including_guard_check | 8/8 · MEASURED | 49.6143 | 569364 | 0 | 8/8 |
| tespec | inline | final_guard_check_subset | 2/2 · MEASURED | 46.8532 | 569364 | 0 | — |
| tespec | inline | auto | 8/8 · MEASURED | 24.9706 | 418928 | 0 | — |
| tespec | modular | guard_prepare | 6/6 · MEASURED | 121.4184 | 569420 | 0 | — |
| tespec | modular | native_including_guard_check | 6/6 · MEASURED | 48.8977 | 569412 | 0 | 6/6 |
| tespec | modular | final_guard_check_subset | 2/2 · MEASURED | 46.8459 | 569412 | 0 | — |
| tespec | modular | auto | 6/6 · MEASURED | 13.2678 | 418880 | 0 | — |
| tespec | inline | auto | 2/2 · MEASURED | 50.2273 | 573396 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
