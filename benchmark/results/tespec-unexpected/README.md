# teSpec 不符合预期的专项台账

已扫描 6 组、262 对变体与输入。最终不匹配 **0** 条；自动阶段缺口经独立 ITP 解决 **12** 条。未评测组不计为零异常。原始分类不改写，人工分析追加到 triage.json，重建不覆盖人工结论。

| 组 | 变体 | 输入 | 模式 | 预期 | 自动 | 最终 | 分类 | 证据 |
|---|---|---|---|---|---|---|---|---|
| read | cn_original:read.broken | value_0 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/cf79950128cc8d076c10.json) |
| read | cn_original:read.broken | value_1 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/b37d0c5293630ebe71d3.json) |
| read | cn_original:read.broken | value_2 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/d3f538f8a8f84fc3417d.json) |
| read | cn_original:read.broken | value_3 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/ca31047eb5bdae126cdd.json) |
| read | cn_original:read.broken | value_4 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/ed88948f6feb4d345a0b.json) |
| read | cn_original:read.broken | value_5 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/927db8b1e76bdc23c59a.json) |
| read | constructed:case_0c4f0994b9906bcc | value_0 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/95d1376126dcbde8ec04.json) |
| read | constructed:case_0c4f0994b9906bcc | value_1 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/5974ac8acd8ff971ed86.json) |
| read | constructed:case_0c4f0994b9906bcc | value_2 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/969d41711a98fa28b5bb.json) |
| read | constructed:case_0c4f0994b9906bcc | value_3 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/fe40286a65aaaeda9d09.json) |
| read | constructed:case_0c4f0994b9906bcc | value_4 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/8b3438168e96f374dbd6.json) |
| read | constructed:case_0c4f0994b9906bcc | value_5 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/58f71b96bb9e6cf7956c.json) |

每条详情包含原始／最终状态、模式对照引用、输入、复现命令（写入独立 /tmp 目录）、原始日志、源码与 VC 哈希、ITP 结论和分类。read 的 12 条为旧自动阶段 UNKNOWN，经逐执行 Coq 反证完成；不是 12 个尚未解决的最终错误。开启空间 SMT 的逐例证据另见 read 模式对照。
