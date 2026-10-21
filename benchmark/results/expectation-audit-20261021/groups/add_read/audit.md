# add_read 预期审查

审查 8 对输入，1 组 CN/QCP 配对；预期不一致 0。

由源码、规约和绑定推导；没有用工具 PASS/FAIL/UNKNOWN 结果作为预期依据。完整源码摘要、哈希、逐例数值/堆见 audit.json。

| CN 变体 | 用例 | inline | modular | Fulminate |
|---|---|---|---|---|
| cn_original:add_read | pair_0 | PASS | PASS | PASS |
| cn_original:add_read | pair_1 | PASS | PASS | PASS |
| cn_original:add_read | pair_2 | PASS | PASS | PASS |
| cn_original:add_read | pair_3 | PASS | PASS | PASS |
| cn_original:add_read | pair_4 | PASS | PASS | PASS |
| cn_original:add_read | pair_5 | PASS | PASS | PASS |
| cn_original:add_read | pair_6 | PASS | PASS | PASS |
| cn_original:add_read | pair_7 | PASS | PASS | PASS |

CN/QCP full verification is restricted to the selected primary target/module. This audit neither reruns it nor extends certificates to every variant/client.
