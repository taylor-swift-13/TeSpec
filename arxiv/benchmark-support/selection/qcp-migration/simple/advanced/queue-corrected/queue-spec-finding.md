# 队列 CN 原合同反例与 QCP 规约修正

2026 年 10 月 15 日

原始 `queue_all.c` 的 `push_induction` 合同允许内部节点别名，使其后置条件不成立。原文件还声明了一个无前提的指针不等 lemma，并在递归调用前使用它。修正后的 QCP 版本使用标准分离逻辑链表段，保留追加后的序列关系，并证明剩余 manual VC。原 CN 文件、原翻译和反例均保留。

## 原 CN 合同为什么不成立

原 `IntQueueAux(f,b)` 遇到 `f == b` 就停止，返回空序列；否则拥有当前节点并继续递归。helper 前置条件拥有 `IntQueueAux(front,p)` 和节点 `p`，只额外要求 `front != p->next` 以及 `p->next != NULL`。后置条件要求 `IntQueueAux(front,p->next)` 的序列等于调用前序列追加 `p.first`。

取三个不同且已分配的节点：

```text
节点    first    next
f       1        z
z       2        p
p       3        z
```

调用 `push_induction(f,p)` 时，前置条件成立，原谓词的调用前序列是 `[1,2]`。函数递归至 `p` 返回，不修改节点。后置条件以 `z` 为终点，从 `f` 走到 `z` 就停止，实际序列为 `[1]`，而合同要求 `[1,2,3]`。递归调用所需的 `z != p->next` 同样不成立。

同一原函数体的 C 反例在 32 位和 64 位执行中均得到：前置条件成立、后置条件不成立。另有 Coq 定理证明守卫式逻辑图上的相同反例。逻辑图证书并非完整 QCP 字节堆 SAT 证书。

## 原文件中的错误 lemma

```c
lemma assert_not_equal(pointer x, pointer y)
requires true;
ensures !ptr_eq(x, y);
```

该声明对任意指针声称不等，取 `x == y` 即可否定。原 helper 在递归前执行：

```c
/*@ apply assert_not_equal((*front).next, (*p).next); @*/
```

上述反例使这两个实参都是 `z`。如果 CN 将该声明作为未证明的假设接受，函数检查就可能依赖错误假设通过；若证明 lemma 本身，则该结论不成立。固定版本的 CN 尚未在本次工作中重跑，因此不把这个发现表述为 CN 验证器缺陷或已复现的 CN 成功日志。`push_lemma` 也在原文件中标记为 trusted，不能把它的合同当作已经证明的结论。

## 正确的 QCP 合同

修正版使用 QCP 运行库的标准 `sllseg(f,b,l)`。它按有限序列长度定义：空序列要求 `f == b`，非空序列拥有当前节点并递归处理尾部。非空分支不额外要求当前节点与终点不同。这与 CN 的遇到终点即停止的定义不同，属于明确的规约修正，不声称 CN 与 QCP 等价。

```c
/*@ With x n (l: list Z)
    Require p != 0 && sllseg(front,p,l) *
            data_at(&p->data,int,x) *
            data_at(&p->next,struct list*,n)
    Ensure sllseg(front,n,app(l,cons(x,nil))) */
```

分离合取保证链表段资源与 `p` 的字段资源不重叠；`p != 0` 明确保证追加节点非空。标准链表段的单节点构造和连接定理即可证明后置条件，不需要无依据的不等指针假设。helper 的 C 控制流保持原样；布局名称 `int_queueCell/first` 映射到 QCP 现有的 `list/data`。

调用者仍保证队列内容为旧序列追加新值，并保留队列前后指针、尾节点和完整所有权。它无需排除正常队列输入，也没有把后置条件弱化为任意存在值。分配和释放接口继续采用显式外部合同。

## 验证与结果范围

修正版原生 QCP 正常完成：`push_induction` 自动消解 2 个 VC，剩余 2 个 manual；`IntQueue_empty`、`IntQueue_pop`、`IntQueue_push_induction` 分别自动消解 4、6、10 个 VC。两个人工证明和新增策略所用资源引理均写为 `Qed`，不导入自动证明占位文件，不使用 `Admitted` 或错误指针不等假设。

最终内核检查结果及源码、策略、证明哈希记录在 `advanced/queue-corrected/verification-receipt.json`；原始运行结果记录在该目录的 `report.json`。自动部分按 QCP 求解结果计，manual 部分由 Coq 检查。这不同于将整个修正版的所有自动 VC 再作独立 Coq 证明。

原 CN 版本的失败结论继续记录在 `advanced/queue-guarded/finding.json`，具体 C 反例见 `advanced/queue-counterexample/`。修正版单列在 `advanced/queue-corrected/queue_corrected.qcp.c`，不覆盖锁定的 CN 源码。

## 采用的方案与选择理由

本 benchmark 采用标准 QCP `sllseg` 方案。helper 的合同使用 `p != 0`、旧链表段与尾节点字段的分离所有权，后置条件仍要求序列追加尾节点值。该源码和合同已实际写入 `queue_corrected.qcp.c`；22 个自动 VC 已消解，2 个 manual VC 及支撑资源引理已完成证明和内核检查。

选择该方案是因为 QCP 运行库已有单节点构造和链表段连接定理，调用者能满足合同，不需要增加新的整段无别名谓词。它适合当前先完成正确 QCP 验证的目标。它改变了原 CN 守卫式谓词的语义，这一差异保持显式记录。

另一方案是保留原守卫式谓词，并要求新终点不出现在旧链表段的任何节点中。这更接近原 CN 语义，但需要额外定义整段无别名性质、证明递归保持，并证明分配新节点的调用者满足它。只增加入口 `front != p->next` 不足以保证递归调用成立；原合同已经包含该条件。将 `assert_not_equal` 的前提改为 `x != y` 只能使 lemma 自身正确，不能替调用者证明该前提。
