# TeSpec 定理、引理与关键假设中文翻译

本文档按英文论文中的出现顺序翻译形式化陈述。为避免夸大结论，每一项标明其性质：

- **假设**：端到端结论依赖它，但当前论文没有给出完整机械化证明；
- **引理／命题／定理**：论文给出证明或证明草图；
- **条件式系统定理**：只有列出的前提全部成立时才能使用。

---

## 1. 断言展开充分性

**性质：假设，目前属于 TCB。**

对于任意类型正确且属于受支持语法片段的表层断言 \(U\)、程序状态 \(\sigma\) 和
ghost 环境 \(\eta\)，如果：

\[
\Sigma;\Gamma_C;\Gamma_G\vdash U\Downarrow_A A,
\]

那么：

\[
\sigma,\eta\models_{\mathrm{surface}}U
\quad\Longleftrightarrow\quad
\sigma,\eta\models_\Sigma A.
\]

### 中文解释

QCP 前端把用户写的 C-like assertion \(U\) 展开为内部 separation-logic assertion
\(A\)。该假设要求展开前后的真值完全一致。

如果不满足这一点，即使 Rocq 完美证明了内部目标，也只能说明“翻译后的目标正确”，
不能说明原始 QCP 注释正确。

---

## 2. 输出非干扰引理

**性质：引理，直接由 binder 接口得到。**

如果一个 binder 只依赖初态，那么从同一输入：

\[
x=(a,\sigma_0)
\]

开始的正确执行和所有 mutant 执行都会得到相同的 ghost 候选集合。

### 证明

绑定器的定义域只有：

\[
\mathcal B_S:A\times\mathsf{State}
\rightharpoonup
\mathcal P_{\mathrm{fin}}(\llbracket\Gamma_G\rrbracket).
\]

其中没有返回值、终态或 case 标签。因此，只要 \(a,\sigma_0\) 相同，结果就不能随
输出变化。

### 边界

该引理只证明 binder 不偷看输出，不证明这个 bind 能代表整个 `With` 契约。后者还需要
唯一性、充分代表元或 ghost-completeness。

---

## 3. Heap canonicalization 不变性

**性质：命题，目前正文给出结构归纳证明草图。**

设 \(A\) 是地址参数化断言，\(\mu\) 是保持 block 类型、大小、offset、cell、root 和
pointer edge 的 heap 同构。如果 store 和 ghost pointer 也一致地由 \(\mu\) 重命名，
则：

\[
(\rho,h),\eta\models A
\quad\Longleftrightarrow\quad
(\mu(\rho),\mu(h)),\mu(\eta)\models A.
\]

### 证明思路

对断言 \(A\) 的结构归纳：

1. 纯标量命题不依赖 heap 地址；
2. pointer equality 和同一 block 内 offset 被 \(\mu\) 保持；
3. points-to atom 由 cell 和 pointer edge 保持；
4. separating conjunction 的不相交 heap 分割可以通过双射 \(\mu\) 搬运；
5. 递归谓词对其推导结构归纳。

### 不适用范围

如果程序或规范把 pointer cast 成整数、比较无关 pointer 的数值大小，或依赖分配器产生
的具体地址，则不能使用该命题。

---

## 4. 精确状态编码充分性

**性质：假设，是 TeSpec 最重要的新证明义务之一。**

设 \(\mathsf{Enc}(\sigma)\) 精确编码 concrete state \(\sigma\)。对任意受支持且地址
参数化的内部断言 \(A\)：

\[
\sigma\models_\Sigma A
\quad\Longleftrightarrow\quad
\mathsf{Eval}_\Sigma(\mathsf{Enc}(\sigma),A).
\]

其中 \(\mathsf{Eval}_\Sigma\) 是提交给 Rocq 检查的语义命题。

### 中文解释

该假设是 concrete heap 与 QCP/Rocq assertion 之间的桥梁。它要求逻辑编码既不能丢
cell，也不能悄悄增加不受约束的 symbolic frame。

正向证明失败不能推出断言为假。负向结论必须证明：

\[
\neg\mathsf{Eval}_\Sigma(\mathsf{Enc}(\sigma),A),
\]

或者使用带完备性定理的 checked countermodel。

---

## 5. 外延正确性定理

**性质：集合论定理，已给出完整的直接证明。**

参考规范的输入集和结果集记为：

\[
I_R,\qquad T_R(x).
\]

候选规范对应：

\[
I_S,\qquad T_S(x).
\]

候选同时满足输入覆盖、输入精确、transition 覆盖和 transition 精确，当且仅当：

\[
I_S=I_R
\]

且：

\[
\forall x\in I_R.\ T_S(x)=T_R(x).
\]

### 证明

