# 前 21 组预期审查（2026-10-21）

900 对输入、122 组 CN/QCP 配对、129 个目标配置；检查 1800 项策略预期及 900 项 Fulminate 预期。

新发现的状态预期错误：0。沿用已修正的 translation12：inline PASS，modular FAIL。

| 组 | 输入对 | inline P/F/E | modular P/F/E | 不一致 |
|---|---:|---|---|---:|
| [abs](groups/abs/audit.md) | 57 | 38/19/0 | 38/19/0 | 0 |
| [abs_mem](groups/abs_mem/audit.md) | 7 | 7/0/0 | 7/0/0 | 0 |
| [abs_mem_struct](groups/abs_mem_struct/audit.md) | 7 | 7/0/0 | 7/0/0 | 0 |
| [add](groups/add/audit.md) | 122 | 76/46/0 | 76/46/0 | 0 |
| [add_read](groups/add_read/audit.md) | 8 | 8/0/0 | 8/0/0 | 0 |
| [add_two_array](groups/add_two_array/audit.md) | 8 | 8/0/0 | 8/0/0 | 0 |
| [array_load](groups/array_load/audit.md) | 67 | 67/0/0 | 66/1/0 | 0 |
| [const_example](groups/const_example/audit.md) | 7 | 7/0/0 | 7/0/0 | 0 |
| [example_let](groups/example_let/audit.md) | 136 | 46/90/0 | 46/90/0 | 0 |
| [incr](groups/incr/audit.md) | 103 | 28/63/12 | 28/63/12 | 0 |
| [incr_first](groups/incr_first/audit.md) | 16 | 16/0/0 | 16/0/0 | 0 |
| [init_point](groups/init_point/audit.md) | 6 | 6/0/0 | 6/0/0 | 0 |
| [quadruple](groups/quadruple/audit.md) | 120 | 46/74/0 | 46/74/0 | 0 |
| [read](groups/read/audit.md) | 61 | 22/32/7 | 22/32/7 | 0 |
| [slf3_basic_inplace_double](groups/slf3_basic_inplace_double/audit.md) | 52 | 20/30/2 | 20/30/2 | 0 |
| [slf_quadruple_mem](groups/slf_quadruple_mem/audit.md) | 7 | 7/0/0 | 7/0/0 | 0 |
| [swap](groups/swap/audit.md) | 10 | 10/0/0 | 10/0/0 | 0 |
| [swap_array](groups/swap_array/audit.md) | 20 | 20/0/0 | 20/0/0 | 0 |
| [transfer](groups/transfer/audit.md) | 16 | 16/0/0 | 16/0/0 | 0 |
| [transpose](groups/transpose/audit.md) | 24 | 24/0/0 | 24/0/0 | 0 |
| [zero](groups/zero/audit.md) | 46 | 19/25/2 | 19/25/2 | 0 |

## 影响实验解读的两项限制

- array_load 的 translation5/6/7/8/9/11 共 42 对输入使用比 CN 更强的 QCP helper 规约。有限测试预期成立，但不得作为“同规约 CN/QCP 对照”，也不能把 QCP 的主程序证明套给 CN 弱规约客户端。
- read 的 7 个旧 Fulminate 预期标签 ERROR 表示预期运行拒绝，旧分类器使用 RUNTIME_FAILURE。这不是 teSpec ERROR。此审查统一记为 Fulminate FAIL，并保留 fulminate_raw=ERROR 和原始报告；未改写历史测量。

## 判定依据

- 算术按 32 位 C 逐中间步骤检查：有符号溢出为 FAIL，无符号运算模 2^32；规约里的数学表达式不做隐式回绕。
- 负变体也可能在 0、相等值或模回绕等特定输入通过；逐输入判定，不按变体名称一刀切。
- emp 是合法空堆前提，但不给读写权限。缺权读写及读未初始化对象的 23 例为预期 teSpec ERROR；只认可相应访问错误，不泛化为任意 ERROR。
- 后置 emp 丢失仍持有的外部单元，按本实验精确空间语义为 FAIL。弱 exists 后置本身可以合法；不能因为弱就把 helper 判负。
- 对调用/聚合对象逐一审查被调函数规约、分离、别名和内部 assertion；translation12 的 modular 反例允许返回 1 而首断言要求 0。
- CN/QCP 主程序验证范围保持原有选定目标；本次审查不声称重新形式化验证所有变体。

重放：`python3 tools/benchmark/audit_group_expectations.py`。源码或绑定哈希变化会拒绝重放，需重新人工审查。
