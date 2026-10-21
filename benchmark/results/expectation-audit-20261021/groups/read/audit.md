# read 预期审查

审查 61 对输入，10 组 CN/QCP 配对；预期不一致 0。

由源码、规约和绑定推导；没有用工具 PASS/FAIL/UNKNOWN 结果作为预期依据。完整源码摘要、哈希、逐例数值/堆见 audit.json。

| CN 变体 | 用例 | inline | modular | Fulminate |
|---|---|---|---|---|
| cn_original:read2 | value_0 | PASS | PASS | PASS |
| cn_original:read2 | value_1 | PASS | PASS | PASS |
| cn_original:read2 | value_2 | PASS | PASS | PASS |
| cn_original:read2 | value_3 | PASS | PASS | PASS |
| cn_original:read2 | value_4 | PASS | PASS | PASS |
| cn_original:read2 | value_5 | PASS | PASS | PASS |
| cn_original:read | value_0 | PASS | PASS | PASS |
| cn_original:read | value_1 | PASS | PASS | PASS |
| cn_original:read | value_2 | PASS | PASS | PASS |
| cn_original:read | value_3 | PASS | PASS | PASS |
| cn_original:read | value_4 | PASS | PASS | PASS |
| cn_original:read | value_5 | PASS | PASS | PASS |
| constructed:case_6d90d7cd08323aa9 | value_0 | PASS | PASS | PASS |
| constructed:case_6d90d7cd08323aa9 | value_1 | PASS | PASS | PASS |
| constructed:case_6d90d7cd08323aa9 | value_2 | PASS | PASS | PASS |
| constructed:case_6d90d7cd08323aa9 | value_3 | PASS | PASS | PASS |
| constructed:case_6d90d7cd08323aa9 | value_4 | PASS | PASS | PASS |
| constructed:case_6d90d7cd08323aa9 | value_5 | PASS | PASS | PASS |
| cn_original:read.broken | value_0 | FAIL | FAIL | FAIL |
| cn_original:read.broken | value_1 | FAIL | FAIL | FAIL |
| cn_original:read.broken | value_2 | FAIL | FAIL | FAIL |
| cn_original:read.broken | value_3 | FAIL | FAIL | FAIL |
| cn_original:read.broken | value_4 | FAIL | FAIL | FAIL |
| cn_original:read.broken | value_5 | FAIL | FAIL | FAIL |
| constructed:case_0c4f0994b9906bcc | value_0 | FAIL | FAIL | FAIL |
| constructed:case_0c4f0994b9906bcc | value_1 | FAIL | FAIL | FAIL |
| constructed:case_0c4f0994b9906bcc | value_2 | FAIL | FAIL | FAIL |
| constructed:case_0c4f0994b9906bcc | value_3 | FAIL | FAIL | FAIL |
| constructed:case_0c4f0994b9906bcc | value_4 | FAIL | FAIL | FAIL |
| constructed:case_0c4f0994b9906bcc | value_5 | FAIL | FAIL | FAIL |
| constructed:case_ad51dbc30c6260f6 | value_0 | FAIL | FAIL | FAIL |
| constructed:case_ad51dbc30c6260f6 | value_1 | FAIL | FAIL | FAIL |
| constructed:case_ad51dbc30c6260f6 | value_2 | PASS | PASS | PASS |
| constructed:case_ad51dbc30c6260f6 | value_3 | FAIL | FAIL | FAIL |
| constructed:case_ad51dbc30c6260f6 | value_4 | FAIL | FAIL | FAIL |
| constructed:case_ad51dbc30c6260f6 | value_5 | FAIL | FAIL | FAIL |
| constructed:case_c5b611b7525792d3 | value_0 | FAIL | FAIL | FAIL |
| constructed:case_c5b611b7525792d3 | value_1 | FAIL | FAIL | FAIL |
| constructed:case_c5b611b7525792d3 | value_2 | PASS | PASS | PASS |
| constructed:case_c5b611b7525792d3 | value_3 | FAIL | FAIL | FAIL |
| constructed:case_c5b611b7525792d3 | value_4 | FAIL | FAIL | FAIL |
| constructed:case_c5b611b7525792d3 | value_5 | FAIL | FAIL | FAIL |
| constructed:case_2ca8ba1f4ef270af | value_0 | ERROR | ERROR | FAIL |
| constructed:case_2ca8ba1f4ef270af | value_1 | ERROR | ERROR | FAIL |
| constructed:case_2ca8ba1f4ef270af | value_2 | ERROR | ERROR | FAIL |
| constructed:case_2ca8ba1f4ef270af | value_3 | ERROR | ERROR | FAIL |
| constructed:case_2ca8ba1f4ef270af | value_4 | ERROR | ERROR | FAIL |
| constructed:case_2ca8ba1f4ef270af | value_5 | ERROR | ERROR | FAIL |
| constructed:case_2ca8ba1f4ef270af | null_pointer | ERROR | ERROR | FAIL |
| constructed:case_b10ac52659429403 | value_0 | FAIL | FAIL | FAIL |
| constructed:case_b10ac52659429403 | value_1 | FAIL | FAIL | FAIL |
| constructed:case_b10ac52659429403 | value_2 | PASS | PASS | PASS |
| constructed:case_b10ac52659429403 | value_3 | FAIL | FAIL | FAIL |
| constructed:case_b10ac52659429403 | value_4 | FAIL | FAIL | FAIL |
| constructed:case_b10ac52659429403 | value_5 | FAIL | FAIL | FAIL |
| constructed:case_0b5de543ec816188 | value_0 | FAIL | FAIL | FAIL |
| constructed:case_0b5de543ec816188 | value_1 | FAIL | FAIL | FAIL |
| constructed:case_0b5de543ec816188 | value_2 | PASS | PASS | PASS |
| constructed:case_0b5de543ec816188 | value_3 | FAIL | FAIL | FAIL |
| constructed:case_0b5de543ec816188 | value_4 | FAIL | FAIL | FAIL |
| constructed:case_0b5de543ec816188 | value_5 | FAIL | FAIL | FAIL |

CN/QCP full verification is restricted to the selected primary target/module. This audit neither reruns it nor extends certificates to every variant/client.
