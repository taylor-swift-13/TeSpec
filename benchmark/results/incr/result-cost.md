# incr 评测结果与成本

| 工具 | 结果或覆盖 |
|---|---|
| cn | VERIFIED |
| qcp | VERIFIED_KERNEL_CHECKED |
| fulminate | 97/103 符合预期 · PASS 34、FAIL 69 |

| 策略 | 执行数 | Auto 符合预期 | ITP 符合预期（含原生） | 需要 ITP | 已有本轮回执 |
|---|---:|---:|---:|---:|---:|
| inline | 103 | 103 | 90 | 13 | 3 |
| modular | 103 | 103 | 90 | 13 | 2 |

| 工具 | 策略 | 阶段 | 数据口径 | 耗时 s | 单进程峰值 KiB¹ | token | 分支计数覆盖 |
|---|---|---|---|---:|---:|---:|---:|
| cn | — | 主程序验证 | 一次主程序验证 · MEASURED | 0.1149 | 43364.0000 | 0 | — |
| qcp | — | VC 生成与自动处理 | 已测工作总量 · MEASURED | 0.0080 | 5036.0000 | 0 | — |
| qcp | — | agent 填写证明 | 一次主程序验证 · MEASURED | 45.1560 | 196352.0000 | 75692 | — |
| qcp | — | Coq 编译与假设审计 | 一次主程序验证 · MEASURED | 2.1223 | 578560.0000 | 0 | — |
| qcp | — | 独立内核检查 | 一次主程序验证 · MEASURED | 140.9171 | 2048052.0000 | 0 | — |
| qcp | — | ITP 平均合计 | 一次主程序验证 · MEASURED | 188.1954 | 2048052.0000 | 75692 | — |
| fulminate | — | 插桩、编译与首次执行 | 已测工作总量 · MEASURED | 11.8205 | 43124.0000 | 0 | — |
| fulminate | — | 单独运行测试 | 已测工作总量 · MEASURED | 0.4099 | 1400.0000 | 0 | — |
| tespec | inline | native | 103/103 · MEASURED | 13.4200 | 21184 | 0 | 103/103 |
| tespec | inline | auto | 13/13 · MEASURED | 1.1903 | 55348 | 0 | — |
| tespec | inline | itp_model | 3/13 · PARTIAL | 350.7500 | 163700.0000 | 232216 | — |
| tespec | inline | itp_coq | 3/13 · PARTIAL | 34.2724 | 527740 | 0 | — |
| tespec | inline | itp_kernel | 3/13 · PARTIAL | 0 | — | 0 | — |
| tespec | modular | native | 103/103 · MEASURED | 13.6030 | 21176 | 0 | 103/103 |
| tespec | modular | auto | 13/13 · MEASURED | 1.1859 | 55432 | 0 | — |
| tespec | modular | itp_model | 2/13 · PARTIAL | 174.7500 | 163624.0000 | 152443 | — |
| tespec | modular | itp_coq | 2/13 · PARTIAL | 22.0418 | 527612 | 0 | — |
| tespec | modular | itp_kernel | 2/13 · PARTIAL | 0 | — | 0 | — |

¹ 历史成本保留原始单位口径，包括执行峰值的均值。当前阶段显示已测部分的合计耗时及最大单进程峰值。

[逐阶段成本与分支计数](result-cost.csv) · [结构化结果与证据引用](result-cost.json) · [逐执行记录](tespec/current-executions.json)
