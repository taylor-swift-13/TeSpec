# 第 23 个续做组：Dbl_Linked_List__singleton 当前检查

编号沿用“已完整 21 组后，第 22 检查 const_example_lessgood、第 23 检查本组”的会话顺序，不是字母排序或完整组数。

程序分配一个双向链表节点，令 data=element、prev=NULL、next=NULL。已有 7 个合法输入：INT_MIN、-100、-1、0、1、5、INT_MAX，固定预期全部 PASS；本轮没有修改程序、规约或预期。

| 对象 | 本轮结果 |
|---|---|
| teSpec OFF | 7 UNKNOWN，入口 SAT、执行不完整 |
| teSpec ON | 7 UNKNOWN，入口 SAT、执行不完整 |
| 实际空间 SMT 查询 | 0 |
| 原始残余 VC / 可提交测试 ITP 任务 | 0 / 0，不表示判定完成 |
| CN 原始主程序 | IntList 依赖前端错误，未进入正文验证 |
| Fulminate | 7 次插桩失败，没有可执行测试 |
| QCP 全称验证 | 原始 4VC 完整证据哈希匹配，按原范围复用 |

## 实际停止位置

QCP 源第 6 行调用 `malloc_node()`；依赖 `dll_def.h` 第 6–7 行只有函数声明和分配后规约，没有函数体。当前具体执行语义停在该调用：

```text
Spec test cannot execute function without a body: malloc_node
precondition = SAT
execution_completed = false
vc_results = []
residual_vcs = []
```

ON 的 `attempted=0`、`original_execution_not_eligible`。尚未进入 Dll 谓词导入或空间蕴含求解，不能据此说 SMT 不能处理这个具体单节点，也不能宣称 SMT 已支持递归双向链表。

QCP 可在 malloc_node 契约成立的前提下证明后续写入建立 singleton 规约；teSpec 具体执行不能用契约冒充缺失的运行过程。原 4VC 最终 attempt-5 三次编译及 coqchk 均退出 0，目标/证明/原定义上下文/日志哈希匹配。假设审计为 1 个全局闭合、3 个仅依赖原 eval_addr_expr 参数，无新增公理；不涵盖分配器实现。

## CN / Fulminate 的独立缺口

实际报错在 `arxiv/fulminate-cn/src/examples/list_cn_types.h:12` 的 IntList 自调用。第 7 行旧定义没有当前 CN 所需的递归标记 `[rec]`；前端检查普通谓词正文时尚未登记自身。DLL 的 Own_Forwards / Own_Backwards 也有递归及前向依赖，后续需做保持逻辑定义的工具链兼容迁移。本轮未修改原头文件，当前错误不是已证实的 singleton 实现错误。

修复方向：补忠实的通用外部分配执行支持（新鲜且不重叠的内存、权限、生命周期），并处理 CN 依赖兼容性；之后检查真正产生的返回 VC 是否需要有限展开 Dll。不能把外部调用当作已执行，也不能用固定全局或栈地址伪装新分配。

## 本轮成本

| 阶段 | 次数 | 平均时间（秒） | 平均单次峰值 RSS（KiB） | 最大单进程 RSS（KiB） | 模型 token |
|---|---:|---:|---:|---:|---:|
| cn | 1 | 0.114905 | 43188.00 | 43188 | 0 |
| tespec_off | 7 | 0.222084 | 23803.43 | 23972 | 0 |
| tespec_on | 7 | 0.164896 | 23817.71 | 23892 | 0 |
| fulminate_pipeline | 7 | 0.064551 | 43541.71 | 43944 | 0 |

本轮原始命令、日志、时间、RSS 全部保存；ON 空间适配阶段另有采样。执行器耗时包含在 CLI 时间内，不能相加；阶段采样 RSS 不是精确阶段高水位。Fulminate 未构建，独立测试时间/RSS 为 null。新模型/Coq/ITP 调用为 0，原 QCP 证明成本保留，不重复计作新运行。

[本轮原始结果](results.json)、[汇总与哈希审计](summary.json)、[逐输入异常复查](../../tespec-unexpected/recheck-20261018-singleton.json)。源码、输入、预期和历史证据保持不变；本组仍未完整，总计 21/45。
