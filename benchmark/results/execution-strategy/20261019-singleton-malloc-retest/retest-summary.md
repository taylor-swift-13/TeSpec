# singleton malloc 复测（2026-10-19）

使用 main aee98873a 的当前执行器（SHA256 886ba50b83339375d54a23b2301856068dcab5f19238125991f535e1a5b2e549），实际重跑原来的 7 个输入：INT_MIN、-100、-1、0、1、5、INT_MAX。历史续做编号为 23；第 22 个是 const_example_lessgood。

两种执行策略 × 两种 VC 范围 × 空间 SMT OFF/ON，共 56 次。本次是新测量；执行器与 20261018-contract-modular-final 相同，56 个原始 Goal 哈希也全部匹配。

| 阶段 | 历史分配器阻塞 | 本次 |
| --- | --- | --- |
| 入口 | SAT | 56/56 SAT |
| malloc_node | missing_function_body，无法继续 | 56/56 按契约采样成功 |
| 函数执行 | 未完成 | 56/56 完成，无执行器错误 |
| 返回条件 | 尚未到达 | 每次剩 1 个 Dll 返回 VC |
| 最终结果 | UNKNOWN | 56 UNKNOWN，0 PASS/FAIL/ERROR |

以 element=0 为例，新模型选取节点地址 12288，最终堆中 data=0、prev=0、next=0；仍需证明这三个字段满足 Dll(12288,nil,0,nil)。28 次 SMT ON 均报告 unsupported_spatial_predicate:Dll。分配器契约接通已生效，递归谓词求解仍未完成。

这不是已确认的规约错误，也不能算测试通过。外部 malloc_node 使用原有非空分配器契约，结果作用于该契约模型，不代表测试了真实 libc malloc 实现。单一确定采样策略没有增加分配结果的穷尽性保证。

[逐次结果](results.json)、[分参数结果与成本表](Dbl_Linked_List__singleton/result-cost.md)、[审计](audit.json)、[启动命令](driver-invocation.json)均已保存。时间/RSS 保留 CLI、执行器与空间处理各阶段；阶段嵌套，不相加。原生 token=0；ITP/Coq 未运行，未伪填成本，也未复用不同上下文的旧全称证明给本次测试授予 PASS。整组仍不完整。
