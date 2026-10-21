# abs 预期审查

审查 57 对输入，8 组 CN/QCP 配对；预期不一致 0。

由源码、规约和绑定推导；没有用工具 PASS/FAIL/UNKNOWN 结果作为预期依据。完整源码摘要、哈希、逐例数值/堆见 audit.json。

| CN 变体 | 用例 | inline | modular | Fulminate |
|---|---|---|---|---|
| cn_original:abs | value_0 | PASS | PASS | PASS |
| cn_original:abs | value_1 | PASS | PASS | PASS |
| cn_original:abs | value_2 | PASS | PASS | PASS |
| cn_original:abs | value_3 | PASS | PASS | PASS |
| cn_original:abs | value_4 | PASS | PASS | PASS |
| cn_original:abs | value_5 | PASS | PASS | PASS |
| cn_original:abs | value_6 | PASS | PASS | PASS |
| constructed:case_231246662bd8cebf | value_0 | FAIL | FAIL | FAIL |
| constructed:case_231246662bd8cebf | value_1 | FAIL | FAIL | FAIL |
| constructed:case_231246662bd8cebf | value_2 | FAIL | FAIL | FAIL |
| constructed:case_231246662bd8cebf | value_3 | PASS | PASS | PASS |
| constructed:case_231246662bd8cebf | value_4 | PASS | PASS | PASS |
| constructed:case_231246662bd8cebf | value_5 | PASS | PASS | PASS |
| constructed:case_231246662bd8cebf | value_6 | PASS | PASS | PASS |
| constructed:case_2a6e78e52e760702 | value_0 | FAIL | FAIL | FAIL |
| constructed:case_2a6e78e52e760702 | value_1 | FAIL | FAIL | FAIL |
| constructed:case_2a6e78e52e760702 | value_2 | FAIL | FAIL | FAIL |
| constructed:case_2a6e78e52e760702 | value_3 | PASS | PASS | PASS |
| constructed:case_2a6e78e52e760702 | value_4 | FAIL | FAIL | FAIL |
| constructed:case_2a6e78e52e760702 | value_5 | FAIL | FAIL | FAIL |
| constructed:case_2a6e78e52e760702 | value_6 | FAIL | FAIL | FAIL |
| constructed:case_64495bb50536f9f9 | value_0 | PASS | PASS | PASS |
| constructed:case_64495bb50536f9f9 | value_1 | PASS | PASS | PASS |
| constructed:case_64495bb50536f9f9 | value_2 | PASS | PASS | PASS |
| constructed:case_64495bb50536f9f9 | value_3 | PASS | PASS | PASS |
| constructed:case_64495bb50536f9f9 | value_4 | PASS | PASS | PASS |
| constructed:case_64495bb50536f9f9 | value_5 | PASS | PASS | PASS |
| constructed:case_64495bb50536f9f9 | value_6 | PASS | PASS | PASS |
| constructed:case_64bc0d58cbb360cd | value_0 | PASS | PASS | PASS |
| constructed:case_64bc0d58cbb360cd | value_1 | PASS | PASS | PASS |
| constructed:case_64bc0d58cbb360cd | value_2 | PASS | PASS | PASS |
| constructed:case_64bc0d58cbb360cd | value_3 | PASS | PASS | PASS |
| constructed:case_64bc0d58cbb360cd | value_4 | FAIL | FAIL | FAIL |
| constructed:case_64bc0d58cbb360cd | value_5 | FAIL | FAIL | FAIL |
| constructed:case_64bc0d58cbb360cd | value_6 | FAIL | FAIL | FAIL |
| constructed:case_90ccad4b1077da1b | value_0 | FAIL | FAIL | FAIL |
| constructed:case_90ccad4b1077da1b | value_1 | FAIL | FAIL | FAIL |
| constructed:case_90ccad4b1077da1b | value_2 | FAIL | FAIL | FAIL |
| constructed:case_90ccad4b1077da1b | value_3 | PASS | PASS | PASS |
| constructed:case_90ccad4b1077da1b | value_4 | PASS | PASS | PASS |
| constructed:case_90ccad4b1077da1b | value_5 | PASS | PASS | PASS |
| constructed:case_90ccad4b1077da1b | value_6 | PASS | PASS | PASS |
| constructed:case_a1dfee652c7b9649 | value_0 | FAIL | FAIL | FAIL |
| constructed:case_a1dfee652c7b9649 | value_1 | PASS | PASS | PASS |
| constructed:case_a1dfee652c7b9649 | value_2 | PASS | PASS | PASS |
| constructed:case_a1dfee652c7b9649 | value_3 | PASS | PASS | PASS |
| constructed:case_a1dfee652c7b9649 | value_4 | PASS | PASS | PASS |
| constructed:case_a1dfee652c7b9649 | value_5 | PASS | PASS | PASS |
| constructed:case_a1dfee652c7b9649 | value_6 | PASS | PASS | PASS |
| constructed:case_a1dfee652c7b9649 | value_7 | PASS | PASS | PASS |
| constructed:case_d36d895752e7a406 | value_0 | PASS | PASS | PASS |
| constructed:case_d36d895752e7a406 | value_1 | PASS | PASS | PASS |
| constructed:case_d36d895752e7a406 | value_2 | PASS | PASS | PASS |
| constructed:case_d36d895752e7a406 | value_3 | PASS | PASS | PASS |
| constructed:case_d36d895752e7a406 | value_4 | FAIL | FAIL | FAIL |
| constructed:case_d36d895752e7a406 | value_5 | FAIL | FAIL | FAIL |
| constructed:case_d36d895752e7a406 | value_6 | FAIL | FAIL | FAIL |

CN/QCP full verification is restricted to the selected primary target/module. This audit neither reruns it nor extends certificates to every variant/client.
