# TeSpec 严格理论稿

本文档是论文理论部分的中文严格版。它区分三件容易混淆的事：

1. QCP 已经提供并由 Rocq 检查的证明基础；
2. TeSpec 对 QCP 执行路径所做的新修改；
3. 一个具体 bind 所证明的“索引化契约实例”和整个 QCP 契约之间的差异。

核心原则是：搜索失败不是反例，执行成功不是规范证明，一个方便的 bind 也不自动代表
所有 `With` 实例。

---

## 1. 研究对象

普通实例化规范评估把程序行为写成纯关系：

\[
S(i,o).
\]

C 分离逻辑规范描述的是状态转换：

\[
(a,\sigma_0)\longmapsto (r,\sigma_1).
\]

其中 \(a\) 是具体 C 参数，\(\sigma_0\) 是初态，\(r\) 是返回值，
\(\sigma_1\) 是终态。状态包含 store、有限 heap、数组、结构体、链表、别名和全局
变量。

TeSpec 的目标不是证明实现对所有输入满足规范，而是回答：

> 对一个已认证的具体输入或 heap transition，候选 QCP 规范是否按预期接受或拒绝它？

规范不需要可执行。TeSpec 将具体状态编码为逻辑对象，把它代入原始规范，并要求 Rocq
检查预期极性或相反极性的证明。

---

## 2. 程序状态与具体执行

令带类型的值集合为 \(\mathsf{Val}\)。指针抽象为 block-offset：

\[
(b,o),
\]

避免依赖进程中的数值地址。

程序状态为：

\[
\sigma=(\rho,h),
\]

其中 \(\rho\) 是局部变量、参数和全局变量的 store，\(h\) 是从已分配
block-offset 到带类型 cell 的有限映射。

安全终止关系写成：

\[
\langle f,a,\sigma_0\rangle\Downarrow(r,\sigma_1).
\]

fault、undefined behavior、外部效果不明、fuel 耗尽和执行发散都不是正常终态，必须
产生独立状态或 `UNKNOWN`。

---

## 3. QCP 表层断言和内部断言

QCP 注释中的 C-like assertion 不是最终的逻辑语义对象。令 \(U\) 为表层断言，
\(A\) 为 QCP/Rocq 内部分离逻辑断言，展开判断写成：

\[
\Sigma;\Gamma_C;\Gamma_G\vdash U\Downarrow_A A.
\]

展开至少负责：

- 解析 C 类型、字段偏移和地址；
- 把 C-like heap read 转成逻辑值及相应空间权限；
- 解析 `@pre`；
- 解析重载记号、自定义谓词和量词；
- 检查逻辑变量类型。

### 假设 A：断言展开充分性

对受支持且类型正确的 \(U\)：

\[
\sigma,\eta\models_{\mathrm{surface}}U
\iff
\sigma,\eta\models_\Sigma A.
\]

如果这条性质尚未对 TeSpec 接受的语法片段机械化，QCP 前端和 TeSpec 的注入转换器必须
明确列入 TCB。不能直接把注释文本当成一个无解释的 `Prop`。

---

## 4. QCP 契约与 `With` 的全称语义

展开后的候选契约为：

\[
S=(\Gamma_G,P,Q),
\]

其中：

\[
P:\llbracket\Gamma_G\rrbracket\times X\to\mathsf{Prop},
\]

\[
Q:\llbracket\Gamma_G\rrbracket\times X\times Y\to\mathsf{Prop}.
\]

这里：

\[
X=A\times\mathsf{State},\qquad
Y=\mathsf{Ret}\times\mathsf{State}.
\]

记 \(x=(a,\sigma_0)\)，\(y=(r,\sigma_1)\)。

QCP 的：

```c
With eta
Require P(eta)
Ensure  Q(eta)
```

在 Hoare 契约层面表示：

\[
\forall\eta.\ \{P(\eta)\}\ f\ \{Q(\eta)\}.
\]

因此，`With` 不是 `Ensure` 中可任意选择的 existential witness。

定义候选规范的内在输入域：

\[
\mathsf{Dom}_S(x)
\triangleq
\exists\eta.\ P(\eta,x).
\]

定义一个结果对契约的符合性：

\[
\mathsf{Conf}_S(x,y)
\triangleq
\forall\eta.\ P(\eta,x)\rightarrow Q(\eta,x,y).
\]

定义完整接受关系：

\[
\mathsf{Accept}_S(x,y)
\triangleq
\mathsf{Dom}_S(x)\land\mathsf{Conf}_S(x,y).
\]

