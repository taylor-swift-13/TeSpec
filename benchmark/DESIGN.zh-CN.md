# TeSpec 四分类规范评估 Benchmark 设计

## 1. 目标

Benchmark 评估模型或 agent 能否判断一份 QCP candidate specification 与
可信实现的语义关系。题面不提供测试用例；模型必须直接给出四分类，并在认为某个
性质为假时主动寻找具体输入、初始 heap 和逻辑变量绑定作为反例。

每道题公开输入严格只有：

- 一份 implementation \(I\)；
- 一份待评价的 specification \(S\)。

QCP/Rocq 定义和策略是工具依赖，不算第三个语义输入。题目可以由同一个 base 的 impl
mutation 或 spec mutation 生成，题目之间的 mutation lineage 只保存在隐藏构造元数据
中，不作为单题输入。

隐藏的 gold package 包含合法输入域证书、基准语义关系、包含证明、反例 binds、
规范化执行结果、mutation lineage 和内容哈希。模型看不到 gold label、父题或隐藏
witness。

本 benchmark 固定使用以下术语。由于文献中 `sound` 和 `complete` 的方向并不统一，
论文和数据文件必须同时给出下面的逻辑定义，不能只写名称。

## 2. Heap-aware 行为

一个输入状态为

\[
x=(a,H_0),
\]

其中 \(a\) 是具体 C 参数，\(H_0\) 是有限、类型化的初始 heap。一次安全且终止的执行
产生

\[
B(I,x)=(r,H_1,G_1,E),
\]

其中 \(r\) 是返回值，\(H_1\) 是终态 heap，\(G_1\) 是可观察全局状态，\(E\) 是建模的
外部调用事件。数组、结构体、单链表和双链表按 root、block、offset 和 pointer edge
canonicalize；比较时不使用偶然的数值地址。浮点值按 QCP 的 `fp32`/`fp64` 语义和位级
表示比较，不能用宿主语言的模糊字符串格式比较。

实现关系和规范关系分别定义为：

\[
\begin{aligned}
R_I &\triangleq \{(x,B(I,x))\mid x\in D,\ I\text{ 在 }x\text{ 上定义}\},\\
R_S &\triangleq \{(x,y)\mid
  \mathsf{Require}_S(x,\eta_x)
  \land
\mathsf{Ensure}_S(x,y,\eta_x)\}.
\end{aligned}
\]

\(\eta_x\) 只能由参数和初始 heap 导出，必须在执行前冻结。正式题只接收具有唯一
binding、充分代表 binding 或已检查
binding-adequacy certificate 的规范。这样模型不能通过选择 output-dependent
`With` 值改变标签。

`Require` 必须单独检查。若 candidate 用 `Require false` 排除一个 implementation
定义良好的输入，则该执行是 Complete 反例；不能把 verification implication 的
vacuity 当作匹配。

## 3. 两个布尔性质

### 3.1 Sound

\[
\mathsf{Sound}(S,I)
\triangleq R_S\subseteq R_I.
\]

它表示规范允许的每个行为都是 implementation 的真实行为，即规范没有放进实现做不到
的行为。

证伪 `Sound` 必须提交 \((x,y)\in R_S\setminus R_I\)：具体输入和 heap、冻结的合法
`With` bindings、candidate positive polarity，以及 \(y\) 不是 implementation 行为的
checked certificate。隐藏的 sibling mutation 可以帮助构造 witness，但不能作为单题
输入或单独充当证明。

### 3.2 Complete

\[
\mathsf{Complete}(S,I)
\triangleq R_I\subseteq R_S.
\]

它表示 implementation 的每个定义良好行为都被规范接纳，即规范没有排除实现真实行为。
证伪 `Complete` 必须提交 \((x,B(I,x))\in R_I\setminus R_S\)：具体执行 trace 和
candidate negative polarity。首版 benchmark 只纳入确定性 sequential C。

## 4. 四分类

| Gold label | Sound | Complete | 含义 |
|---|---:|---:|---|
| `correct` | 1 | 1 | 规范关系与 implementation 行为关系相等 |
| `soundness` | 1 | 0 | 规范太强，只允许实现行为，但漏掉了部分真实实现行为 |
| `complete` | 0 | 1 | 规范太弱，覆盖实现行为，但还允许实现做不到的行为 |
| `incomparable` | 0 | 0 | 既漏掉实现行为，也允许非实现行为 |

