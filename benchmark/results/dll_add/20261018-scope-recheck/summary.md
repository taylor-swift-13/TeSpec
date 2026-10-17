# 第 24 组 dll_add：范围复查

当前工具链提交 b4a2f0092（OCaml 5.2 环境）。原程序、规约和预期未改；本次只检查并保存诊断，不覆盖旧正式测量。完整组仍 21/45。

| 检查 | 结果 |
|---|---|
| CN 原依赖 | IntList 递归谓词解析失败 |
| CN 借用 singleton 兼容依赖 | IntList_nil、IntList_cons、add 全部 pass |
| Fulminate 同一兼容层和实际分配运行时 | 14 次 pipeline 与14次独立执行均 PASS |
| teSpec | 分配器支持按用户要求暂缓，本轮0次 |
| QCP | 当前17个原始VC仍缺完整证书；历史manual只有1个引理 |

两个 CN 源的 C 实现（去除注释）相同。annotated add 的后置条件描述插入后的左右链表，但 curr 使用 Node(After)，没有要求其 data 等于 element；QCP 后置条件则有该值约束。弱规约不自动算错误规约，也不能宣称两种规约等价。orig.broken 根本没有 add 函数规约，7个PASS仅说明程序运行成功，不算检查了缺失的契约。

本次14条记录沿用原有两个CN配对各7个空链表输入；只有7个不同的空链表/插入值状态，没有非空链表分支。不能以全部PASS宣称完整覆盖。teSpec的历史UNKNOWN停在外部分配器无函数体处；没有可供ITP补完的执行残余VC。QCP旧manual证明和当前Goal哈希不同，并且仅有一个return引理；未声称它证明了当前全部17目标。

本次借用前组兼容层，依赖哈希与工具链身份保存在 results.json。原生阶段没有模型调用，tokens为0；所有30个实际阶段的时间和逐阶段最大进程RSS保留在 summary.json、原始回执及补充成本表。失败CN探测也计费；未启动QCP证明阶段，不填零完成。复现命令见各回执command；共享兼容层、源/输入/生成C及日志哈希保存。输出目录应全新，避免覆盖既有证据。

详细数据：[summary.json](summary.json)、[results.json](results.json)、[结果与成本](../result-cost.md)。
