# Fulminate 原例：迁移结果与剩余工作

先用 QCP 验证，再判断 teSpec 的缺口。本轮已经迁移 12 个原始文件中的 25 个目标函数，详见 [迁移报告](qcp-migration/README.md) 和 [原始证据](qcp-migration/evidence/20261014/report.json)。分配、释放、链表、队列和栈不能仅凭涉及动态内存就归入“不支持”。

## 已经迁移并运行

| 原例 | 原生 QCP 结果 | teSpec 的当前情况 |
|---|---|---|
| `slf10_basic_ref.c` | 分配后写入的目标义务自动消解 | 缺少分配接口的执行体 |
| `slf11_basic_ref_greater.c` | 无符号回绕相关义务仍有残留 | 执行到分配接口后未完成 |
| `slf12_basic_ref_greater_abstract.c`、`slf13_basic_ref_with_frame.c` | 两个目标义务自动消解 | 执行到分配接口后未完成 |
| `slf16_basic_succ_using_incr.c` | 目标义务消解，辅助函数 incr 有残留 | 需要分配、释放接口 |
| `slf17_get_and_free.c` | 读取后释放的目标义务自动消解 | 缺少释放接口的执行体 |
| `list_all.c` | 7 个目标完成运行；构造器自动消解，6 个目标有残留 | 分配/释放接口、入口证明与调用绑定分别记录；不是全部无法执行 |
| `queue_all.c` | empty、push、pop 全部自动消解；保留原版可信 push 引理 | 需要分配、释放接口 |
| `slf_sized_stack.c` | create、sizeOf 自动消解；push、top、pop 有残留 | 创建/更新涉及接口；只读操作仍需入口证明 |
| `slf18_two_dice.c` | two_dice 目标义务消解；val_rand 有残留 | 缺少 rand 执行接口与共享轨迹 |
| `runtime-extras/same_func_malloc_free.c`、`double_free.broken.c` | 单次释放消解；第二次释放的 Require 被拒绝 | 当前停在分配接口，尚未执行到重复释放 |

自动消解是自动证明阶段的结果，尚未独立通过 Coq 内核检查。表中按目标函数报告，不将辅助函数的残留义务或未迁移的原始 main 隐去。

teSpec 的两种模式目前都执行调用；为普通外部函数声明一个后置条件，不能替代它的执行体。此次 192 次重放为 UNKNOWN：148 次缺少函数体，36 次需入口证明，8 次调用绑定未完成。原生 QCP 则能使用外部函数的契约进行模块化推理。这是本轮测出的具体差异。

## 尚待迁移与验证

- `list_all.c` 的其余函数、`queue_all.c` 的另一版 push、完整驱动仍待迁移。
- `mergesort.c` 的 split/merge/mergesort 仍待迁移。锁定版本的 main 为空；不能把该文件说成因 main 中分配节点而无法运行。
- 双链表、其余 runtime-extras 和其他 CN 原例保留在完整清单中。`bad_free.broken.c` 的问题涉及缺少所有权契约，不能仅凭文件名判断为普通 C 的非法 free。
- pKVM buddy allocator 需要完整契约对应、指针宽度/字节编码及页资源转换，见 [ABI 审计](../paper-cn-qcp/expansion80/evidence/pkvm-qcp-abi-20261013/report.json)。

后续先实现或接入语义明确的类型化分配、释放接口，再重放真实调用序列；同时继续补证明和迁移剩余原例。不能以固定指针、空 free 或手写最终状态代替这些操作。原始 CN 输入始终保存在 [来源快照](sources/fulminate-cn/src/examples)，不会用现代教程的成功结果冒充历史版本的覆盖。