输入域使用存在量词，因为只要初态有一个合法抽象表示，输入就被前置条件接纳。后置
符合性使用全称量词，因为原契约对每个满足前置条件的 `With` 实例都作出承诺。

---

## 5. bind 的正确语义

程序执行不会直接产生 Coq 逻辑变量。因此工具可使用：

\[
\mathcal B_S:
X\rightharpoonup
\mathcal P_{\mathrm{fin}}(\llbracket\Gamma_G\rrbracket)
\]

提出有限个候选逻辑环境。用户填写一组 JSON bind 是这种接口；单条 bind 是 singleton
特例。

### 5.1 只依赖前态

绑定器只能读取：

- 候选规范和允许的透明定义；
- 具体 C 参数；
- 具体初态。

它不能读取：

- 返回值；
- 终态；
- 正负 case 标签。

因此，从同一 \(x\) 出发的正确实现和 mutant 必须复用同一 binding record。这阻止了
看完输出再挑 witness 的泄漏。

但“只依赖前态”仍然不够。

### 5.2 绑定歧义

同一个 heap 可能在多个 \(\eta\) 下满足 \(P\)，且这些 \(\eta\) 对后置条件的要求
不同。定义在输入 \(x\) 上的后置观测等价：

\[
\eta\equiv_{S,x}\eta'
\iff
\forall y.\ Q(\eta,x,y)\leftrightarrow Q(\eta',x,y).
\]

### 定义 1：充分代表元

\(\widehat\eta\) 是 \(S\) 在 \(x\) 上的充分代表元，当且仅当：

\[
P(\widehat\eta,x)
\land
\forall\eta'.\
P(\eta',x)\rightarrow
\eta'\equiv_{S,x}\widehat\eta.
\]

如果满足前置条件的 bind 唯一，则它自然是充分代表元。即使不唯一，只要所有合法抽象
对后置条件观测等价，也可使用一个代表元。

### 定义 2：ghost-complete 有限绑定

有限集合 \(E\) 对 \((S,x)\) ghost-complete，当且仅当对所有 \(y\)：

\[
\mathsf{Dom}_S(x)
\iff
\bigvee_{\eta\in E}P(\eta,x),
\]

\[
\mathsf{Conf}_S(x,y)
\iff
\bigwedge_{\eta\in E}
\bigl(P(\eta,x)\rightarrow Q(\eta,x,y)\bigr).
\]

这两个等价必须被检查，不能由 agent 的置信度代替。

### 推论

- 有充分代表元时，全称后置检查可化为一个代表元实例；
- 有 ghost-complete 集合时，可化为有限合取；
- 只有类型正确但没有充分性证明的 bind，只能产生“索引化实例证据”；
- binder 找不到值不等于 \(\neg\mathsf{Dom}_S(x)\)。

任意 Coq 类型的 bind 可以通过 raw typed term 接口表示，但自动发现和自动证明其充分性
不可能对任意类型保证完备。

---

## 6. 精确状态编码

令：

\[
\mathsf{Enc}(\sigma)
\]

编码有限状态中全部已分配 block、带类型 cell、root、别名和相关 store 值。
“精确”是指它的模型恰好是 \(\sigma\) 的 heap-isomorphism 类，没有不受约束的空间
frame。

### 假设 B：状态编码充分性

对受支持且地址参数化的内部断言 \(A\)：

\[
\sigma\models_\Sigma A
\iff
\mathsf{Eval}_\Sigma(\mathsf{Enc}(\sigma),A).
\]

\(\mathsf{Eval}\) 是实际提交给 Rocq 的命题。它可以由 QCP entailment 加精确性引理
实现。

正向证明：

\[
\mathsf{Eval}_\Sigma(\mathsf{Enc}(\sigma),A)
\]

能够证明 concrete state 满足 \(A\)。正向证明失败不能证明不满足。负向 verdict 必须
证明：

\[
\neg\mathsf{Eval}_\Sigma(\mathsf{Enc}(\sigma),A),
\]

或者给出 checked countermodel，并且 countermodel 算法有完备性定理。

形如：

\[
\mathsf{Enc}_L(\sigma)*F
\]

的半实例化 heap 表示一组 completion，而不是一个 concrete state。它只能在以下情形
用于正式 benchmark：

1. 证明候选断言对 \(L\) 外的 heap frame 不敏感；
2. 生成的目标显式对所有 completion 全称量化；
3. 只作为非对比的 interactive mode，并清楚标注。

程序没读到的 heap 也可能被候选规范读取，所以“足够执行”不等于“足够评估规范”。

---

## 7. 固定和 canonicalize heap

候选 `Require` 不能构造自己的评分输入。正式 benchmark 必须：

