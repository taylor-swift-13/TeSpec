# dll_add 评测结果与成本

当前 QCP 规约已按 CN 后置条件修订，返回值非空，返回节点数据存在量化。入口保留原有显式字段资源。跨工具形式化等价尚未证明。

| 策略 | 输入数 | Auto PASS | UNKNOWN | FAIL / ERROR | ITP |
|---|---:|---:|---:|---:|---|
| inline | 12 | 12 | 0 | 0 | 按用户要求暂缓 |
| modular | 12 | 12 | 0 | 0 | 按用户要求暂缓 |

最终批次 24 次实际执行由两条 CN 配对共享，模型调用及 token 均为 0。旧 QCP 全称证明及 ITP 证书绑定此前源哈希，新规约全称验证待重核。

三轮矩阵共 72 次实跑，另有两个规约控制。折叠入口版本为 14 PASS、10 UNKNOWN，缺少顶层析取整体括号的中间版本为 24 UNKNOWN。最终版本 24 PASS。控制中，改变新节点值仍 PASS，空指针返回被判 FAIL。全部尝试成本如下。

| 批次 | 策略 | 阶段 | 次数 | 时间 s | 峰值 RSS KiB | token |
|---|---|---|---:|---:|---:|---:|
| folded_entry | inline | auto_layout | 12 | 1.090425 | 19980 | 0 |
| folded_entry | inline | native | 12 | 2.271691 | 21144 | 0 |
| folded_entry | inline | auto | 7 | 0.994892 | 56512 | 0 |
| folded_entry | modular | auto_layout | 12 | 1.097075 | 19964 | 0 |
| folded_entry | modular | native | 12 | 2.260266 | 21136 | 0 |
| folded_entry | modular | auto | 7 | 0.970764 | 56524 | 0 |
| unparenthesized_entry | inline | auto_layout | 12 | 1.115522 | 20012 | 0 |
| unparenthesized_entry | inline | native | 12 | 2.739331 | 21384 | 0 |
| unparenthesized_entry | inline | auto | 12 | 1.213856 | 46796 | 0 |
| unparenthesized_entry | modular | auto_layout | 12 | 1.136008 | 19980 | 0 |
| unparenthesized_entry | modular | native | 12 | 2.887845 | 21288 | 0 |
| unparenthesized_entry | modular | auto | 12 | 1.205892 | 46796 | 0 |
| active_parenthesized_entry | inline | auto_layout | 12 | 1.137945 | 20004 | 0 |
| active_parenthesized_entry | inline | native | 12 | 1.882177 | 21140 | 0 |
| active_parenthesized_entry | inline | auto | 5 | 0.631309 | 56056 | 0 |
| active_parenthesized_entry | modular | auto_layout | 12 | 1.070223 | 20008 | 0 |
| active_parenthesized_entry | modular | native | 12 | 1.871269 | 21088 | 0 |
| active_parenthesized_entry | modular | auto | 5 | 0.632671 | 55820 | 0 |
| controls | inline | auto_layout | 2 | 13.025742 | 550660 | 0 |
| controls | inline | native | 2 | 0.350797 | 21408 | 0 |
| controls | inline | auto | 0 | 0.000000 | — | 0 |

[逐输入结果、分支、实际源与 VC 哈希、所有成本](tespec/contract-revision.json)

旧规约的 teSpec 目录及成本表中的重复旧记录已删除。当前 teSpec 结果取自 contract-revision.json。跨目录历史实验及共享证据的清理待确认。
