# slf3_basic_inplace_double 预期审查

审查 52 对输入，8 组 CN/QCP 配对；预期不一致 0。

由源码、规约和绑定推导；没有用工具 PASS/FAIL/UNKNOWN 结果作为预期依据。完整源码摘要、哈希、逐例数值/堆见 audit.json。

| CN 变体 | 用例 | inline | modular | Fulminate |
|---|---|---|---|---|
| cn_original:slf3_basic_inplace_double | value_0 | PASS | PASS | PASS |
| cn_original:slf3_basic_inplace_double | value_1 | PASS | PASS | PASS |
| cn_original:slf3_basic_inplace_double | value_2 | PASS | PASS | PASS |
| cn_original:slf3_basic_inplace_double | value_3 | PASS | PASS | PASS |
| cn_original:slf3_basic_inplace_double | value_4 | PASS | PASS | PASS |
| cn_original:slf3_basic_inplace_double | value_5 | PASS | PASS | PASS |
| cn_original:slf3_basic_inplace_double | value_6 | PASS | PASS | PASS |
| cn_original:slf3_basic_inplace_double | value_7 | PASS | PASS | PASS |
| constructed:case_3a48c3490509391f | value_0 | FAIL | FAIL | FAIL |
| constructed:case_3a48c3490509391f | value_1 | FAIL | FAIL | FAIL |
| constructed:case_3a48c3490509391f | value_2 | PASS | PASS | PASS |
| constructed:case_3a48c3490509391f | value_3 | FAIL | FAIL | FAIL |
| constructed:case_3a48c3490509391f | value_4 | FAIL | FAIL | FAIL |
| constructed:case_3a48c3490509391f | value_5 | FAIL | FAIL | FAIL |
| constructed:case_3a48c3490509391f | value_6 | FAIL | FAIL | FAIL |
| constructed:case_3a48c3490509391f | value_7 | FAIL | FAIL | FAIL |
| constructed:case_701b8ee8d8da58a9 | value_0 | FAIL | FAIL | FAIL |
| constructed:case_701b8ee8d8da58a9 | value_1 | FAIL | FAIL | FAIL |
| constructed:case_701b8ee8d8da58a9 | value_2 | PASS | PASS | PASS |
| constructed:case_701b8ee8d8da58a9 | value_3 | FAIL | FAIL | FAIL |
| constructed:case_701b8ee8d8da58a9 | value_4 | FAIL | FAIL | FAIL |
| constructed:case_701b8ee8d8da58a9 | value_5 | FAIL | FAIL | FAIL |
| constructed:case_701b8ee8d8da58a9 | value_6 | FAIL | FAIL | FAIL |
| constructed:case_701b8ee8d8da58a9 | value_7 | FAIL | FAIL | FAIL |
| constructed:case_b11bad51122dbcea | value_0 | PASS | PASS | PASS |
| constructed:case_b11bad51122dbcea | value_1 | PASS | PASS | PASS |
| constructed:case_b11bad51122dbcea | value_2 | PASS | PASS | PASS |
| constructed:case_b11bad51122dbcea | value_3 | PASS | PASS | PASS |
| constructed:case_b11bad51122dbcea | value_4 | PASS | PASS | PASS |
| constructed:case_b11bad51122dbcea | value_5 | PASS | PASS | PASS |
| constructed:case_b11bad51122dbcea | value_6 | PASS | PASS | PASS |
| constructed:case_b11bad51122dbcea | value_7 | PASS | PASS | PASS |
| constructed:case_c06a959d216db1de | value_0 | FAIL | FAIL | FAIL |
| constructed:case_c06a959d216db1de | value_1 | FAIL | FAIL | FAIL |
| constructed:case_c06a959d216db1de | value_2 | FAIL | FAIL | FAIL |
| constructed:case_c06a959d216db1de | value_3 | FAIL | FAIL | FAIL |
| constructed:case_c06a959d216db1de | value_4 | PASS | PASS | PASS |
| constructed:case_c06a959d216db1de | value_5 | FAIL | FAIL | FAIL |
| constructed:case_c06a959d216db1de | value_6 | FAIL | FAIL | FAIL |
| constructed:case_c06a959d216db1de | value_7 | FAIL | FAIL | FAIL |
| constructed:case_cd64220fbef61c25 | value_0 | FAIL | FAIL | FAIL |
| constructed:case_cd64220fbef61c25 | value_1 | FAIL | FAIL | FAIL |
| constructed:case_e5ead8600e891361 | value_0 | FAIL | FAIL | FAIL |
| constructed:case_e5ead8600e891361 | value_1 | FAIL | FAIL | FAIL |
| constructed:case_e5ead8600e891361 | value_2 | PASS | PASS | PASS |
| constructed:case_e5ead8600e891361 | value_3 | FAIL | FAIL | FAIL |
| constructed:case_e5ead8600e891361 | value_4 | FAIL | FAIL | FAIL |
| constructed:case_e5ead8600e891361 | value_5 | FAIL | FAIL | FAIL |
| constructed:case_e5ead8600e891361 | value_6 | FAIL | FAIL | FAIL |
| constructed:case_e5ead8600e891361 | value_7 | FAIL | FAIL | FAIL |
| constructed:case_f835ddd070b8a691 | value_0 | ERROR | ERROR | FAIL |
| constructed:case_f835ddd070b8a691 | value_1 | ERROR | ERROR | FAIL |

CN/QCP full verification is restricted to the selected primary target/module. This audit neither reruns it nor extends certificates to every variant/client.
