# transfer 预期审查

审查 16 对输入，2 组 CN/QCP 配对；预期不一致 0。

由源码、规约和绑定推导；没有用工具 PASS/FAIL/UNKNOWN 结果作为预期依据。完整源码摘要、哈希、逐例数值/堆见 audit.json。

| CN 变体 | 用例 | inline | modular | Fulminate |
|---|---|---|---|---|
| cn_original:slf8_basic_transfer | pair_0 | PASS | PASS | PASS |
| cn_original:slf8_basic_transfer | pair_1 | PASS | PASS | PASS |
| cn_original:slf8_basic_transfer | pair_2 | PASS | PASS | PASS |
| cn_original:slf8_basic_transfer | pair_3 | PASS | PASS | PASS |
| cn_original:slf8_basic_transfer | pair_4 | PASS | PASS | PASS |
| cn_original:slf8_basic_transfer | pair_5 | PASS | PASS | PASS |
| cn_original:slf8_basic_transfer | pair_6 | PASS | PASS | PASS |
| cn_original:slf8_basic_transfer | pair_7 | PASS | PASS | PASS |
| cn_original:slf9_basic_transfer_aliased | pair_0 | PASS | PASS | PASS |
| cn_original:slf9_basic_transfer_aliased | pair_1 | PASS | PASS | PASS |
| cn_original:slf9_basic_transfer_aliased | pair_2 | PASS | PASS | PASS |
| cn_original:slf9_basic_transfer_aliased | pair_3 | PASS | PASS | PASS |
| cn_original:slf9_basic_transfer_aliased | pair_4 | PASS | PASS | PASS |
| cn_original:slf9_basic_transfer_aliased | pair_5 | PASS | PASS | PASS |
| cn_original:slf9_basic_transfer_aliased | pair_6 | PASS | PASS | PASS |
| cn_original:slf9_basic_transfer_aliased | pair_7 | PASS | PASS | PASS |

CN/QCP full verification is restricted to the selected primary target/module. This audit neither reruns it nor extends certificates to every variant/client.
