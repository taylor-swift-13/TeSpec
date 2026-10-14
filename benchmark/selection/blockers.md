# Fulminate 原例的当前执行障碍

这里按原始 C 代码和当前 teSpec 的执行接口区分能力缺口。历史 CN 版本尚未全部完成 QCP 移植；以下是源码与接口核对结果，不是对这些原始文件新跑出的逐例 verdict。

## 明确需要执行器或运行接口支持

| 原例 | 原始操作 | 当前缺口 |
|---|---|---|
| `slf10_basic_ref.c` 及 ref 派生例 | `refUnsignedInt` 调用 `cn_malloc`，创建新对象 | teSpec 缺少该外部接口的完整分配模型；只声明契约不能完成实际执行 |
| `slf17_get_and_free.c` | 读取后调用 `cn_free_sized` | 需要对象失效、释放权限和分配块生命周期语义 |
| `list_all.c` | 构造、复制、释放列表；累计长度辅助单元 | 完整程序调用分配释放；已有节点上的 length/reverse/append 可以单独测试 |
| `queue_all.c` | 创建队列、push 分配、pop 释放 | 完整操作序列需要新节点和释放模型，另外要保持首尾所有权关系 |
| `slf_sized_stack.c` | 创建、push、pop 与动态节点 | 同时需要生命周期和大小/内容关系检查 |
| `mergesort.c` | main 构造节点，再执行 split/merge/sort | 原始完整驱动需要分配接口；排序本身不应归为“不能执行” |
| `runtime-extras/bad_free.broken.c`、`double_free.broken.c` | 非法释放、重复释放 | 需要明确的分配块身份与已释放状态，不能以 UNKNOWN 作为检出 |
| pKVM buddy allocator | 页池初始化、切分、引用计数、释放和合并 | 完整 CN/QCP 契约对应、指针宽度/字节编码/页资源转换与整段轨迹尚未完成 |

原始 CN 输入位于 [sources/fulminate-cn/src/examples](sources/fulminate-cn/src/examples)。当前控制器对缺少实现的被调用函数保留 `missing_function_body`；相关回归是 `tests/test_candidate_executor.py` 的外部函数测试。pKVM 的具体布局检查见 [ABI 审计](../paper-cn-qcp/expansion80/evidence/pkvm-qcp-abi-20261013/report.json)，现有单边及内存扩展见 [内存报告](../paper-cn-qcp/review-20261014/memory-expansion/summary.json)。

## 可以通过实验接口补齐

`slf18_two_dice.c` 调用 `rand()`。需要固定双方相同的随机状态或随机结果轨迹，并记录接口语义。这属于可重放输入与外部函数支持问题，不能据此推断算法无法处理该例。

历史版本还使用旧 CN 语法、`cn_malloc` 和 `cn_free_sized` 等接口。移植时保留原版快照，另存现代版本、变更说明和规约对应依据。已有现代教程版本的 PASS 不直接归给历史原版。

## 执行能力与证明完成分开

`runtime-extras/leaky.broken.c`、`return_owned_local.broken.c` 涉及所有权丢失或局部对象生命周期。完整驱动也依赖分配接口，但提取被测函数后能否检出原错误，还需要核对原始义务和当前函数边界规则；仅凭文件名不能列为已确认的不支持项。

链表、树、递归、复杂后条件本身不是自动排除理由。已有 ABI32 链表实验完成了三个参考批次，每批 128 个输入，见 [证明进度](../paper-cn-qcp/expansion80/list-proof-progress-20261013.md)。其中冻结 ATP 结果与后续 ITP 结果分别保存；未决的负例仍报告 UNKNOWN。

对每个完整原例，清单保留“源文件已收录、配对待完成”的状态。后续先建立最小分配/释放语义及共享外部接口，再运行真实原始调用序列；不使用返回固定指针、空 free 或手写最终状态替代原程序。
