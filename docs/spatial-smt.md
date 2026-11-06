# 可选空间 SMT 后端

teSpec 的 `run`、`check` 和 `run_job` 支持显式开启有限空间 VC 编码。
默认关闭；不开启时不加载 Python Z3、不改变执行器命令、判定或 ITP VC 输出。

```sh
python3 -m pip install -e '.[spatial-smt]'
python3 -m spectest run sample.c --function read --binds binds.json --spatial-smt
python3 -m spectest check job.json --spatial-smt --spatial-smt-timeout-ms 2000
python3 -m spectest check job.json --no-spatial-smt
```

保存的 job 可在 `qcp` 中设置 `"spatial_smt": true` 和
`"spatial_smt_timeout_ms": 2000`。CLI 显式开关覆盖 job；超时参数自身不启用后端。
超时范围是 1–60000 毫秒，预算针对每个 SMT 查询，非整个进程。
`run_job(..., spatial_smt=True)` 同样可用。

## 调用与判定

`run_job → 原生执行器 → 原始 JSON / Coq VC → 可选空间 SMT → 报告与 ITP 任务`。
目前是主运行流程中的执行后判定阶段，尚未接管原生执行器内部的分支、循环和调用判定。
不尝试恢复被循环上限、调用上限、读取权限错误或其他错误中断的执行。

原生求解后，每条 `UNKNOWN` VC 都进入空间后端适配，不因整次执行是
FAIL、ERROR、未完成或经过循环而跳过。已为 VALID/INVALID 的 VC 不重判；没有
UNKNOWN 时直接返回，不读取额外产物或启动空间求解器。原始 JSON 必须与报告中的
VC 清单一致，协议缺失或损坏时不能猜测公式。

单条 VC 的求解与整次测试的汇总独立。ERROR、执行上限、入口不确定、未知执行事件
仍保留原始整次状态；已生成的 VC 可以留下单独的求解证据。真实
`loop-invariant` / `modular-loop-invariant` 事件已接入结果汇总。
执行完整、入口 SAT、来源一致及原始义务覆盖仍是写回 PASS 的必要条件。

按 QCP 原生 witness 的语义区分：

| VC kind | 空间解释 |
| --- | --- |
| return、entailment、which_implies | exact，保留完整堆义务 |
| partial_solve | frame，允许剩余资源 |
| 后件显式为 `Q ** memory_rules.truep` 的 entailment | frame；原始公式本身要求存在满足 Q 的子堆 |
| safety | 纯后件，按 frame 编码；后件 LOCAL/SEP 非空则拒绝导入 |
| 其他或语义无法确认 | 逐条记录 UNKNOWN，保留 ITP |

新增 kind 的单条判定不等于已完成其 Coq 父目标绑定。尤其 partial_solve 的
`_pure` / `_aux` 与自动父目标结构不同，不能仅扩展目标名正则就清除整组 ITP。
仍未建立完整映射的组不因此变成 PASS。

适配层依据已核对的原生 VC kind 显式传递 exact/frame 模式；不会根据是否经过
循环决定模式。来源事件和整个义务组的覆盖情况不再决定是否尝试单条求解。
支持 `store`、`has_permission`、具体长度内置数组 `full` / `undef_full` / `seg`，
以及有限 `missing_i`。后者按库定义拆为缺失索引前后的数组段，要求完整列表长度
与范围一致且 `lo <= i < hi`；未知长度、未知索引或越界保留 UNKNOWN。

非空 LOCAL 只接受每侧无重名的 `Temp name expression`：每个目标绑定都必须在
每个前件分支中具有同名同表达式，表达式不得依赖局部存在变量。所有绑定都保留
为环境符号与逻辑表达式的纯等式；新增/变更目标绑定、影子变量歧义和符号冲突
拒绝导入，不丢弃 SEP 中的真实存储资源。64 位 PtrArray 尚未建立与当前库固定
步长一致的解释，保留 UNKNOWN；普通 64 位指针单元不受此限制。

递归谓词、自定义函数、不支持的布局、缺少依赖、异常、超时均保留 ITP 后备。
支持新旧原生打印形式：内建列表的 `{Z_1}` 类型参数、裸 PTR，以及按目标布局和
存储类型计算步长的三参数 pointer_offset；旧四参数形式核对显式步长。
前件 EX 名称与后件自由变量交叉时，未建立原生共同绑定映射则保留 UNKNOWN。