1. 使用参考契约或独立生成器创建初态；
2. 在候选出现前冻结并 canonicalize；
3. 所有候选 replay 同一个 heap；
4. 候选前置条件只在该 heap 上被检查。

canonical heap 记录：

\[
(\text{block kind},\text{size},\text{typed cells},
\text{roots},\text{alias relation}).
\]

地址重命名 \(\mu\) 必须保持 block、offset、cell、root 和 pointer edge。对于不依赖
数值地址的断言，应证明：

\[
\sigma,\eta\models A
\iff
\mu(\sigma),\mu(\eta)\models A.
\]

指针转整数、无关指针排序或依赖分配器数值地址的 case 不属于这一不变性结论。

---

## 8. 规范质量的四个维度

参考语义 \(R\) 给出合法输入集 \(I_R\) 和每个合法输入允许的结果集 \(T_R(x)\)。

候选语义为：

\[
I_S=\{x\mid\mathsf{Dom}_S(x)\},
\]

\[
T_S(x)=\{y\mid\mathsf{Conf}_S(x,y)\}.
\]

四个维度分别是：

\[
I_R\subseteq I_S
\quad\text{输入覆盖率},
\]

\[
I_S\subseteq I_R
\quad\text{输入精确性},
\]

\[
\forall x\in I_R.\ T_R(x)\subseteq T_S(x)
\quad\text{transition 覆盖率},
\]

\[
\forall x\in I_R.\ T_S(x)\subseteq T_R(x)
\quad\text{transition 精确性}.
\]

四者同时成立，当且仅当：

\[
I_S=I_R
\quad\land\quad
\forall x\in I_R.\ T_S(x)=T_R(x).
\]

有限测试只提供对这四个 inclusion 的实例证据，不推出全称等价。

---

## 9. 四类 case 的正确目标

参考 oracle 认证四类 case：

\[
\mathsf{Pre}^+(x),\quad
\mathsf{Pre}^-(x),\quad
\mathsf{Post}^+(x,y),\quad
\mathsf{Post}^-(x,y).
\]

候选的正式目标为：

\[
\mathsf{Goal}_S(c)=
\begin{cases}
\mathsf{Dom}_S(x)
  & c=\mathsf{Pre}^+(x),\\
\neg\mathsf{Dom}_S(x)
  & c=\mathsf{Pre}^-(x),\\
\mathsf{Conf}_S(x,y)
  & c=\mathsf{Post}^+(x,y),\\
\neg\mathsf{Conf}_S(x,y)
  & c=\mathsf{Post}^-(x,y).
\end{cases}
\]

post goal 刻意不合取 \(\mathsf{Dom}\)，从而让输入和 transition 质量分开计分。如果
\(P\) 在 \(x\) 上不可满足，则 \(\mathsf{Conf}\) 对所有 \(y\) 真空为真：候选会接受
positive outcome，但无法拒绝任何 negative outcome，同时在 positive-pre case 上失败。
因此，只要测试集同时包含输入和 transition 的正负极性，令 \(P=\mathsf{false}\)
不能通过全部 case。

有充分代表元时，post 部分可安全化为
\(Q(\widehat\eta,x,y)\) 或其否定。没有充分性证明时，不能用一个 bind 替代原目标。

---

## 10. 双向三值判定

对闭合目标 \(\phi=\mathsf{Goal}_S(c)\)，定义：

\[
\mathcal J_\Sigma(\phi)=
\begin{cases}
\mathsf{PASS}
  & \text{Rocq 检查了 }\phi\text{ 的证明},\\
\mathsf{FAIL}
  & \text{Rocq 检查了 }\neg\phi\text{ 的证明},\\
\mathsf{UNKNOWN}
  & \text{两种证明都未获得}.
\end{cases}
\]

若 \(\Sigma\) 一致，同一目标不可能同时拥有有效 PASS 和 FAIL 证书。

必须区分：

- QCP 无法推出 memory-read precondition；
- SMT timeout；
- SMT 在中间符号路径中发现矛盾；
- Rocq 编译了测试目标相反极性的证明。

前三者可能说明执行被阻塞、路径不可达或自动化不足，但都不自动等于最后一项。
因此 definitive `FAIL` 必须来自 dual goal 的 checked proof。

扩大 proof budget 只能把 `UNKNOWN` 变为 `PASS` 或 `FAIL`，不能合法翻转已经检查的
结论。

---

## 11. 具体执行规则

QCP 把程序拆成 partial statements，并维护四类 exit assertion：

\[
\mathsf N,\quad\mathsf B,\quad\mathsf C,\quad\mathsf R(v).
\]

