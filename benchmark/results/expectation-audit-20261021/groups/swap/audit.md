# swap 预期审查

审查 10 对输入，1 组 CN/QCP 配对；预期不一致 0。

由源码、规约和绑定推导；没有用工具 PASS/FAIL/UNKNOWN 结果作为预期依据。完整源码摘要、哈希、逐例数值/堆见 audit.json。

| CN 变体 | 用例 | inline | modular | Fulminate |
|---|---|---|---|---|
| cn_original:swap | pair_0 | PASS | PASS | PASS |
| cn_original:swap | pair_1 | PASS | PASS | PASS |
| cn_original:swap | pair_2 | PASS | PASS | PASS |
| cn_original:swap | pair_3 | PASS | PASS | PASS |
| cn_original:swap | pair_4 | PASS | PASS | PASS |
| cn_original:swap | pair_5 | PASS | PASS | PASS |
| cn_original:swap | pair_6 | PASS | PASS | PASS |
| cn_original:swap | pair_7 | PASS | PASS | PASS |
| cn_original:swap | pair_8 | PASS | PASS | PASS |
| cn_original:swap | pair_9 | PASS | PASS | PASS |

CN/QCP full verification is restricted to the selected primary target/module. This audit neither reruns it nor extends certificates to every variant/client.
