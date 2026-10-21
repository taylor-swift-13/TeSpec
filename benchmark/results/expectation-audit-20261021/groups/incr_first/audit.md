# incr_first 预期审查

审查 16 对输入，2 组 CN/QCP 配对；预期不一致 0。

由源码、规约和绑定推导；没有用工具 PASS/FAIL/UNKNOWN 结果作为预期依据。完整源码摘要、哈希、逐例数值/堆见 audit.json。

| CN 变体 | 用例 | inline | modular | Fulminate |
|---|---|---|---|---|
| cn_original:slf7_basic_incr_first | pair_0 | PASS | PASS | PASS |
| cn_original:slf7_basic_incr_first | pair_1 | PASS | PASS | PASS |
| cn_original:slf7_basic_incr_first | pair_2 | PASS | PASS | PASS |
| cn_original:slf7_basic_incr_first | pair_3 | PASS | PASS | PASS |
| cn_original:slf7_basic_incr_first | pair_4 | PASS | PASS | PASS |
| cn_original:slf7_basic_incr_first | pair_5 | PASS | PASS | PASS |
| cn_original:slf7_basic_incr_first | pair_6 | PASS | PASS | PASS |
| cn_original:slf7_basic_incr_first | pair_7 | PASS | PASS | PASS |
| cn_original:bcp_framerule | pair_0 | PASS | PASS | PASS |
| cn_original:bcp_framerule | pair_1 | PASS | PASS | PASS |
| cn_original:bcp_framerule | pair_2 | PASS | PASS | PASS |
| cn_original:bcp_framerule | pair_3 | PASS | PASS | PASS |
| cn_original:bcp_framerule | pair_4 | PASS | PASS | PASS |
| cn_original:bcp_framerule | pair_5 | PASS | PASS | PASS |
| cn_original:bcp_framerule | pair_6 | PASS | PASS | PASS |
| cn_original:bcp_framerule | pair_7 | PASS | PASS | PASS |

CN/QCP full verification is restricted to the selected primary target/module. This audit neither reruns it nor extends certificates to every variant/client.