TeSpec 的专门化执行判断写为：

\[
\Sigma\vdash
\langle ps,A\rangle
\Longrightarrow_k
\langle\kappa,A'\rangle;\mathcal O.
\]

\(\mathcal O\) 是内存安全、地址、类型、算术 definedness 和状态一致性 obligation。
只有全部 obligation 得到 checked proof，执行 derivation 才是 conclusive。

### 11.1 load/store

load 需要证明 QCP 形式的空间 entailment：

\[
A\vdash\exists v,F.\ \ell\mapsto v*F.
\]

具体模式还要求 \(v\) 唯一化简为 ground typed value。store 在证明写权限和
definedness 后，把：

\[
\ell\mapsto v*F
\]

更新为：

\[
\ell\mapsto v'*F.
\]

地址、值或 guard 不唯一时必须 `UNKNOWN`，不能任取一个 model。

### 11.2 有限循环

具体循环不需要 invariant，因为目标是一个有限 derivation，不是任意迭代次数的全称
证明。规则区分：

- guard false：Normal exit；
- body Break：循环 Normal exit；
- body Return：传播 Return；
- body Normal/Continue：递归执行下一轮；
- fuel 为零：`UNKNOWN`。

### 定理 1：有限循环 trace soundness

若表达式求值、body rule 和所有 side obligation 正确，则有限循环 derivation 的 exit
和终态与受支持 C 操作语义一致。

证明对 true guard 的次数归纳。false guard 是基例；Break/Return 直接结束；
Normal/Continue 使用严格更短的剩余 derivation。

### 11.3 visible call

inline call：

1. 求 actual arguments；
2. 建立 fresh local frame；
3. 执行 visible callee body；
4. 传播共享 heap 和 return；
5. 丢弃 callee locals。

callee 契约没有参与执行，所以不需要 callee 的 `With` bind。

### 定理 2：visible-call trace soundness

在参数求值正确、frame freshness 成立、callee body derivation 正确时，inline call 与
受支持 C 操作语义产生相同返回值和共享 heap effect。

证明对 call depth 归纳。

---

## 12. Execution closure 与 evaluation closure

定义：

\[
\mathsf{Foot}_{exec}(\tau)
\]

为影响 trace 的所有地址、值和 allocation status，
\[
\mathsf{Foot}_{obs}(S,c)
\]

为候选目标可能观察的所有位置。

execution-closed 要求：

- 所有 C 参数具体；
- execution footprint 具体且类型正确；
- 每个 guard 唯一化为 concrete Boolean；
- callee visible 且同样 closed，或有显式 trusted model；
- 在 loop/call/recursion bound 内终止。

evaluation-closed 还要求：

\[
\mathsf{Foot}_{exec}(\tau)\cup\mathsf{Foot}_{obs}(S,c)
\]

都被固定，或省略部分具有 checked frame-invariance theorem。

正式 benchmark 最简单可靠的实现是编码完整有限 heap，而不是试图静态猜候选会观察
哪些地址。

---

## 13. 通用化简

每个逻辑 rewrite \(N\) 必须满足：

\[
\Sigma\vdash \phi\leftrightarrow N(\phi).
\]

允许的通用类别包括：

- 闭合整数、Boolean 和受支持浮点表达式；
- 闭合 constructor match、list length/index/slice；
- constructor 一阶统一；
- 对已知 constructor 的透明递归定义受控展开；
- concrete spatial atom 的 cancellation/reconstruction；
- 从闭合公式推出有限域后，在全局上限内枚举。

规则只能查看 typed assertion AST，不能查看程序名、case 名或 corpus 常数。

如果工具只是生成 tactic script，并由 Rocq 在原始目标上检查，则 tactic 本身可以不在
TCB；但规范专门化、状态注入和目标生成仍在 TCB，除非另有证明。

QCP 当前 SMT 处理 LIA 与 UF，不处理量词。因此“所有程序值都具体”不保证任意 Coq
definition、`forall`、`exists` 或归纳谓词都自动结束；未解决目标必须 residual。

---

## 14. QCP 能继承什么

QCP 论文明确给出以下工程结构：

- `proof_goal.v`：所有生成 VC 的声明；
- `proof_auto.v`：自动证明；
- `proof_manual.v`：残余证明；
- `proof_check.v`：通过 Rocq Module Type 检查每个 goal field 都由 auto 或 manual
  module 实现；
- Stellis 空间策略为 deduction step 生成 soundness lemma；
- symbolic executor 使用 Normal、Break、Continue、Return 四种状态；
- 标准 QCP 的 loop 和 call 分别依赖 invariant 与 callee spec。

