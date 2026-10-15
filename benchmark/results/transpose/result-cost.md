# transpose：结果与成本表

完整状态：待补齐。语言版本记录 6 条；主程序：待绑定已有验证证据。

| 工具 | 范围 | 结果／预期匹配 | 测试对数 |
|---|---|---|---:|
| cn | 主程序全称验证一次 | PENDING | — |
| qcp | 主程序全称验证一次 | PENDING | — |
| fulminate | 各变体的有限测试 | PENDING | — |
| tespec | 各变体的有限测试 | PENDING | — |

| 工具 | 阶段 | 时间（秒） | 峰值进程内存（MiB） | token | 口径 |
|---|---|---:|---:|---:|---|
| cn | 主程序验证 | 待补齐 | 待补齐 | 待补齐 | 一次主程序验证 |
| qcp | VC 生成与自动处理 | 待补齐 | 待补齐 | 待补齐 | 已测工作总量 |
| qcp | agent 填写证明 | 待补齐 | 待补齐 | 待补齐 | 一次主程序验证 |
| qcp | Coq 编译与假设审计 | 待补齐 | 待补齐 | 待补齐 | 一次主程序验证 |
| qcp | 独立内核检查 | 待补齐 | 待补齐 | 待补齐 | 一次主程序验证 |
| qcp | ITP 平均合计 | 待补齐 | 待补齐 | 待补齐 | 一次主程序验证 |
| fulminate | 插桩、编译与首次执行 | 待补齐 | 待补齐 | 待补齐 | 已测工作总量 |
| fulminate | 单独运行测试 | 待补齐 | 待补齐 | 待补齐 | 已测工作总量 |
| tespec | 测试执行、VC 生成与自动处理 | 待补齐 | 待补齐 | 待补齐 | 已测工作总量 |
| tespec | agent 填写证明 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec | Coq 编译与假设审计 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec | 独立内核检查 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |
| tespec | ITP 平均合计 | 待补齐 | 待补齐 | 待补齐 | PENDING_PER_EXECUTION_MEAN |

ITP 以一次测试执行的所有待处理 VC 为单位，只展示平均开销；read 按 12 次需要 ITP 的执行均摊已有批次。峰值内存不取均摊。ITP 合计行与其三个分项重叠，不能再次相加。CN/QCP 与两种测试工具的对象和次数不同。

缺测记为待补齐，不表示已有历史证据作废；须绑定匹配证据后发布。原始证据、计量来源与缺项见 [result-cost.json](result-cost.json)，成本 CSV 见 [result-cost.csv](result-cost.csv)。
