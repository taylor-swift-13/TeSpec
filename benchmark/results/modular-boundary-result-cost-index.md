# Modular边界修复：各组结果与成本

采样开关×空间SMT开关共四种配置，21组900对输入。20组全部匹配，array_load的弱合同客户端在ITP后仍为UNKNOWN；未改原预期。

| 组 | 输入对 | 每配置预期匹配 | 全部判定完成 | 成本表 |
| --- | ---: | ---: | --- | --- |
| abs | 57 | 57/57 | 是 | [结果与成本](abs/modular-boundary/20261020/result-cost.md) |
| abs_mem | 7 | 7/7 | 是 | [结果与成本](abs_mem/modular-boundary/20261020/result-cost.md) |
| abs_mem_struct | 7 | 7/7 | 是 | [结果与成本](abs_mem_struct/modular-boundary/20261020/result-cost.md) |
| add | 122 | 122/122 | 是 | [结果与成本](add/modular-boundary/20261020/result-cost.md) |
| add_read | 8 | 8/8 | 是 | [结果与成本](add_read/modular-boundary/20261020/result-cost.md) |
| add_two_array | 8 | 8/8 | 是 | [结果与成本](add_two_array/modular-boundary/20261020/result-cost.md) |
| array_load | 67 | 66/67 | 否 | [结果与成本](array_load/modular-boundary/20261020/result-cost.md) |
| const_example | 7 | 7/7 | 是 | [结果与成本](const_example/modular-boundary/20261020/result-cost.md) |
| example_let | 136 | 136/136 | 是 | [结果与成本](example_let/modular-boundary/20261020/result-cost.md) |
| incr | 103 | 103/103 | 是 | [结果与成本](incr/modular-boundary/20261020/result-cost.md) |
| incr_first | 16 | 16/16 | 是 | [结果与成本](incr_first/modular-boundary/20261020/result-cost.md) |
| init_point | 6 | 6/6 | 是 | [结果与成本](init_point/modular-boundary/20261020/result-cost.md) |
| quadruple | 120 | 120/120 | 是 | [结果与成本](quadruple/modular-boundary/20261020/result-cost.md) |
| read | 61 | 61/61 | 是 | [结果与成本](read/modular-boundary/20261020/result-cost.md) |
| slf3_basic_inplace_double | 52 | 52/52 | 是 | [结果与成本](slf3_basic_inplace_double/modular-boundary/20261020/result-cost.md) |
| slf_quadruple_mem | 7 | 7/7 | 是 | [结果与成本](slf_quadruple_mem/modular-boundary/20261020/result-cost.md) |
| swap | 10 | 10/10 | 是 | [结果与成本](swap/modular-boundary/20261020/result-cost.md) |
| swap_array | 20 | 20/20 | 是 | [结果与成本](swap_array/modular-boundary/20261020/result-cost.md) |
| transfer | 16 | 16/16 | 是 | [结果与成本](transfer/modular-boundary/20261020/result-cost.md) |
| transpose | 24 | 24/24 | 是 | [结果与成本](transpose/modular-boundary/20261020/result-cost.md) |
| zero | 46 | 46/46 | 是 | [结果与成本](zero/modular-boundary/20261020/result-cost.md) |

[完整方法、ITP及成本说明](../../docs/benchmark-modular-boundary-fix-20261020.md)；[机器索引](modular-boundary-result-cost-index.json)。
