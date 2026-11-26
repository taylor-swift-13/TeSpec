# array_load 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED |
| qcp | VERIFIED_KERNEL_CHECKED_WITH_RUNTIME_LIBRARY_ASSUMPTIONS |
| fulminate | {"case_pairs": 67, "correct": 67, "native_status_counts": {"PASS": 67}} |

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 67 | 67 | 65 | 2 | 2 |
| modular | 67 | 66 | 66 | 2 | 2 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 | 0.2654 | 46704.0000 | 0 | — |
| cn | — | 历史拒绝与兼容诊断 | 额外9次实际阶段合计；与最终批次分列 | 1.5550 | 52076.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 | 0.0161 | 6084.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 | 56.9530 | 192324.0000 | 96252 | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 | 3.1520 | 584132.0000 | 0 | — |
| qcp | — | 独立内核检查 | 一次主程序验证 | 127.8688 | 2085756.0000 | 0 | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 | 187.9738 | 2085756.0000 | 96252 | — |
| fulminate | — | 插桩、编译与首次执行 | 已测工作总量 | 17.7643 | 45540.0000 | 0 | — |
| fulminate | — | 单独运行测试 | 已测工作总量 | 0.2273 | 1136.0000 | 0 | — |
| fulminate | — | 历史及修复：插桩/编译/首次执行 | 额外201次实际阶段合计；与最终批次分列 | 27.1481 | 46424.0000 | 0 | — |
| fulminate | — | 历史及修复：独立测试 | 额外127次实际阶段合计；与最终批次分列 | 0.4782 | 1136.0000 | 0 | — |
| fulminate | — | CN兼容诊断：插桩/编译/首次执行 | 额外5次实际阶段合计；与最终批次分列 | 1.3253 | 46988.0000 | 0 | — |
| fulminate | — | CN兼容诊断：独立测试 | 额外5次实际阶段合计；与最终批次分列 | 0.0192 | 1200.0000 | 0 | — |
| tespec | inline | native | 67/67 current_execution | 8.9561 | 21156 | 0 | 67/67 |
| tespec | inline | auto | 2/2 current_execution | 0.1839 | 55916 | 0 | — |
| tespec | inline | itp_model | 2/2 current_execution | 110.3450 | 164908.0000 | 95696 | — |
| tespec | inline | itp_coq | 2/2 current_execution | 14.3284 | 570180 | 0 | — |
| tespec | inline | itp_kernel | 2/2 current_execution | 0 | — | 0 | — |
| tespec | modular | native | 67/67 current_execution | 8.9474 | 21184 | 0 | 67/67 |
| tespec | modular | auto | 2/2 current_execution | 0.3460 | 57720 | 0 | — |
| tespec | modular | itp_model | 2/2 current_execution | 56.5310 | 162124.0000 | 81560 | — |
| tespec | modular | itp_coq | 2/2 current_execution | 12.0359 | 564532 | 0 | — |
| tespec | modular | itp_kernel | 2/2 current_execution | 151.1240 | 1878828 | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