集合相等当且仅当两个方向的包含关系都成立：

\[
I_R\subseteq I_S
\land
I_S\subseteq I_R
\iff
I_R=I_S.
\]

对每个 \(x\) 的结果集合应用同一事实即可。

### 边界

有限 benchmark 只能采样这些集合包含关系，不能由有限 case 推出完整外延相等。

---

## 6. Verdict 互斥定理

**性质：定理，依赖 trusted logical context 一致。**

如果逻辑上下文 \(\Sigma\) 一致，则任意闭合目标 \(\phi\) 不可能同时获得有效的
`PASS` 证书和有效的 `FAIL` 证书。

### 证明

`PASS` 证书证明：

\[
\Sigma\vdash\phi.
\]

`FAIL` 证书证明：

\[
\Sigma\vdash\neg\phi.
\]

若二者同时存在，则 \(\Sigma\) 同时证明 \(\phi\) 和 \(\neg\phi\)，与一致性矛盾。

---

## 7. 实例 verdict 可靠性定理

**性质：定理，依赖 proof checker 对 \(\Sigma\) 语义可靠。**

假设 proof checker 对逻辑上下文 \(\Sigma\) sound，则：

\[
\mathcal J_\Sigma(\mathsf{Goal}_S(c))=\mathsf{PASS}
\Longrightarrow
\mathsf{Goal}_S(c)\text{ 为真},
\]

并且：

\[
\mathcal J_\Sigma(\mathsf{Goal}_S(c))=\mathsf{FAIL}
\Longrightarrow
\mathsf{Goal}_S(c)\text{ 为假}.
\]

### 证明

`PASS` 要求 checker 接受 \(\mathsf{Goal}_S(c)\) 的证明，因此由 checker soundness
得到目标为真。

`FAIL` 要求 checker 接受：

\[
\neg\mathsf{Goal}_S(c)
\]

的证明，因此原目标为假。

### 重要推论

solver timeout、无法 derive memory precondition 或 QCP diagnostic 都不满足该定理对
`FAIL` 的要求。只有相反极性的 checked proof 才能产生 definitive `FAIL`。

---

## 8. Proof budget 单调性命题

**性质：命题。**

增加 proof-search budget 可以把 `UNKNOWN` 变成 `PASS` 或 `FAIL`，但不能可靠地翻转
一个已经认证的 `PASS` 或 `FAIL`。

### 原因

已经认证的 verdict 有稳定 proof object。增加搜索预算不会使原 proof 失效。如果新的
搜索同时得到相反极性的 proof，则说明 trusted context 不一致，而不是正常的 verdict
翻转。

---

## 9. 有限循环 trace soundness

**性质：定理，目前是 paper-level proof sketch；完整系统需要机械化或列入 TCB。**

假设：

1. 表达式求值 sound；
2. 局部 load/store rule sound；
3. 有限循环 derivation 产生的所有 side obligation 都有效。

则 derivation 得到的 exit kind 和终态与受支持 C 操作语义一致。

### 证明思路

对 guard 求值为 true 的次数归纳。

- 基例：guard 为 false，循环直接以 Normal 退出；
- body 产生 Break：循环以 Normal 退出；
- body 产生 Return：传播 Return；
- body 产生 Normal 或 Continue：对严格更短的剩余迭代使用归纳假设。

### 结论范围

该定理只证明一个已经终止的有限 trace，不证明循环对所有输入或任意迭代次数正确。
因此这一具体 derivation 不需要 loop invariant。

---

## 10. Visible-call trace soundness

**性质：定理，目前是 proof sketch。**

假设：

1. actual arguments 的求值类型正确；
2. callee local frame 是 fresh；
3. visible callee body 的 derivation sound。

则 inline call rule 返回的值和共享 heap effect 与受支持 C 操作语义一致。

### 证明思路

对 call depth 归纳。由 frame freshness，丢弃 callee locals 不会改变 caller store 或
共享 heap；callee body soundness 给出返回值和 heap effect。

### 结论范围

因为这里执行的是 callee body，而不是使用 callee contract，所以不需要 callee 的
`With` bind。但是外部或不可见函数仍需要显式 trusted transition model，否则结果是
`UNKNOWN`。

---

## 11. 专门化保持引理

**性质：引理，依赖每条 normalization rule 的等价性。**

设 \(\theta\) 把类型正确的 concrete arguments、ghost values 和 states 代入 \(P\) 或
\(Q\)。如果 normalization 仅使用保持等价的规则，并产生：

\[
N(\theta(\phi)),
\]

则：

\[
\Sigma\models\theta(\phi)
\quad\Longleftrightarrow\quad
\Sigma\models N(\theta(\phi)).
\]

### 证明

