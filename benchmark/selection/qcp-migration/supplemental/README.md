# 22 个 CN 补充输入的 QCP 翻译与验证

本批覆盖全部 22 个补充 C 输入，保留正例、错误例和失败的中间翻译。当前选用的 22 个 QCP 版本中，12 个正常或修正规约版本验证通过，5 个按预期被 QCP 拒绝，另外 5 个有原始 manual VC 的 Coq 否定证书。错误输入没有通过删除失败调用、丢弃资源或使用 Admitted 来改成成功。

## 正例和修正规约版本

| 来源 | 当前版本 | 结果 |
|---|---|---|
| Dbl_Linked_List/singleton.c | dll_singleton | 自动消解 |
| Dbl_Linked_List/add.c | dll_add | 1 个 manual 已证明 |
| Dbl_Linked_List/add_orig.broken.c | dll_add_orig | 同一 C 体补充明确规约；1 个 manual 已证明 |
| Dbl_Linked_List/remove.c | dll_remove | 3 个 manual 已证明 |
| Dbl_Linked_List/remove_orig.broken.c | dll_remove_orig | 同一 C 体补充明确规约；3 个 manual 已证明 |
| array_load.broken.c | array_main_verified | helper 规约增强、本地数组 main 保留；3 个 manual 已证明 |
| transpose.broken.c | transpose_historical | 自动消解；历史 broken 名称不代表 C 体错误 |
| runtime-extras/swap_array.c | runtime_swap_array | 自动消解；trusted main 不在该目标范围 |
| runtime-extras/same_func_malloc_free.c | same_func_asserted | deref、main 和原值断言自动消解 |
| runtime-extras/down_malloc_up_free.c | down_free_asserted_live | 读取、释放和 main 断言自动消解 |
| runtime-extras/up_malloc_down_free.c | up_free_asserted | 分配、初始化、main 断言和释放自动消解 |
| runway/funcs2.c | runway_snapshot | 6 个源函数和 2 个头文件 helper；1 个 manual 已证明 |

当前正例需要填写的 12 个 manual VC 均有 Coq 编译和独立 coqchk 回执。此前的固定数组区域版本另外完成 6 个 manual，作为历史证据保留，不与当前 12 个重复计数。双链表有双向递归资源定义及相应拆分、合并引理，不只验证几个固定长度列表。

## 按预期拒绝的输入

| 来源 | QCP 拒绝原因 |
|---|---|
| slf0_basic_incr.signed.broken.c | 只有 undefined cell 权限，不能安全读取并执行 signed 加法 |
| slf0_incr.broken.c | 同上；原 Block 值用于整数运算的注解也无法直接作为已初始化整数值照译 |
| slf5_basic_aliased_call.broken.c | incr_two 的分离前提要求两份资源，实际传入同一单元两次 |
| runtime-extras/bad_free.broken.c | 空前置条件不能保证释放权限 |
| runtime-extras/double_free.broken.c | 第二次释放时已无所有权 |

这些状态记录为 EXPECTED_REJECTION，保留 QCP 原始错误、版本、命令及源码哈希。未初始化/弱值前提的两个 signed 例还用 INT_MAX 单元触发了 UBSan 溢出；该输入属于 QCP undefined cell 所允许的忘却值域，不把它描述成 MemorySanitizer 的未初始化读取检测。别名例的 C 值计算可以得到预期结果，但其模块化调用合同不成立；不把它误报为 C 函数的值结果错误。

## 已正式否定的 manual VC

| 来源 | 被否定的原始 VC | 实际问题 |
|---|---|---|
| read.broken.c | read_return_wit_1 | 读取之后单元仍存在，空资源后置条件不成立 |
| runtime-extras/leaky.broken.c | leaky_get_return_wit_1 | 输入单元未释放或返回所有权 |
| runtime-extras/leaky_main.c | main_return_wit_1 | main 返回时仍有分配 |
| slf14_basic_succ_using_incr_attempt.broken.c | succ_using_incr_attempt_return_wit_1 | 返回整数却遗留内部申请的单元 |
| runtime-extras/return_owned_local.broken.c | main_return_wit_1 | main 的资源清空目标不成立；另有返回参数栈地址问题 |

反证直接针对原生 QCP 导出的原始 VC，两个可选分支都被否定，没有另造较弱命题。证书构造有限 QCP 字节堆，给出满足左侧 points-to 的具体状态，再证明该状态不满足 emp。最后一项使用两个不重叠单元的状态反证 main 返回 VC；它不是 bad 函数单独生命周期 VC 的否定证明。bad 的返回栈地址缺陷由编译器警告和 sanitizer 执行另行支持。

这些记录是 REFUTED_ORIGINAL_MANUAL_VC，不是验证通过。泄漏 succ 中正常的 incr helper 通过复用已内核检查的核心证明完成其 manual，不能将正常 helper 的取模义务与泄漏反证混在一起。

另附 9 份实际 C 观测：双重释放、非法释放、signed 溢出和逃逸地址的 sanitizer 失败；三个返回时 live allocation 等于 1 的分配计数；read 保留单元的观测。C 观测与 Coq 否定证书分别记录，不能把一份测试日志当成全称程序证明。

## 规约修正和工具适配

数组 weak helper 只承诺出口数组所有权，不能在调用后推出返回元素或内容保持。本批另建增强版，保证返回 Znth(i,l,0) 且数组仍为 l。原本的本地三元素数组和 main 流程保留，只把函数调用中的数组衰变地址写成等价的 (int*)&a，以绕过工具中 offset-zero 与原始数组根地址匹配失败。断言同时保留活跃局部变量的值快照，避免 QCP Assert cut 丢弃它们的存储权限，也避免显式重复 data_at。两个 ABI 的 C 对照均通过原来的六个物理值断言。

跑道原 valid_state 包含多个析取和蕴含，直接展开会超过分支限制。替代线性表达在整数域上与原定义等价，有 RunwayValidEquivalence.v 定理。结构体按值调用存在隐藏 With 参数无法绑定的问题，显式绑定尝试还产生崩溃；当前版本将小型 helper 调用展开为等价字段更新，保留 entry-value 快照，避免出口规约错误要求已经过期的参数存储。原 C tick 与展开版在 1,045 个满足前提的边界状态上结果相同，并满足出口性质；这补充规范化证据，不声称完整 C 精化证明。

双链表的 orig.broken 两个文件本身没有函数合同，本批从对应的带注解版本补上 QCP 合同；不将其称作原合同的等价翻译。字段资源使用 QCP 模型，完整 CN 对象及 ABI 对应仍与同输入 CN 重跑分开处理。

## 证据入口和重放

registry.json 是 22 项当前状态清单，manifest.json 同时保存历史变体。manual-proof-receipts.json 保存正例 manual 回执，negative-proof-receipts.json 保存否定回执。原生 QCP 输出位于每个版本的 native 目录，失败尝试不删除。

在匹配的 Coq 8.20 和已构建 QCP SeparationLogic 运行库环境中：

```sh
python3 replay.py --runtime /path/to/QCP/SeparationLogic
```

该脚本重放 manual、资源引理、规范编码等价和否定证书。自动部分采用原生 QCP 求解结果，allocator/free 等外部接口仍是明确假设。没有重跑固定版本的 CN，也没有完成 CN 与 teSpec 的同输入配对。计数单位是来源 C 文件，不能把变体数、函数数和 VC 数直接相加。