反例写回另有作用域检查：exact entailment/which_implies 的前件 LOCAL 绑定在后件
消失时，当前 JSON 缺少完整的局部栈 frame 与父目标替代分支关联。即使原始查询 SAT，
也只保存 `solver_status=INVALID` 和反模型，正式 VC 保持 UNKNOWN，原因是
`local_stack_frame_requires_original_obligation_check`。不删除栈单元、不推测 frame、
不修改预期；原始 exact VALID 不受该反例限制。

- 语义和作用域检查通过的 SAT 反例对应 INVALID VC；具备执行判定条件时才汇总为 FAIL。
- 所有原始 VC 都 VALID，且执行完整、各阶段通过、原始 manual 清单和 witness 覆盖一致，才允许 PASS。
- 新断言路径仅接受单函数、无命名分支后缀且来源行无歧义的 return/entailment 义务组。
  manual 条目、UNKNOWN 记录和 witness 的 total/manual/auto 计数须严格一致。
  同时读取旧 WitnessList 和新 schema_version=1 的 verification_conditions，不补造缺失义务。
  原始记录可能去重、manual 分支可能聚合；不一致时保留 UNKNOWN，不放宽为集合包含。
- return-only 与中间断言路径都核对原始 Coq 目标定义、manual 声明、模块接口和 residual 清单，
  同时核对磁盘 manifest、不可变文件哈希、案例 ID、函数、生成源码和三方布局。
  文件缺失、修改或不能关联的额外义务会阻止回写 PASS、保留 ITP；单条 VC 的求解结果仍保存。
- 只证明部分 VC 不足以产生 PASS；无法关联的额外 Coq 义务仍交给 ITP。

## 产物与证据

原始 `executor.json`、`vc/*.v`、`vc/manifest.json` 和 `residual_vcs` 保留作为证书输入，
不会生成伪造的 Coq 证明或把 SMT 结果标为内核检查通过。
`annotation_artifact_binding` 记录的是原始义务组覆盖，不是猜测的逐 VC→lemma 映射。
部分生成的根目标为“原始 VC 或策略化 VC”，`split_goal_*` 是另一证明路径的辅助引理；
原始 VC 被 SMT 判 VALID 可以使本次测试无需 ITP，但不代表这些辅助引理已逐个获证。
`report.json` 中 `vc_results` 表示经过可选后端判定后的 VC 状态，附带原始状态和证据路径。
`spatial_smt.original_status` 保存进入后端前的测试分类。

每个候选测试的 `artifacts/<id>/spatial-smt/` 保存原始 VC、规范化编码、SMT-LIB、
反例堆、判定、查询哈希和耗时。`certificate` 保持 `NOT_CHECKED`。
报告顶层 `itp_vcs` 是待处理列表；已判定且覆盖完整的组无需 ITP，
未判定或无法关联的组继续使用原始 manifest。
旧 `vc.residual_goals` 是执行器原始记录，不等同于开启后端后的待办列表。

## 测试位置

- 主流程集成回归：`tests/test_spatial_smt.py`。
- return 原始产物绑定回归：`tests/test_spatial_return_binding.py`，实际原生正例及文件缺失/修改负例。
- 编码模块单元测试：`tools/finite_spatial_smt/test_*.py`，包括通用 missing_i 和 LOCAL 的正反例。
- 已完成组实际回归：`tools/finite_spatial_smt/regress_completed_groups.py`，读取发布的基线并
  在全新目录实际执行 OFF/ON，不覆盖旧源、预期或证据。旧 UNKNOWN 的新判定对照既有 ITP，
  不把旧 Coq 证书搬给新执行；空间 SMT 结果仍为 `NOT_CHECKED`。
- 2026-10-18 接入结果：见 `benchmark/results/spatial-smt-regressions/`；首轮 array_load
  两客户端先导实验另存 `benchmark/results/spatial-smt-integration/20261018-array-load-pilot/`。
- 2026-10-18 接入与验证说明：[中间断言与有限数组接入](spatial-smt-annotation-array-integration-20261018.md)。
- 初次 return 接入测试：`tools/finite_spatial_smt/results/20261015-integration/`。

这些组件测试不计入程序 benchmark，也不覆盖历史 benchmark 测试分类。

## 2026-11-06 Python 接入检查（原执行器 020aae13fbe1）

