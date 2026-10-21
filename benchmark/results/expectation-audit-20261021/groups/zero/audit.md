# zero 预期审查

审查 46 对输入，9 组 CN/QCP 配对；预期不一致 0。

由源码、规约和绑定推导；没有用工具 PASS/FAIL/UNKNOWN 结果作为预期依据。完整源码摘要、哈希、逐例数值/堆见 audit.json。

| CN 变体 | 用例 | inline | modular | Fulminate |
|---|---|---|---|---|
| cn_original:zero | region_0 | PASS | PASS | PASS |
| cn_original:zero | region_1 | PASS | PASS | PASS |
| cn_original:zero | region_2 | PASS | PASS | PASS |
| cn_original:zero | region_3 | PASS | PASS | PASS |
| cn_original:zero | region_4 | PASS | PASS | PASS |
| cn_original:zero | region_5 | PASS | PASS | PASS |
| cn_original:3 | region_0 | PASS | PASS | PASS |
| cn_original:3 | region_1 | PASS | PASS | PASS |
| cn_original:3 | region_2 | PASS | PASS | PASS |
| cn_original:3 | region_3 | PASS | PASS | PASS |
| cn_original:3 | region_4 | PASS | PASS | PASS |
| cn_original:3 | region_5 | PASS | PASS | PASS |
| constructed:case_f922086f4653e0fa | region_0 | PASS | PASS | PASS |
| constructed:case_f922086f4653e0fa | region_1 | PASS | PASS | PASS |
| constructed:case_f922086f4653e0fa | region_2 | PASS | PASS | PASS |
| constructed:case_f922086f4653e0fa | region_3 | PASS | PASS | PASS |
| constructed:case_f922086f4653e0fa | region_4 | PASS | PASS | PASS |
| constructed:case_f922086f4653e0fa | region_5 | PASS | PASS | PASS |
| constructed:case_317791dd6964fb2a | region_0 | FAIL | FAIL | FAIL |
| constructed:case_317791dd6964fb2a | region_1 | FAIL | FAIL | FAIL |
| constructed:case_317791dd6964fb2a | region_2 | FAIL | FAIL | FAIL |
| constructed:case_317791dd6964fb2a | region_3 | FAIL | FAIL | FAIL |
| constructed:case_317791dd6964fb2a | region_4 | FAIL | FAIL | FAIL |
| constructed:case_317791dd6964fb2a | region_5 | FAIL | FAIL | FAIL |
| constructed:case_494bedbc3a847f00 | region_0 | FAIL | FAIL | FAIL |
| constructed:case_494bedbc3a847f00 | region_1 | FAIL | FAIL | FAIL |
| constructed:case_494bedbc3a847f00 | region_2 | FAIL | FAIL | FAIL |
| constructed:case_494bedbc3a847f00 | region_3 | FAIL | FAIL | FAIL |
| constructed:case_494bedbc3a847f00 | region_4 | FAIL | FAIL | FAIL |
| constructed:case_494bedbc3a847f00 | region_5 | FAIL | FAIL | FAIL |
| constructed:case_66e065c71f01cce1 | region_0 | FAIL | FAIL | FAIL |
| constructed:case_66e065c71f01cce1 | region_1 | FAIL | FAIL | FAIL |
| constructed:case_ffb1bbe1a0e55344 | region_0 | FAIL | FAIL | FAIL |
| constructed:case_ffb1bbe1a0e55344 | region_1 | FAIL | FAIL | FAIL |
| constructed:case_ffb1bbe1a0e55344 | region_2 | FAIL | FAIL | FAIL |
| constructed:case_ffb1bbe1a0e55344 | region_3 | FAIL | FAIL | FAIL |
| constructed:case_ffb1bbe1a0e55344 | region_4 | FAIL | FAIL | FAIL |
| constructed:case_ffb1bbe1a0e55344 | region_5 | FAIL | FAIL | FAIL |
| constructed:case_8f539f0dc9cdc321 | region_0 | ERROR | ERROR | FAIL |
| constructed:case_8f539f0dc9cdc321 | region_1 | ERROR | ERROR | FAIL |
| constructed:case_5473d56c15ac6c58 | region_0 | FAIL | FAIL | FAIL |
| constructed:case_5473d56c15ac6c58 | region_1 | FAIL | FAIL | FAIL |
| constructed:case_5473d56c15ac6c58 | region_2 | PASS | PASS | PASS |
| constructed:case_5473d56c15ac6c58 | region_3 | FAIL | FAIL | FAIL |
| constructed:case_5473d56c15ac6c58 | region_4 | FAIL | FAIL | FAIL |
| constructed:case_5473d56c15ac6c58 | region_5 | FAIL | FAIL | FAIL |

CN/QCP full verification is restricted to the selected primary target/module. This audit neither reruns it nor extends certificates to every variant/client.
