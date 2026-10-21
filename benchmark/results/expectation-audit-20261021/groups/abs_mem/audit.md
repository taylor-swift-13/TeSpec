# abs_mem 预期审查

审查 7 对输入，1 组 CN/QCP 配对；预期不一致 0。

由源码、规约和绑定推导；没有用工具 PASS/FAIL/UNKNOWN 结果作为预期依据。完整源码摘要、哈希、逐例数值/堆见 audit.json。

| CN 变体 | 用例 | inline | modular | Fulminate |
|---|---|---|---|---|
| cn_original:abs_mem | value_0 | PASS | PASS | PASS |
| cn_original:abs_mem | value_1 | PASS | PASS | PASS |
| cn_original:abs_mem | value_2 | PASS | PASS | PASS |
| cn_original:abs_mem | value_3 | PASS | PASS | PASS |
| cn_original:abs_mem | value_4 | PASS | PASS | PASS |
| cn_original:abs_mem | value_5 | PASS | PASS | PASS |
| cn_original:abs_mem | value_6 | PASS | PASS | PASS |

CN/QCP full verification is restricted to the selected primary target/module. This audit neither reruns it nor extends certificates to every variant/client.