类别名 `soundness` 和 `complete` 在表中分别表示 `sound-only` 和
`complete-only`。旧 paired-mutant pilot 的 `perfect`、`sound` 使用不同轴定义，
只能作为构造历史，必须重新物化，不能直接改名为新 gold。

主任务输出只有这四类。反例是可检查证书，不是第五种标签。工具或 agent 无法得出结论
时可以输出 `abstain`，但它在四分类 accuracy 中计错，并单独报告 abstention rate。

## 5. 600 道题

选择 100 个 base program。每个 base 通过 impl/spec mutation graph 生成 6 个
`impl + spec` 实例，共 600 道题；公开题包仍只包含当前节点的两个输入。

每个 base 至少含四类各一道。额外两道按 base index 循环：

1. `(correct, soundness)`；
2. `(soundness, complete)`；
3. `(complete, incomparable)`；
4. `(incomparable, correct)`。

100 个 base 分为 25 个四题循环组，因此四类最终恰好各 150 道，不需要通过丢弃失败
mutation 来事后平衡。

自动生成的计划位于
[`catalog/question-plan-600.json`](catalog/question-plan-600.json)。其中的
`target_label` 只是 mutation 生成目标；在 gold audit 完成前，不能作为已成立标签。

## 6. 如何构造四类 mutation

每个 base 具有可信行为关系 \(R_I\)，candidate spec 的关系记为 \(R_S\)。构造阶段用
关系包含证明和执行 witness 双重检查：

- `correct`：证明 \(R_I\subseteq R_S\) 且
  \(R_S\subseteq R_I\)。使用 alpha-renaming、结合律重排、透明定义
  fold/unfold、等价 old-state 正规化等语义保持变换。
- `soundness`：证明 \(R_S\subseteq R_I\)，并给出
  \(R_I\setminus R_S\) 的 implementation witness。典型变换是收窄合法输入、添加错误的
  return/heap/float/list 限制或过度约束 globals/call effects。
- `complete`：证明 \(R_I\subseteq R_S\)，并给出
  \(R_S\setminus R_I\) 的可检查 witness。典型变换是删除 post conjunct、放宽数值
  边界、删除 heap effect、量词、排序、permutation、call event 或 `next/prev` 约束。
- `incomparable`：同时实施一项 weakening 和一项 strengthening，并分别保存
  implementation witness 与 spec-only witness，证明两个差集都非空。

不能根据 mutation operator 直接赋标签。删除的 conjunct 可能冗余，mutant 可能等价，
strengthening 也可能由原规范蕴含。没有 checked inclusion 或 required witness 的
mutation 必须丢弃并重新生成。

## 7. Mutation lineage

题目之间可以通过 implementation mutation 或 specification mutation 连接。
operator family 包括：

- return expression、constant、branch 和 loop-bound mutation；
- array index、omitted/duplicated write、wrong field/cell；
- `next`/`prev`、head/tail、skip/duplicate node；
- omitted call、argument swap、call order、ignored callee return；
- floating operator、comparison boundary 和 literal replacement。

mutation 节点进入题库前必须：

1. 编译并通过目标 ABI/type 检查；
2. 与父节点的 mutation 关系和内容哈希已记录；
3. 若声称语义改变，至少存在一个 canonical observable divergence；
4. 不是等价 mutant；
5. 不把父节点、sibling 或 lineage 文件泄漏到公开 `input/`。

mutation operator 只用于构造和分组，不能直接决定标签。公开题包最终仍只有
`impl.c` 和 `spec.qcp`。

## 8. 100 个 base program

静态 shortlist 位于：

- [`catalog/selected-programs.json`](catalog/selected-programs.json)：机器可读；
- [`catalog/selected-programs.md`](catalog/selected-programs.md)：人工审阅。

当前清单有 100 个 annotated target、86 个 source family，来自 CAV、QCP examples、
QCIP output 和已有 TeSpec cases。静态特征包括：

- 54 个多函数调用 target；
- 10 个原生 `float`/`double` target，11 个浮点/`float64` 模型 target；
- 94 个 heap target；
- 14 个单链表和 8 个双链表 target；
- 55 个结构体 target；
- 70 个 nested-control target；
- 76 份含量词规范，83 份依赖自定义 Coq 定义。

这个清单仍是 `static-shortlist-requires-semantic-audit`，不是已完成的 600 题发布集。
静态 score 只用于挑选复杂和多样的程序。正式纳入还要求：