因此，若 final check 编译且禁止 `Admitted`、新 axiom 等 escape，可以得到：

> 每个被 `proof_goal.v` 列出的 VC 都有 kernel 接受的证明。

但不能直接得到：

> 修改后的 TeSpec VC generator 一定生成了所有必要 VC。

QCP 的 proof coverage 只能证明“列出的目标都被证明”，不能证明“生成器没有漏目标”。
TeSpec 新增的 loop unrolling、callee inlining、exact state、bind adequacy、dual negative
goal 都需要自己的定理。

---

## 15. 条件式端到端定理

设以下条件成立：

1. C 前端和操作语义对受支持 fragment 一致；
2. QCP surface elaboration 充分；
3. canonicalization、exact encoding 和 replay 保持状态；
4. statement、loop、call 的专门化执行规则 sound，且不遗漏 safety obligation；
5. finite binds 有 uniqueness、representative adequacy 或 ghost completeness 证明；
6. normalization/strategy 是 proof-producing，或有等价性证明；
7. SMT 结论进入最终 Rocq proof chain；
8. Rocq kernel 与 whitelist logical context sound/consistent；
9. reference oracle 正确认证正负 case。

### 定理 3：端到端条件可靠性

在条件 1–9 下：

\[
\mathcal J_\Sigma(\mathsf{Goal}_S(c))=\mathsf{PASS}
\Rightarrow
\mathsf{Goal}_S(c)\text{ 在原 QCP 契约语义中为真},
\]

\[
\mathcal J_\Sigma(\mathsf{Goal}_S(c))=\mathsf{FAIL}
\Rightarrow
\mathsf{Goal}_S(c)\text{ 在原 QCP 契约语义中为假}.
\]

这是条件式 system theorem。当前不能写成“由 QCP soundness 直接推出”，因为条件
2–5 包含 TeSpec 新增路径。

---

## 16. Agent 的边界

agent 可以：

- 提出 bind；
- 提出 residual proof；
- 提出正负 heap mutant；
- 生成候选规范。

agent 不能：

- 修改 trusted logical context；
- 引入 axiom、`Admitted` 或不受信任 opaque semantics；
- 直接声明 PASS/FAIL；
- 用终态挑选 bind；
- 在没有充分性证书时把一个 bind 提升为 whole-contract 结论。

只要 bind adequacy、case label 和两种极性的 proof 都由 checker 验证，agent 只影响搜索
成功率和成本，不改变 conclusive verdict 的语义。

---

## 17. 当前原型必须诚实标注的差距

当前 `spec + impl + binds` 路径主要证明：

> 候选自己 materialize 的某个前态、某个逻辑变量实例与一次具体终态相容。

它适合 interactive contract testing，但要形成跨候选 benchmark，还需要：

1. candidate-independent frozen heap；
2. exact-state encoding adequacy；
3. surface elaboration adequacy；
4. 独立的 negative-pre path；
5. 正负 post 标签；
6. bind adequacy 证书；
7. 为目标及其否定生成 dual VC；
8. 每个 conclusive 结果编译最终 `proof_check.v`；
9. 机械化或明确假设修改后 trace executor 的 soundness。

在这些完成前，当前 PASS 最准确的名字是：

> binding-specialized contract consistency。

当前由 diagnostic string 推断的 FAIL 应在 publication mode 降为 `UNKNOWN`，直到存在
opposite-polarity proof。

---

## 18. 论文可以严格声称什么

现在可成立的主要理论贡献是：

1. 给出 heap-transition specification evaluation 的内在语义；
2. 识别 QCP `With` 的全称语义和 bind adequacy 问题；
3. 定义 exact-state satisfaction 与双向 proof judgment；
4. 定义 execution closure 和更强的 evaluation closure；
5. 给出有限循环与 visible call 的局部 soundness proof skeleton；
6. 将 QCP proof coverage 与 TeSpec generator soundness 清楚分离；
7. 定义有限测试下 coverage/precision 的四维指标。

目前不应声称：

- 通过有限 case 等价于完整规范正确；
- 任意 Coq 类型都能自动绑定；
- SMT 能解决所有 closed VC；
- 标准 QCP 已经证明修改后执行器 sound；
- solver failure 是规范反例；
- 半实例化 heap 总是等价于 concrete heap evaluation。

以这个边界投稿，论文适合作为 PL/SE 的 formal-methods system paper。若希望把主要卖点写成
PL-style soundness theorem，最关键的下一步不是增加更多启发式，而是机械化：

1. exact-state encoding adequacy；
2. concrete loop/call rules；
3. bind representative reduction；
4. negative dual-goal bridge。