由类型正确替换的语义保持性，以及每一步 normalization 的等价性定理复合得到。

如果工具生成 tactic script，并由 Rocq 直接在原目标上检查，则 tactic 搜索本身不必
进入 TCB；但 concrete substitution 和目标生成仍必须正确。

---

## 12. 终态契约充分性定理

**性质：条件式定理。**

假设：

1. statement、loop 和 call 执行规则 sound；
2. exact-state encoding 充分；
3. surface assertion elaboration 充分；
4. specialization preservation 成立；
5. checker 接受以下命题的证明：

\[
\mathsf{ExecVC}(f,a,\sigma_0,r,\sigma_1,\tau)
\land
\mathsf{Conf}_S(x,y).
\]

则观察到的 C 执行确实终止于：

\[
(r,\sigma_1),
\]

并且候选契约在输入 \(x\) 和结果 \(y\) 上成立。

### 证明

局部 statement rule、有限循环定理和 visible-call 定理建立实际 C execution。编码、
展开和专门化保持性把 checked closed proposition 连接回原始 QCP 契约语义。

### 不推出的结论

该定理不证明：

- \(f\) 的所有执行都满足 \(Q\)；
- 候选规范在未测试输入上正确；
- \(Q\) 与自然语言意图完全一致。

---

## 13. Agent containment 定理

**性质：条件式定理，目前给出证明草图。**

假设：

1. bind 类型正确，并通过 pre-state-only API 产生；
2. 每个 whole-contract verdict 都有 checked adequate-representative 或
   ghost-completeness certificate；
3. candidate 和 proof 文件不能增加 axiom 或修改 trusted context；
4. 自动 proof 和 agent proof 只有经过 checker 后才接受；
5. case label 由独立 oracle 认证。

则 agent 输出的文本不能直接制造一个错误的 conclusive verdict。

### 证明思路

- bind 不依赖输出；
- bind adequacy proof 把有限实例连接到 `With` 的全称语义；
- candidate 只能定义待证明命题，不能扩展逻辑来证明自己；
- proof 必须通过 checker；
- agent 提出的 case 必须由独立 oracle 认证。

因此 agent 可能导致搜索失败、拒绝或 `UNKNOWN`，但不能绕过 trusted judgment。

### 边界

如果缺少第 2 条，定理只保证 agent 不能伪造当前 bind 对应的 indexed proposition；
不能把该结果提升为整个 QCP 契约的结论。

---

## 14. 端到端条件可靠性定理

**性质：论文最强的系统定理，但目前是条件式 theorem，不是完整 mechanized theorem。**

假设 A1–A9：

1. C frontend 和操作语义在受支持 fragment 上一致；
2. surface assertion elaboration 充分；
3. canonicalization、exact encoding 和 replay 保持状态；
4. concrete statement、loop、call 规则 sound，且生成所有必要 safety obligation；
5. finite binds 有 uniqueness、adequate-representative 或 ghost-completeness proof；
6. normalization 和 strategy 是 proof-producing，或有 checked equivalence；
7. SMT 成功进入最终 Rocq proof chain；
8. Rocq kernel 和白名单逻辑上下文 sound 且 consistent；
9. reference oracle 正确认证正负 case。

则每个 `PASS` 都证明 frozen concrete case 上的预期候选 pre/post proposition，每个
`FAIL` 都证明其否定。

形式化地：

\[
\mathcal J_\Sigma(\mathsf{Goal}_S(c))=\mathsf{PASS}
\Longrightarrow
\mathsf{Goal}_S(c),
\]

\[
\mathcal J_\Sigma(\mathsf{Goal}_S(c))=\mathsf{FAIL}
\Longrightarrow
\neg\mathsf{Goal}_S(c).
\]

### 证明思路

1. A1–A4 把 execution artifact 连接到实际 concrete C behavior；
2. A2–A3 把表层规范和 canonical heap 连接到内部逻辑；
3. A5 把有限 bind 连接到 `With` 的全称语义；
4. A6–A8 和 specialization preservation 把 checked goal 连接到原契约；
5. 实例 verdict 可靠性给出目标的正确极性；
6. A9 把候选目标的极性连接到 coverage/precision case label。

### 与 QCP 的关系

QCP 的 `proof_goal.v`、`proof_auto.v`、`proof_manual.v` 和
`proof_check.v` 能支持 A6–A8 中“所有已生成 VC 都有 checked proof”的部分。

它不能自动证明：

- TeSpec 修改后的 executor 没有漏 VC；
- exact heap encoding 正确；
- bind 能代表 `With` 的全称语义；
- negative dual goal 生成正确。

因此该定理目前必须称为“端到端条件可靠性”，不能写成“由 QCP soundness 直接得到的
无条件定理”。
