# Dbl_Linked_List__singleton：结果与成本表

完整状态：待补齐。语言版本记录 2 条；主程序：cn_original:Dbl_Linked_List__singleton。

本组尚未完成；已测失败尝试和未运行阶段分别保留，见 [覆盖缺口](coverage-gap.json)。

2026-10-18：CN 5.2 兼容头文件下，原 singleton 与 IntList_nil、IntList_cons 均验证通过；分配器契约仍是外部前提。Fulminate 原有 7 个输入全部 PASS。

teSpec 按用户要求暂缓分配器支持，本轮新增执行 0 次。下表 OFF/ON 各 7 UNKNOWN 为保留的历史结果，不能计为成功；旧统计“需 ITP 7 次”实际是执行在 malloc_node 处中止，没有可提交 ITP 的残余 VC。

QCP 既有 4 个原始全称 VC 证书及成本保持不变；该证书以分配器契约为前提。完整组计数仍为 21/45。修复范围与复现步骤见 docs/benchmark-singleton-cn-fulminate-repair-20261018.md。

| 工具 | 范围 | 结果／预期匹配 | 测试对数 |
|---|---|---|---:|
| cn | 主程序全称验证一次 | VERIFIED_WITH_COMPAT_HEADERS | — |
| qcp | 主程序全称验证一次 | VERIFIED_KERNEL_CHECKED | — |
| fulminate | 各变体的有限测试 | 7/7 | 7 |
| tespec | 各变体的有限测试 | 0/7 | 7 |

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
| tespec | 测试执行、VC 生成与自动处理 | 1.6050 | 19.4648 | 0.0000 | 已测工作总量 |
| tespec | agent 填写证明 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec | Coq 编译与假设审计 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec | 独立内核检查 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec | ITP 平均合计 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec --spatial-smt | 测试执行、VC 生成与空间 SMT | 0.1648 | 19.4157 | 0.0000 | 每次测试执行均值；内存为逐次峰值均值 |
| tespec --spatial-smt | agent 填写证明 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec --spatial-smt | Coq 编译与假设审计 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec --spatial-smt | 独立内核检查 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec --spatial-smt | ITP 平均合计 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| cn | 旧主验证失败（20261016） | 0.1147 | 41.8906 | 0.0000 | 1 次额外尝试总量；不纳入正式输入均值 |
| fulminate | 旧插桩失败（20261016） | 0.5017 | 43.3047 | 0.0000 | 7 次额外尝试总量；不纳入正式输入均值 |
| cn | 旧依赖复查失败 | 0.1149 | 42.1758 | 0.0000 | 1 次额外复查总量；历史记录 |
| fulminate | 旧依赖插桩复查失败 | 0.4519 | 42.9141 | 0.0000 | 7 次额外复查总量；历史记录 |
| tespec | 历史 OFF 缺分配器复查 | 1.5546 | 23.4102 | 0.0000 | 7 次额外复查总量；历史记录 |
| tespec --spatial-smt | 历史 ON 缺分配器复查 | 1.1543 | 23.3320 | 0.0000 | 7 次额外复查总量；历史记录 |
| cn | 兼容修复首轮失败（整数域） | 0.0648 | 45.5859 | 0.0000 | 1 次额外尝试总量；不纳入正式输入均值 |
| fulminate | 链接包装器首轮失败 | 0.1155 | 44.3672 | 0.0000 | 1 次额外尝试总量；不纳入正式输入均值 |
| fulminate | 运行时先导输入成功 | 0.4159 | 44.8477 | 0.0000 | 1 次额外尝试总量；不纳入正式输入均值 |
| fulminate | 负控插桩、编译与首次执行 | 0.3156 | 45.5273 | 0.0000 | 1 次额外尝试总量；不纳入正式输入均值 |
| fulminate | 负控单独执行 | 0.0041 | 1.3789 | 0.0000 | 1 次额外尝试总量；不纳入正式输入均值 |

ITP 以一次测试执行的所有待处理 VC 为单位，只展示平均开销；read 的 12 次所需 ITP 各自独立测量后取平均。内存不将总峰值除以次数；read ITP 展示逐次实测峰值的平均值。ITP 合计行与其三个分项重叠，不能再次相加。CN/QCP 与两种测试工具的对象和次数不同。

缺测记为待补齐，不表示已有历史证据作废；须绑定匹配证据后发布。原始证据、计量来源与缺项见 [result-cost.json](result-cost.json)，成本 CSV 见 [result-cost.csv](result-cost.csv)。

补充的源修订／失败诊断成本单列，见 [补充成本来源](supplementary-costs.json)；不改变主成功测量均值，也不重复计入已统计的 ITP 阶段。

## teSpec 空间 SMT 模式

| 项目 | 关闭 | 开启 |
|---|---:|---:|
| 原生 PASS / FAIL / UNKNOWN / ERROR | 0 / 0 / 7 / 0 | 0 / 0 / 7 / 0 |
| 最终预期匹配（含所需 ITP） | 0/7 | 0/7 |
| 每次执行平均时间（秒） | 0.229285 | 0.164811 |
| 平均单次峰值 RSS（MiB） | 19.4124 | 19.4157 |
| 需 ITP 判定的执行数 | 7 | 7 |

模式逐次结果、成本和证书范围见 [模式对照](20261016-evaluation/comparison.md)。无需 ITP 时成本记 0，均值和峰值不适用。SMT 决策不作为 Coq 证书。
