# 当前 modular：无边界采样

modular 入口采用测试输入，之后仅传递符号规约/不变式状态；下表 OFF/ON 仅指空间 SMT。没有开启采样的选项。

| 程序组 | 结果与成本 |
|---|---|
| abs | [结果与成本](groups/abs/result-cost.md) |
| abs_mem | [结果与成本](groups/abs_mem/result-cost.md) |
| abs_mem_struct | [结果与成本](groups/abs_mem_struct/result-cost.md) |
| add | [结果与成本](groups/add/result-cost.md) |
| add_read | [结果与成本](groups/add_read/result-cost.md) |
| add_two_array | [结果与成本](groups/add_two_array/result-cost.md) |
| array_load | [结果与成本](groups/array_load/result-cost.md) |
| const_example | [结果与成本](groups/const_example/result-cost.md) |
| example_let | [结果与成本](groups/example_let/result-cost.md) |
| incr | [结果与成本](groups/incr/result-cost.md) |
| incr_first | [结果与成本](groups/incr_first/result-cost.md) |
| init_point | [结果与成本](groups/init_point/result-cost.md) |
| quadruple | [结果与成本](groups/quadruple/result-cost.md) |
| read | [结果与成本](groups/read/result-cost.md) |
| slf3_basic_inplace_double | [结果与成本](groups/slf3_basic_inplace_double/result-cost.md) |
| slf_quadruple_mem | [结果与成本](groups/slf_quadruple_mem/result-cost.md) |
| swap | [结果与成本](groups/swap/result-cost.md) |
| swap_array | [结果与成本](groups/swap_array/result-cost.md) |
| transfer | [结果与成本](groups/transfer/result-cost.md) |
| transpose | [结果与成本](groups/transpose/result-cost.md) |
| zero | [结果与成本](groups/zero/result-cost.md) |

21 组、900 对输入；modular 与 inline 各完成空间 SMT OFF/ON，共 3600 次原生回归，另有 20 次定向对照。与上个版本对应策略的原始 VC 和判定一致，modular 采样事件总数为 0。

原始目标哈希匹配的旧证明继续引用；每种空间模式最终为 497 PASS、379 FAIL、1 UNKNOWN、23 个预期 ERROR。未知项仍为 array_load/translation12；没有增加完整组数量。

[完整审计](audit.json)；新原生测试没有模型调用，token=0，历史证明成本不重复计入。