- 78 项调度、真实循环、结构化义务清单及原生集成回归通过；137 项导入器回归通过。
- 22 组、901 输入对的 inline/modular 共 1802 次原生运行，同一批不可变结果分别
  交给旧、新后端。46 个预期 ERROR 和所有原始 VC/Coq 文件保持不变；没有重新运行
  CN/Fulminate、ITP 或内核证明，也不覆盖正式组成本。
- 旧后端已符合预期的 1796 条全部保持；modular translation7 和 translation12
  分别由 UNKNOWN 转为 PASS、FAIL。最终 1798/1802 匹配。
- 该轮发现四条既存缺口（已由下述原生修复解决）：translation9 两策略原生 FAIL（预期 PASS），inline
  translation7/12 为 UNKNOWN（预期 PASS）。局部栈作用域不完整的反例没有误报 FAIL。
  此次不修改它们的程序、规约或预期，也不声称全量 benchmark 已通过。
- 热后端的 1802 次调用总耗时由约 0.402 秒变为 0.993 秒；有未决 VC 的调用中位数
  为 5.65/5.60 毫秒。新增时间集中在此前未编码的数组 VC。开发机负载未受控，
  这些数字仅为开销核对，不是正式性能评测。
- 曾运行的更大组件套件中，旧 `test_no_unconstrained_list_length_guess` 断言
  与已存在的有限列表展开行为不符；已用隔离 HEAD 复现，未改该旧测试或实验预期。

该轮只改 Python 接入与测试，未修改执行器二进制和 sac 源码。临时回放树不提交。

最小回归与异常收据：[current-executor-replay.json](../benchmark/results/tespec-unexpected/current-executor-replay.json)。

## 原生绑定与断言目标修复（db632c3ceb）

后续原生修复在函数体语义分析前绑定所选入口规约的 With 变量，避免断言捕获
其他规约的同名变量 ID；并在模板展开后恢复观察目标的局部地址映射与已有 C 标量
栈资源。不会改写实际执行状态、补齐任意用户堆或删除原始证明义务。

新发布二进制定向复核 translation7/9/12 的 inline/modular 共六次：前两者均 PASS，
translation12 为 inline PASS、modular FAIL，全部符合原有预期且无需 ITP。
137 项 teSpec 定向回归、608 项 sac 回归通过；新增六项回归含 15 个执行配置，
另经 ASan 检查。该次不重跑 1802 次历史回放，不覆盖正式组成本或证明证书。
上述反例作用域保护仍保留；递归谓词等能力边界没有扩大。

## 内联辅助函数与递归帧修复（b36b30773c）

修复辅助函数原始 With ID 与本次调用实例的连接，覆盖显式 where 绑定及当前函数内
同名同类型的多规约变量。两阶段替换隔离嵌套、递归调用；先完成被调用函数的局部
地址准备，再合并调用者 frame，保留旧栈地址及全部 SEP/PROP。
这些是原生观察目标的修复，空间 SMT 编码和反例写回保护没有放宽。

当前发布版本通过 147 项 teSpec、608 项 sac 回归；16 项入口/断言测试的 36 个配置
另经 ASan 检查。translation7/9/12 的六个控制结果保持原预期。未重跑整组评测或 ITP。

## Which-implies 前件适用性

inline 的观察检查同时保留当前状态对注解前件的适用性检查和注解自身的蕴含检查。
QCP 匹配无法决定前件时，生成真实的 `P |-- EX with, Q ** memory_rules.truep`，
继续原执行；不会伪造匹配成功或丢弃这条义务。空间后端仅将已确认内存模型的无参
`naive_C_Rules.truep` / `naive_C_Rules64.truep` 顶层后件 SEP 解释为 frame。
前件 truep、模型不匹配、嵌套/带参使用、exact/frame 混合析取均保留 UNKNOWN。

不可能的纯前件和缺资源前件现在为 FAIL；不透明谓词的前件保留 UNKNOWN 和原始 Coq
证明任务。原有反例写回保护及其他义务覆盖检查继续生效。147 项导入器回归和新增
10 个原生观察控制通过，完整定向 teSpec 套件为 157 项；不覆盖历史正式评测结果。

生成的原始 Goal 通过补齐运行时 `SimpleC.Verification.VCPrelude` 导入入口恢复可编译。
兼容入口只重新导出现有定义；不改原始 Goal、不加入新假设。专用纯控制例的三个原始
目标完成证明、闭合假设审计和递归 `coqchk`；frame 控制仅核对原样编译，不宣称它已证明。
这项兼容检查不将空间 SMT 的 `NOT_CHECKED` 改写为 Coq 证书。
