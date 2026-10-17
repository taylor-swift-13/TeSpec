# dll_add：结果与成本表

完整状态：待补齐。语言版本记录 3 条；主程序：cn_original:Dbl_Linked_List__add。

本组尚未完成；已测失败尝试和未运行阶段分别保留，见 [覆盖缺口](coverage-gap.json)。

2026-10-18 第24组复查：原依赖在当前CN仍因IntList递归声明失败；借用singleton兼容层后add与两个helper验证通过，Fulminate 14次执行均PASS。下表正式入口保留旧版本结果，本次探测结果及成本另列，不把不同依赖测量覆盖到旧证据。

14次执行中，7次检查原较弱CN规约，另7次源函数无规约，仅表示合法输入的程序运行通过；不能称14个规约都验证正确。CN只约束链表形状，QCP另要求新节点值等于element。所有输入均为空链表，非空分支未覆盖。

teSpec分配器支持按用户要求暂缓，本轮0次。QCP仍缺当前17个原始VC的完整证书；历史manual只有1个引理，不能替代完整验证。完整组仍21/45。详见20261018-scope-recheck/summary.md。

| 工具 | 范围 | 结果／预期匹配 | 测试对数 |
|---|---|---|---:|
| cn | 主程序全称验证一次 | ORIGINAL_MODULE_REJECTED | — |
| qcp | 主程序全称验证一次 | VC_GENERATED_PROOF_OR_REFUTATION_PENDING | — |
| fulminate | 各变体的有限测试 | 0/14 | 14 |
| tespec | 各变体的有限测试 | 0/14 | 14 |

| 工具 | 阶段 | 时间（秒） | 峰值进程内存（MiB） | token | 口径 |
|---|---|---:|---:|---:|---|
| cn | 主程序验证 | 0.0646 | 42.9141 | 0.0000 | 一次主程序验证 |
| qcp | VC 生成与自动处理 | 0.1648 | 7.9648 | 0.0000 | 已测工作总量 |
| qcp | agent 填写证明 | 待补齐 | 待补齐 | 待补齐 | 一次主程序验证 |
| qcp | Coq 编译与假设审计 | 待补齐 | 待补齐 | 待补齐 | 一次主程序验证 |
| qcp | 独立内核检查 | 待补齐 | 待补齐 | 待补齐 | 一次主程序验证 |
| qcp | ITP 平均合计 | 待补齐 | 待补齐 | 待补齐 | 一次主程序验证 |
| fulminate | 插桩、编译与首次执行 | 0.9544 | 43.5781 | 0.0000 | 已测工作总量 |
| fulminate | 单独运行测试 | 待补齐 | 待补齐 | 0.0000 | 已测工作总量 |
| tespec | 测试执行、VC 生成与自动处理 | 2.7604 | 19.6562 | 0.0000 | 已测工作总量 |
| tespec | agent 填写证明 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec | Coq 编译与假设审计 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec | 独立内核检查 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec | ITP 平均合计 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec --spatial-smt | 测试执行、VC 生成与空间 SMT | 0.1648 | 19.4902 | 0.0000 | 每次测试执行均值；内存为逐次峰值均值 |
| tespec --spatial-smt | agent 填写证明 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec --spatial-smt | Coq 编译与假设审计 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec --spatial-smt | 独立内核检查 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec --spatial-smt | ITP 平均合计 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| cn | 第24组当前版本原依赖复查失败 | 0.1155 | 44.8008 | 0.0000 | 1 次复查总量；不覆盖历史正式测量 |
| cn | 第24组共享兼容层验证探测成功 | 1.2177 | 46.6836 | 0.0000 | 1 次复查总量；不覆盖历史正式测量 |
| fulminate | 第24组共享运行时插桩、编译及首次执行 | 4.8641 | 46.2969 | 0.0000 | 14 次复查总量；不覆盖历史正式测量 |
| fulminate | 第24组共享运行时独立执行 | 0.0487 | 1.1172 | 0.0000 | 14 次复查总量；不覆盖历史正式测量 |

ITP 以一次测试执行的所有待处理 VC 为单位，只展示平均开销；read 的 12 次所需 ITP 各自独立测量后取平均。内存不将总峰值除以次数；read ITP 展示逐次实测峰值的平均值。ITP 合计行与其三个分项重叠，不能再次相加。CN/QCP 与两种测试工具的对象和次数不同。

缺测记为待补齐，不表示已有历史证据作废；须绑定匹配证据后发布。原始证据、计量来源与缺项见 [result-cost.json](result-cost.json)，成本 CSV 见 [result-cost.csv](result-cost.csv)。

补充的源修订／失败诊断成本单列，见 [补充成本来源](supplementary-costs.json)；不改变主成功测量均值，也不重复计入已统计的 ITP 阶段。

## teSpec 空间 SMT 模式

| 项目 | 关闭 | 开启 |
|---|---:|---:|
| 原生 PASS / FAIL / UNKNOWN / ERROR | 0 / 0 / 14 / 0 | 0 / 0 / 14 / 0 |
| 最终预期匹配（含所需 ITP） | 0/14 | 0/14 |
| 每次执行平均时间（秒） | 0.197171 | 0.164845 |
| 平均单次峰值 RSS（MiB） | 19.4640 | 19.4902 |
| 需 ITP 判定的执行数 | 14 | 14 |

模式逐次结果、成本和证书范围见 [模式对照](20261016-evaluation/comparison.md)。无需 ITP 时成本记 0，均值和峰值不适用。SMT 决策不作为 Coq 证书。