- implementation 与隐藏语义 contract 已检查；
- QCP/Rocq 依赖可打包到题目本地；
- input domain、observable footprint 和 binding adequacy 已冻结；
- 六个 mutation 全部具有相应 gold proof/witness；
- TeSpec strict evaluation mode 能重放同一个 heap；
- 不属于 tree、unrestricted graph、concurrency、UB 或未建模外设语义。

## 9. 题目与隐藏 Gold 格式

公开题面最少包含：

```json
{
  "question_id": "...",
  "impl": "impl.c",
  "spec": "spec.qcp"
}
```

依赖通过固定工具环境提供，不构成第三个语义输入。mutation lineage、合法域证书和父题
均只存在于隐藏 gold。

隐藏 gold 至少包含：

```json
{
  "label": "incomparable",
  "sound": false,
  "complete": false,
  "soundness_counterexample": {
    "binds": "soundness_cex.json",
    "spec_behavior_hash": "...",
    "non_implementation_proof_hash": "..."
  },
  "completeness_counterexample": {
    "binds": "completeness_cex.json",
    "implementation_trace_hash": "...",
    "candidate_rejection_proof_hash": "..."
  },
  "positive_axis_proofs": [],
  "mutation_lineage_hash": "...",
  "toolchain_hashes": {"...": "..."}
}
```

`correct` 保存两个 positive-axis proofs；`soundness` 保存 sound proof 和 complete
counterexample；`complete` 保存 sound counterexample 和 complete proof；
`incomparable` 保存两类 counterexample。

## 10. 模型/Agent 提交格式

```json
{
  "label": "correct|soundness|complete|incomparable|abstain",
  "sound": true,
  "complete": true,
  "soundness_counterexample": null,
  "completeness_counterexample": null,
  "notes": "optional"
}
```

若某一维预测为 `false`，必须提交对应 counterexample。分类分数和证书分数分开报告：
幸运猜中 label 不能计为证书成功。

## 11. 无工具与 TeSpec 对照

对每个模型采用 paired evaluation：

1. `LLM-direct`：只读题面，不能执行工具；
2. `generic-agent`：允许普通文件和 shell 工具，但不提供 TeSpec；
3. `agent+TeSpec`：同一模型、同一上下文和预算，额外提供
   `qcp-spec-test` skill 与 deterministic TeSpec CLI。

`agent+TeSpec` 可以分析 bindings、执行 impl、比较 canonical heap，并检查 spec
proposition。TeSpec 不直接读取 gold label、parent 或 mutation lineage，也不根据日志字符串决定语义
拒绝。它只产生或检查 evidence；最终四分类仍由模型提交。

不同条件必须使用相同题序、模型版本、reasoning budget、wall-clock 上限和重试政策。
同一 base 的 6 道题必须在同一个 split 中，不能通过看过同源 impl/spec 泄漏 test
信息。项目、source family、predicate family 和 mutation family 均需做 held-out
审计。

## 12. 指标

主指标：

- four-class accuracy；
- macro-F1；
- `sound` 与 `complete` 两个轴的 balanced accuracy；
- exact certificate success：label 正确且所有必需反例通过 deterministic checker。

辅助指标：

- counterexample validity/precision；
- counterexample discovery rate；
- abstention 和 unresolved rate；
- TeSpec automatic、manual residual 和 unsupported 比例；
- token、wall-clock、tool calls 和费用；
- 同模型 `agent+TeSpec` 相对 `generic-agent` 的 paired uplift；
- 按 float、calls、array、struct、SLL、DLL、quantifier 和 custom Coq 分层结果。

统计检验使用 base-program clustered bootstrap，不能把同一 base 的 6 道高度相关题目当作
600 个独立样本。

## 13. 防止 Benchmark 泄漏和伪难度

- train/dev/test 按 source family 或项目切分，而不是随机切 600 道题；
- 同一 base 的六个 impl/spec 节点、mutation lineage 和 witnesses 永不跨 split；
- 文件名、注释和 symbol 中删除 mutation operator 与 target label；
- 平衡各类的 token length、conjunct 数和编辑距离，避免“删除就是 soundness”之类捷径；
- 保留 real wrong implementation 和 agent-generated mutant，不能只用模板突变；
- 对函数名、常数和 predicate 名做 held-out/renaming audit；
- 发布 dev gold，test gold 只交给 evaluator；
- 把 `UNKNOWN` 保留为工具结果，禁止映射成任意四分类标签。
