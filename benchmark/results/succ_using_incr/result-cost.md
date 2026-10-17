# succ_using_incr：结果与成本表

完整状态：待补齐。语言版本记录 7 条；主程序：cn_original:slf16_basic_succ_using_incr。

本组尚未完成；已测失败尝试和未运行阶段分别保留，见 [覆盖缺口](coverage-gap.json)。

| 工具 | 范围 | 结果／预期匹配 | 测试对数 |
|---|---|---|---:|
| cn | 主程序全称验证一次 | ORIGINAL_CN_MODULE_REJECTED | — |
| qcp | 主程序全称验证一次 | VC_GENERATED_PROOF_PENDING | — |
| fulminate | 各变体的有限测试 | 19/19 | 19 |
| tespec | 各变体的有限测试 | 1/19 | 19 |

| 工具 | 阶段 | 时间（秒） | 峰值进程内存（MiB） | token | 口径 |
|---|---|---:|---:|---:|---|
| cn | 主程序验证 | 0.2651 | 43.4258 | 0.0000 | 一次主程序验证 |
| qcp | VC 生成与自动处理 | 0.0325 | 6.1953 | 0.0000 | 已测工作总量 |
| qcp | agent 填写证明 | 待补齐 | 待补齐 | 待补齐 | 一次主程序验证 |
| qcp | Coq 编译与假设审计 | 待补齐 | 待补齐 | 待补齐 | 一次主程序验证 |
| qcp | 独立内核检查 | 待补齐 | 待补齐 | 待补齐 | 一次主程序验证 |
| qcp | ITP 平均合计 | 待补齐 | 待补齐 | 待补齐 | 一次主程序验证 |
| fulminate | 插桩、编译与首次执行 | 2.2811 | 43.7031 | 0.0000 | 已测工作总量 |
| fulminate | 单独运行测试 | 0.0735 | 1.3750 | 0.0000 | 已测工作总量 |
| tespec | 测试执行、VC 生成与自动处理 | 3.5331 | 19.4648 | 0.0000 | 已测工作总量 |
| tespec | agent 填写证明 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec | Coq 编译与假设审计 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec | 独立内核检查 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec | ITP 平均合计 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec --spatial-smt | 测试执行、VC 生成与空间 SMT | 0.1649 | 19.4143 | 0.0000 | 每次测试执行均值；内存为逐次峰值均值 |
| tespec --spatial-smt | agent 填写证明 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec --spatial-smt | Coq 编译与假设审计 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec --spatial-smt | 独立内核检查 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec --spatial-smt | ITP 平均合计 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |

ITP 以一次测试执行的所有待处理 VC 为单位，只展示平均开销；read 的 12 次所需 ITP 各自独立测量后取平均。内存不将总峰值除以次数；read ITP 展示逐次实测峰值的平均值。ITP 合计行与其三个分项重叠，不能再次相加。CN/QCP 与两种测试工具的对象和次数不同。

缺测记为待补齐，不表示已有历史证据作废；须绑定匹配证据后发布。原始证据、计量来源与缺项见 [result-cost.json](result-cost.json)，成本 CSV 见 [result-cost.csv](result-cost.csv)。

## teSpec 空间 SMT 模式

| 项目 | 关闭 | 开启 |
|---|---:|---:|
| 原生 PASS / FAIL / UNKNOWN / ERROR | 1 / 0 / 18 / 0 | 1 / 0 / 18 / 0 |
| 最终预期匹配（含所需 ITP） | 1/19 | 1/19 |
| 每次执行平均时间（秒） | 0.185952 | 0.164905 |
| 平均单次峰值 RSS（MiB） | 19.3892 | 19.4143 |
| 需 ITP 判定的执行数 | 18 | 18 |

模式逐次结果、成本和证书范围见 [模式对照](20261016-evaluation/comparison.md)。无需 ITP 时成本记 0，均值和峰值不适用。SMT 决策不作为 Coq 证书。
