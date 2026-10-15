# teSpec 不符合预期的专项台账

已扫描 20 组、853 对变体与输入。最终不匹配 **6** 条；自动阶段缺口经独立 ITP 解决 **27** 条；另有配置错误修正 **30** 条。未评测组不计为零异常。原始分类不改写，人工分析追加到 triage.json，重建不覆盖人工结论。

| 组 | 变体 | 输入 | 模式 | 预期 | 自动 | 最终 | 分类 | 证据 |
|---|---|---|---|---|---|---|---|---|
| add_two_array | cn_original:add_two_array | array_0 | off | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/cee06f0904f3c2d5f9a6.json) |
| add_two_array | cn_original:add_two_array | array_0 | on | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/99bff782ad3cb241bda6.json) |
| add_two_array | cn_original:add_two_array | array_1 | off | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/00842adffecd4184a0f6.json) |
| add_two_array | cn_original:add_two_array | array_1 | on | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/49b8e7d27c6562c979f1.json) |
| add_two_array | cn_original:add_two_array | array_2 | off | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/c4fcbacfc01a2571484e.json) |
| add_two_array | cn_original:add_two_array | array_2 | on | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/ead4b650400ba1c65b1a.json) |
| add_two_array | cn_original:add_two_array | array_3 | off | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/1cf9a2973fe7d2c1934a.json) |
| add_two_array | cn_original:add_two_array | array_3 | on | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/63a8750bba0c2b1037f1.json) |
| add_two_array | cn_original:add_two_array | array_4 | off | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/bac1f3370e6d0edeeed6.json) |
| add_two_array | cn_original:add_two_array | array_4 | on | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/97cd5896464ea5b63087.json) |
| add_two_array | cn_original:add_two_array | array_5 | off | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/7eb250e42869760b9cac.json) |
| add_two_array | cn_original:add_two_array | array_5 | on | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/f7b2be4069ba8be00606.json) |
| add_two_array | cn_original:add_two_array | array_6 | off | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/2740f8c4dd00d14c3421.json) |
| add_two_array | cn_original:add_two_array | array_6 | on | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/e0ebb5de161fe217b4fa.json) |
| add_two_array | cn_original:add_two_array | array_7 | off | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/d54cdd902a4bdeff45f6.json) |
| add_two_array | cn_original:add_two_array | array_7 | on | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/672bd983514ce780dd7a.json) |
| const_example | cn_original:const_example | x_0 | off | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/447fd4e5cd4527f16364.json) |
| const_example | cn_original:const_example | x_0 | on | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/290951de2d0afd39cb61.json) |
| const_example | cn_original:const_example | x_1 | off | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/1645b43bd123bbdd53a6.json) |
| const_example | cn_original:const_example | x_1 | on | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/5df47d8e1809b122fc2d.json) |
| const_example | cn_original:const_example | x_2 | off | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/2d823e904283e21d9d58.json) |
| const_example | cn_original:const_example | x_2 | on | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/3ed782e00a5fbe8b9824.json) |
| const_example | cn_original:const_example | x_3 | off | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/e20a66b9df214dab248d.json) |
| const_example | cn_original:const_example | x_3 | on | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/49cbbcaaa9409d80ccf0.json) |
| const_example | cn_original:const_example | x_4 | off | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/986adcd32235e6d59696.json) |
| const_example | cn_original:const_example | x_4 | on | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/5248d7701eff3656cedf.json) |
| const_example | cn_original:const_example | x_5 | off | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/282359bf6ffd3dca06af.json) |
| const_example | cn_original:const_example | x_5 | on | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/83fa75b2da7384af200e.json) |
| const_example | cn_original:const_example | x_6 | off | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/ebb4acfcc7c07171fec4.json) |
| const_example | cn_original:const_example | x_6 | on | PASS | ERROR | PASS | RESOLVED_CONFIGURATION_ERROR | [详情](cases/703e77dcd7e7514ec521.json) |
| incr | constructed:case_2e28b35274593024 | input_0 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/50bdd48c3a970a043324.json) |
| incr | constructed:case_2e28b35274593024 | input_1 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/714118c7ffc6770d57b8.json) |
| incr | constructed:case_2e28b35274593024 | input_2 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/4c9edea1b6fa710508fc.json) |
| incr | constructed:case_2e28b35274593024 | input_3 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/3e82a968932b53020b5e.json) |
| incr | constructed:case_2e28b35274593024 | input_4 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/3eb641d4c584e026e3b0.json) |
| incr | constructed:case_2e28b35274593024 | input_5 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/a97f851557ee6164fa99.json) |
| incr | constructed:case_48b6281ad8e51e2c | input_0 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/54b33da1979ead7766db.json) |
| incr | constructed:case_48b6281ad8e51e2c | input_1 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/ff1cf56a576050d0bb83.json) |
| incr | constructed:case_48b6281ad8e51e2c | input_2 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/f0930996e3c349db96be.json) |
| incr | constructed:case_48b6281ad8e51e2c | input_3 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/4240dacb06eda29edf9d.json) |
| incr | constructed:case_48b6281ad8e51e2c | input_4 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/a066396cf884861f2b5a.json) |
| incr | constructed:case_48b6281ad8e51e2c | input_5 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/0cc8377f2e1dd7c41b52.json) |
| incr | constructed:case_48b6281ad8e51e2c | input_6 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/2526edf36aa1798ae0fd.json) |
| incr_two | cn_original:slf5_basic_aliased_call.broken | input_0 | off | FAIL | UNKNOWN | UNKNOWN | UNRESOLVED_UNKNOWN | [详情](cases/bc8887a413c264115a41.json) |
| incr_two | cn_original:slf5_basic_aliased_call.broken | input_0 | on | FAIL | UNKNOWN | UNKNOWN | UNRESOLVED_UNKNOWN | [详情](cases/d23ac96c7ffd0a4279e7.json) |
| incr_two | cn_original:slf5_basic_aliased_call.broken | input_1 | off | FAIL | UNKNOWN | UNKNOWN | UNRESOLVED_UNKNOWN | [详情](cases/2ff7b1da499c18ae8c37.json) |
| incr_two | cn_original:slf5_basic_aliased_call.broken | input_1 | on | FAIL | UNKNOWN | UNKNOWN | UNRESOLVED_UNKNOWN | [详情](cases/97b9adb7a92fea912cf4.json) |
| slf3_basic_inplace_double | constructed:case_cd64220fbef61c25 | value_0 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/8f0a71c1328250f32fac.json) |
| slf3_basic_inplace_double | constructed:case_cd64220fbef61c25 | value_1 | off | FAIL | UNKNOWN | FAIL | RESOLVED_AUTOMATIC_GAP | [详情](cases/3c7d990f379c332bb9e9.json) |
| zero | constructed:case_66e065c71f01cce1 | region_0 | off | FAIL | UNKNOWN | UNKNOWN | UNRESOLVED_UNKNOWN | [详情](cases/cce54571e0783df4341a.json) |
| zero | constructed:case_66e065c71f01cce1 | region_1 | off | FAIL | UNKNOWN | UNKNOWN | UNRESOLVED_UNKNOWN | [详情](cases/30cb2f0c4bed776bdbb5.json) |
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
