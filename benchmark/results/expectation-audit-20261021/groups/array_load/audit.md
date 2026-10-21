# array_load 预期审查

审查 67 对输入，10 组 CN/QCP 配对；预期不一致 0。

由源码、规约和绑定推导；没有用工具 PASS/FAIL/UNKNOWN 结果作为预期依据。完整源码摘要、哈希、逐例数值/堆见 audit.json。

| CN 变体 | 用例 | inline | modular | Fulminate |
|---|---|---|---|---|
| cn_original:array_load.broken | read_translation3_0 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation3_1 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation3_2 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation3_3 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation3_4 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation3_5 | PASS | PASS | PASS |
| cn_original:array_load | read_translation4_0 | PASS | PASS | PASS |
| cn_original:array_load | read_translation4_1 | PASS | PASS | PASS |
| cn_original:array_load | read_translation4_2 | PASS | PASS | PASS |
| cn_original:array_load | read_translation4_3 | PASS | PASS | PASS |
| cn_original:array_load | read_translation4_4 | PASS | PASS | PASS |
| cn_original:array_load | read_translation4_5 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation5_0 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation5_1 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation5_2 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation5_3 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation5_4 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation5_5 | PASS | PASS | PASS |
| cn_original:array_load.broken | original_client_translation5_only_entry | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation6_0 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation6_1 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation6_2 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation6_3 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation6_4 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation6_5 | PASS | PASS | PASS |
| cn_original:array_load.broken | original_client_translation6_only_entry | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation7_0 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation7_1 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation7_2 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation7_3 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation7_4 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation7_5 | PASS | PASS | PASS |
| cn_original:array_load.broken | original_client_translation7_only_entry | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation8_0 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation8_1 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation8_2 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation8_3 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation8_4 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation8_5 | PASS | PASS | PASS |
| cn_original:array_load.broken | original_client_translation8_only_entry | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation9_0 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation9_1 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation9_2 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation9_3 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation9_4 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation9_5 | PASS | PASS | PASS |
| cn_original:array_load.broken | original_client_translation9_only_entry | PASS | PASS | PASS |
| cn_original:array_load2 | read_translation10_0 | PASS | PASS | PASS |
| cn_original:array_load2 | read_translation10_1 | PASS | PASS | PASS |
| cn_original:array_load2 | read_translation10_2 | PASS | PASS | PASS |
| cn_original:array_load2 | read_translation10_3 | PASS | PASS | PASS |
| cn_original:array_load2 | read_translation10_4 | PASS | PASS | PASS |
| cn_original:array_load2 | read_translation10_5 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation11_0 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation11_1 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation11_2 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation11_3 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation11_4 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation11_5 | PASS | PASS | PASS |
| cn_original:array_load.broken | original_client_translation11_only_entry | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation12_0 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation12_1 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation12_2 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation12_3 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation12_4 | PASS | PASS | PASS |
| cn_original:array_load.broken | read_translation12_5 | PASS | PASS | PASS |
| cn_original:array_load.broken | original_client_translation12_only_entry | PASS | FAIL | PASS |

CN/QCP full verification is restricted to the selected primary target/module. This audit neither reruns it nor extends certificates to every variant/client.

其中 42 对输入采用增强的 QCP read 规约，排除在同规约跨工具比较之外。
