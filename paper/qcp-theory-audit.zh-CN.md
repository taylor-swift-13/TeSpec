# 基于 QCP 论文的 TeSpec 理论审计

参考：Xiwei Wu et al., *QCP: A Practical Separation Logic-based C Program
Verification Tool*, arXiv:2505.12878v3, 2026。

本文档只记录“QCP 论文实际支持什么”和“TeSpec 还需要证明什么”，避免引用越界。

## QCP 论文直接给出的事实

| QCP 机制 | 论文中的证据 | TeSpec 可安全引用的结论 |
|---|---|---|
| Symbolic execution | 计算 strongest postcondition 并生成 VC | QCP 是合适的 VC 后端 |
| Partial statements | 执行状态含 Normal、Break、Continue、Return | TeSpec 的 concrete executor 应保持这四种 exit |
| Memory access | 需要分离逻辑 entailment 获得 cell 和 frame | TeSpec 不能把“具体值已知”当作跳过权限证明 |
| Function call | 标准 QCP 使用 callee pre/post | TeSpec inline call 是新规则，不是原规则的直接实例 |
| Loop | 标准 QCP 使用 invariant 汇合状态 | 无 invariant 的 finite unrolling 是 TeSpec 新规则 |
| Entailment solver | Stellis 规则生成 deduction soundness proof | checked spatial strategy 不必信任 agent |
| SMT | LIA + UF；不支持 quantified formula | concrete substitution 不保证所有 VC 自动 |
| Proof files | goal / auto / manual / check 四部分 | final module check 可保证列出的 VC 全被覆盖 |
| Rocq library | C memory model与 separation logic library | 可复用内部断言语义和 kernel checking |

## QCP 论文没有给出的元定理

QCP 论文是工具与系统论文。它描述 proof-producing solver 和 Rocq artifact，但没有在论文
正文中给出一个覆盖整个 C parser、symbolic executor、VC generator 的机械化
end-to-end soundness theorem。因此不能写：

> TeSpec 修改 QCP 后仍然自动继承 QCP 的完整可靠性。

能写的是：

> 对每个 TeSpec 已经生成并列入 Module Type 的 VC，若最终 Rocq module check 成功，则
> 该 VC 有 kernel 接受的证明。

二者差别在 VC generator 是否漏掉或错译了 obligation。

## TeSpec 新增且必须单独处理的四个桥接

### 1. Surface-to-internal bridge

需要证明 QCP 注释表层语义与内部 separation assertion 一致。特别是 C-like heap
expression 不只是纯值表达式，它包含访问权限和空间资源。

### 2. Concrete-trace bridge

需要证明 finite loop unrolling 和 visible call inlining 与受支持 C 操作语义一致，并
保留 Break、Continue、Return、fresh frame、memory safety 和 definedness。

### 3. Concrete-state bridge

需要证明 canonical heap 的逻辑编码精确表示一个 concrete state，而不是一组带 symbolic
frame 的 completion。

### 4. Bind-to-contract bridge

需要证明有限 bind 能代表 `With` 的全称语义。充分条件是唯一性、后置观测等价的充分
代表元，或 ghost-complete 有限集合。

## 对当前 verdict 的严格要求

| 观察 | 可以推出 | 不可以推出 |
|---|---|---|
| `proof_check.v` 编译成功 | 所有列出的 VC 有 proof | VC generator 没漏目标 |
| QCP 自动证明正向目标 | 对应目标成立 | 整个候选规范全称正确 |
| 无法 derive memory precondition | 当前 symbolic execution 被阻塞 | 测试目标的否定成立 |
| SMT 未解决 | 自动化不完备 | 目标为假 |
| SMT 在中间路径发现矛盾 | 该符号路径/obligation 不一致 | benchmark case goal 必然为假 |
| dual Rocq goal 编译成功 | 原目标为假 | 无需额外解释 |

## 建议的形式化优先级

1. 在 Rocq 定义 canonical finite state 与 `Enc`，先证明 array/struct/sll/dll 片段的
   encoding adequacy。
2. 给 QCP partial-statement executor 增加 concrete derivation relation，对 loop 与
   visible call 证明 soundness。
3. 在 contract 层定义 `Dom`、`Conf`、adequate representative，并证明 singleton 与
   finite-set reduction lemma。
4. 生成真正的 dual semantic goal；把所有 diagnostic-based FAIL 降为 UNKNOWN。
5. 最后把上述 theorem 与 QCP Module Type proof coverage 组合成端到端 theorem。

这条路线比继续增加 case-specific simplifier 更能支撑 PL 论文；对 SE 论文，也能形成
清晰的 architecture assurance story。
