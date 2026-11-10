# Dbl_Linked_List__singleton：结果与成本表

完整状态：判定已完成，成本仍有缺口；不计入完整组。

7 对原有合法输入，2 条语言记录；inline/modular × 空间 SMT OFF/ON 共 28 次执行。全部入口 SAT 且执行到出口，最终 28/28 符合原有预期。
14 次 inline 原生 UNKNOWN 各自完成全部原始残余 VC 的 ITP、Coq 编译、假设审计与独立完整内核检查；14 次 modular 原生 PASS。
CN 使用已审计兼容头验证主程序；Fulminate 7/7；QCP 原始 4 个全称 VC 的既有内核证据复用。CN/QCP 的分配器契约仍是外部前提。

| 策略 | 空间 SMT | 原生 PASS / UNKNOWN | 最终预期匹配 | 平均原生时间（秒） | 平均峰值 RSS（MiB） |
|---|---|---:|---:|---:|---:|
| inline | off | 0 / 7 | 7/7 | 1.498091 | 20.4782 |
| inline | on | 0 / 7 | 7/7 | 1.618266 | 47.2723 |
| modular | off | 7 / 0 | 7/7 | 1.171326 | 20.4174 |
| modular | on | 7 / 0 | 7/7 | 1.040403 | 20.4794 |

每次执行的全部原始残余 VC 是一个 ITP 任务；下表 ITP 只展示 14 次任务的均值，包含所有失败尝试。实际模型为 `gpt-6.1-sol`。逐执行收据与总量保存在 JSON。
测量环境：共享主机中观测到其他验证任务同时运行；本任务内部串行。这里的时间不适合作为受控跨版本性能比较。
原生 CLI 已包含执行器和空间 SMT，不再加嵌套时间；agent、Coq/假设审计、独立内核是分开的阶段。RSS 是最大进程峰值，均值由逐执行峰值取平均，不累加内存。ITP 合计行与组成行重叠，不可再相加。

| 工具 | 阶段 | 时间（秒） | 峰值进程内存（MiB） | token | 口径 |
|---|---|---:|---:|---:|---|
| cn | 主程序验证 | 0.2657 | 45.9805 | 0.0000 | 一次主程序验证 |
| qcp | VC 生成与自动处理 | 0.0162 | 5.4414 | 0.0000 | 已测工作总量 |
| qcp | agent 填写证明 | 284.0630 | 189.1914 | 591827.0000 | 一次主程序验证 |
| qcp | Coq 编译与假设审计 | 11.9526 | 570.2070 | 0.0000 | 一次主程序验证 |
| qcp | 独立内核检查 | 127.0429 | 1766.8867 | 0.0000 | 一次主程序验证 |
| qcp | ITP 平均合计 | 423.0585 | 1766.8867 | 591827.0000 | 一次主程序验证 |
| fulminate | 插桩、编译与首次执行 | 2.2581 | 45.6875 | 0.0000 | 已测工作总量 |
| fulminate | 单独运行测试 | 0.0252 | 1.1133 | 0.0000 | 已测工作总量 |
| tespec inline spatial-off | 原生测试执行与自动处理 | 1.4981 | 20.4782 | 0.0000 | 每次执行均值；内存为逐次峰值均值 |
| tespec inline spatial-on | 原生测试执行与自动处理 | 1.6183 | 47.2723 | 0.0000 | 每次执行均值；内存为逐次峰值均值 |
| tespec modular spatial-off | 原生测试执行与自动处理 | 1.1713 | 20.4174 | 0.0000 | 每次执行均值；内存为逐次峰值均值 |
| tespec modular spatial-on | 原生测试执行与自动处理 | 1.0404 | 20.4794 | 0.0000 | 每次执行均值；内存为逐次峰值均值 |
| tespec inline ITP | agent 填写证明 | 308.9476 | 228.0446 | 158242.1429 | 14 次独立执行 ITP 的均值；含所有失败尝试；内存为逐执行峰值均值 |
| tespec inline ITP | Coq 编译与假设审计 | 缺失 | 缺失 | 0.0000 | 14 次独立执行 ITP 的均值；含所有失败尝试；内存为逐执行峰值均值 |
| tespec inline ITP | 独立内核检查 | 548.9040 | 缺失 | 0.0000 | 14 次独立执行 ITP 的均值；含所有失败尝试；内存为逐执行峰值均值 |
| tespec inline ITP | ITP 平均合计 | 缺失 | 缺失 | 158242.1429 | 14 次独立执行 ITP 的均值；含所有失败尝试；内存为逐执行峰值均值 |
| tespec group setup | 确定性 ABI 库准备 | 0.4500 | 16.8398 | 0.0000 | 每组一次；不纳入逐执行 ITP 均值 |
| tespec group setup | 文件系统恢复后证书准备 | 5.0100 | 24.0430 | 0.0000 | 每组一次；不纳入逐执行 ITP 均值 |

成本缺口：以下历史失败的时间或 RSS 未完整保留；后续成功重放不能补写，缺项保持 null，已知时间只作为下界。
- execution-00 / attempt-2 / kernel_replay：resources.max_process_rss_kib 缺失，已知 wall=300.0068 秒。
- execution-00 / attempt-3 / kernel_replay：resources.max_process_rss_kib 缺失，已知 wall=300.0106 秒。
- execution-03 / attempt-1-infrastructure-interruption / version：wall_seconds 缺失，已知 wall=缺失 秒。
- execution-03 / attempt-1-infrastructure-interruption / compile_dependencies_LayoutAddress.v：wall_seconds 缺失，已知 wall=缺失 秒。
- execution-03 / attempt-1-infrastructure-interruption / compile_dependencies_GeneratedLayout.v：wall_seconds 缺失，已知 wall=缺失 秒。
- execution-03 / attempt-1-infrastructure-interruption / compile_dependencies_DLLSupplement.v：wall_seconds 缺失，已知 wall=缺失 秒。
- execution-03 / attempt-1-infrastructure-interruption / compile_Goal.v：wall_seconds 缺失，已知 wall=缺失 秒。
- execution-03 / attempt-1-infrastructure-interruption / compile_Candidate.v：wall_seconds 缺失，已知 wall=缺失 秒。
- execution-03 / attempt-1-infrastructure-interruption / compilation_and_assumption_audit：peak_process_rss_kib 缺失，已知 wall=缺失 秒。

证明上下文：当前 teSpec 直接证明显式目标 ABI 下原始左侧 Dll 蕴含及父 VC；旧 QCP 证书仍属于旧抽象地址谓词上下文。两者等价性未获证明，不能将旧 QCP 证书解释成新 ABI 谓词的全称证明。原生费用包含旧、新上下文各一次执行，ITP 费用包含两种上下文所有修复尝试，输入分母不变。

QCP 原始 4 个目标中 1 个 Closed、3 个使用原有 `eval_addr_expr` 参数；没有新增证明公理。测试 ITP 的允许假设、身份检查及完整审计文本逐收据保留。
旧诊断、修复与先导测量保留在 `result-cost.json` 的 `historical_attempts` 与既有 supplementary 文件中。缺失的历史测量保持 null，不记为 0，不增加正式输入分母。

[逐输入与证明引用](evidence/tespec-native.json) · [结果与成本 JSON](result-cost.json) · [成本 CSV](result-cost.csv) · [逐执行 CSV](cases.csv)
