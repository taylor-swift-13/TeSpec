# 第 21 组 array_load：完整父 VC 审查（2026-10-21）

本轮保留全部程序、规约、输入和逐输入预期，在唯一 main 工作树上继续处理第 21 组。重跑 67 对输入的 inline/modular 与空间 SMT OFF/ON，共 268 次实际执行；原 CN/QCP 主程序证据与 Fulminate 67/67 测试不重复计费。

## 当前结果

inline：OFF 原生 65 PASS、2 UNKNOWN，完整原始目标与已有内核证书匹配后 67 PASS；ON 原生 67 PASS。modular：每个空间配置原生 65 PASS、2 UNKNOWN；translation7 的完整目标与已有证书精确匹配，最终 66 PASS、1 UNKNOWN。唯一剩余项是 original_client_translation12_only_entry，原预期 PASS 保留，未把 UNKNOWN 算成成功。

## 为什么完整父目标仍未决

read 的弱规约只保证存在某个数组后态，不保证返回值，也不保证原数组内容不变。客户端却断言返回 0、1、2，并要求数组仍为 [0;1;2]。inline 执行函数体可获得这些值；modular 使用该合同无法得到这些信息。这不等于 read 的实现错误，也不能据此声称整个 CN 数据集错误。

本次 ITP 直接分析原始 main_entail_wit_6 的两个分支，未用辅助 split_goal 的反证冒充父目标反证。诊断候选给出八个引理：纯分支为假、父目标等价于完整空间分支、空间模型的等价刻画、空间前件无模型时父目标成立、完整反证必须排除这种空前件情况、无效局部地址导致无模型、无效地址下父目标成立，以及显式空间反模型足以反证父目标的条件定理。

空间分支仍使用原始 opaque 参数 eval_addr_expr 表示 a_spec_396 和 zero_spec_399 的地址。原 VC 没有提供这两个栈对象的有效性、对齐、32 位范围及相互分离的可满足性见证。若其中地址无效，空间前件可以为空，蕴含因而成立；不能随意给这些参数指定具体值，再声称证明了原父目标的无条件否定。入口 emp 的 SAT 也不证明这个调用后的中间空间状态存在。

因此，补齐的是可复查的诊断，不是整次执行的 PASS/FAIL 证书。需要通用的中间态/栈布局见证导出，才能将实际执行分配事实绑定到空间反模型；即便补齐，弱合同本身不足以证明客户端断言的问题仍需如实报告。当前不修改输入预期，不加强合同来制造成功，不删除原始义务。

## 产物与计量

- [本轮逐例结果和成本](../benchmark/results/array_load/20261021-parent-analysis/result-cost.md)
- [机器可读结果、所有阶段与证据哈希](../benchmark/results/array_load/20261021-parent-analysis/result-cost.json)
- [完整父目标、模型尝试、编译、假设审计及内核记录](../benchmark/results/array_load/20261021-parent-itp/)
- [两个空间配置的逐例未决记录](../benchmark/results/tespec-unexpected/recheck-20261021-array-load.json)

每个实际模型调用使用 gpt-6.1-sol；失败编译、无文件编辑能力导致的无效修复尝试和后续修复全部保留。模型时间/token/Windows 单进程峰值、Coq 编译审计时间/RSS、独立内核时间/RSS分开记录。整个工作属于一个执行的 ITP 诊断任务，未按八个引理分摊费用，也不把两个空间配置引用同一诊断算两次模型费用。

最终独立 coqchk 通过 8 个诊断引理；1 个全局封闭，其余仅含原目标已有的 eval_addr_expr/sizeof_* 参数，没有新增证明假设。诊断不改变 UNKNOWN。5 次实际模型调用（含未修改文件的一次）总计 972,766 token；模型阶段 208.766 秒、峰值 519.930 MiB，所有编译与假设审计 13.738 秒、峰值 573.945 MiB，独立内核检查 117.787 秒、峰值 1752.824 MiB；整次 ITP 340.292 秒。峰值按各阶段最大单进程 RSS，阶段时间求和，模型 cached input 不重复计入 token。
