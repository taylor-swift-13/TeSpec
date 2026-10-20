# Modular 各组结果与成本

**当前策略已移除 modular 边界采样。** [最新 20 组复测结果与成本](modular-20-groups-20261020/index.md)。以下表格保留为历史记录。

| 程序组 | 输入对 | OFF最终匹配 | ON最终匹配 | 剩余UNKNOWN OFF/ON |
| --- | ---: | ---: | ---: | ---: |
| [abs](abs/modular/20261020/result-cost.md) | 57 | 57/57 | 57/57 | 0 / 0 |
| [abs_mem](abs_mem/modular/20261020/result-cost.md) | 7 | 7/7 | 7/7 | 0 / 0 |
| [abs_mem_struct](abs_mem_struct/modular/20261020/result-cost.md) | 7 | 7/7 | 7/7 | 0 / 0 |
| [add](add/modular/20261020/result-cost.md) | 122 | 122/122 | 122/122 | 0 / 0 |
| [add_read](add_read/modular/20261020/result-cost.md) | 8 | 8/8 | 8/8 | 0 / 0 |
| [add_two_array](add_two_array/modular/20261020/result-cost.md) | 8 | 8/8 | 8/8 | 0 / 0 |
| [array_load](array_load/modular/20261020/result-cost.md) | 67 | 60/67 | 60/67 | 7 / 7 |
| [const_example](const_example/modular/20261020/result-cost.md) | 7 | 7/7 | 7/7 | 0 / 0 |
| [example_let](example_let/modular/20261020/result-cost.md) | 136 | 136/136 | 136/136 | 0 / 0 |
| [incr](incr/modular/20261020/result-cost.md) | 103 | 103/103 | 103/103 | 0 / 0 |
| [incr_first](incr_first/modular/20261020/result-cost.md) | 16 | 16/16 | 16/16 | 0 / 0 |
| [init_point](init_point/modular/20261020/result-cost.md) | 6 | 6/6 | 6/6 | 0 / 0 |
| [quadruple](quadruple/modular/20261020/result-cost.md) | 120 | 120/120 | 120/120 | 0 / 0 |
| [read](read/modular/20261020/result-cost.md) | 61 | 61/61 | 61/61 | 0 / 0 |
| [slf3_basic_inplace_double](slf3_basic_inplace_double/modular/20261020/result-cost.md) | 52 | 52/52 | 52/52 | 0 / 0 |
| [slf_quadruple_mem](slf_quadruple_mem/modular/20261020/result-cost.md) | 7 | 7/7 | 7/7 | 0 / 0 |
| [swap](swap/modular/20261020/result-cost.md) | 10 | 10/10 | 10/10 | 0 / 0 |
| [swap_array](swap_array/modular/20261020/result-cost.md) | 20 | 20/20 | 20/20 | 0 / 0 |
| [transfer](transfer/modular/20261020/result-cost.md) | 16 | 16/16 | 16/16 | 0 / 0 |
| [transpose](transpose/modular/20261020/result-cost.md) | 24 | 24/24 | 24/24 | 0 / 0 |
| [zero](zero/modular/20261020/result-cost.md) | 46 | 46/46 | 46/46 | 0 / 0 |

原生与ITP后最终分类均保留；独立逐次ITP成本见各组表。BLOCKED未完成执行不算成功。

2026-10-21 第21组 array_load 跟进：inline67/67，modular66/67；完整父VC诊断通过内核检查，但未解决translation12。见[array_load当前结果](array_load/20261021-parent-analysis/result-cost.md)。
