> 历史验收记录：其模式/实例状态描述已由 [inline-preserve/v1](inline-preserve-implementation.md) 替代。以下数据只对应文中记录的旧二进制。

# 两种规约测试模式：实现与验收

实现工作区：sac `/tmp/sac-tespec-merge-J7CxUo`，teSpec `/tmp/teSpec-tespec-agentflow`，均为 `tespec` 分支。sac 的修改限于符号执行器、相关接口和测试。QCP 示例作为只读输入；本阶段未启动证明 Agent。

## 已实现的接口

```sh
python3 -m spectest run program.c --function target --binds binds.json \
  --execution-mode entry-exit --output-dir /tmp/test-expand
python3 -m spectest run program.c --function target --binds binds.json \
  --execution-mode all-boundaries --output-dir /tmp/test-contract
```

展开模式默认 `--annotation-policy ignore`，可选择 `check-preserve`；不展开模式固定为 `qcp`。冲突参数报错。只有声明的目标执行 `specification-only`，仅检查 Require，安全性和后条件为 `NOT_RUN`。无规约目标或无契约的外部调用报错。

`bin/tespec-symexec` 是新默认执行器；`bin/qcp-symexec` 保留历史实验原始摘要。`bin/tespec-symexec.build.json` 记录源版本、修改文件摘要和二进制摘要。

## 实现要点

- `InstanceContext` 按逻辑变量 ID 保存入口快照。分支内等式只在当前断言中传播；堆写入、调用 frame、局部地址及存在变量继续使用 QCP 的状态和 freshening。没有独立的可变堆值缓存。相反的非严格边界可在当前分支中导出等式，例如退出时的 `2 <= i && i <= 2`。
- 调用契约匹配得到的实例传到 Ensure；存在量不继承旧内存值。已测试重复调用、别名写入、frame 保持、弱契约丢失信息和循环归纳不受入口局部常量污染。
- 共享表达式模块负责持续求值、可执行定义展开、有限量词和地址表达式规范化。teSpec 中旧的 Python 语义求值器、证明模板求值器和自然语言日志分类已删除。
- 有限数组形状在展开执行中变成带 fresh 逻辑值的符号单元；不会把其内容默认为零。不展开模式保留 QCP 数组抽象，同时化简零长度片段和地址大小表达式。
- 前条件检查区分必要内存约束和完整见证。间隔分离只能用于排除矛盾；SAT 必须检查所有纯条件和空间资源。内部批量地址候选提高多对象覆盖，候选失败仍为 UNKNOWN，候选地址不写回执行输入。
- 结构体使用编译器的实际大小、对齐和字段偏移，检查子对象边界。覆盖嵌套结构、数组字段、union 重叠、指针存储以及 8/16/32/64 位整数。32 位 QCP 模型中的 64 位整数按四字节对齐。未知模型保持 UNKNOWN。
- QCP 的 `full/seg`、`full_shape/seg_shape` 和 `undef_full/undef_seg` 有限整数数组支持前条件检查；形状资源的内部 SAT 见证与执行中的 fresh 值分开处理。
- 初始 Require UNSAT 时两种模式均停止执行；不可行的嵌套循环空状态会安全传过后续条件，修复了全量烟测发现的 12 次崩溃。
- JSON 在最后一轮 VC 求解后更新，避免与 auto/manual 文件产生过期状态差异。蕴含未关闭不会被 Python 转成已确认反例。

## 产物和信任边界

```text
run/
  report.json
  artifacts/
    case-id/
      input.c
      executor.json
      stderr.log
      vc/
```

结果分别记录 precondition、safety、postcondition、annotations、scope、抽象事件、残余 VC、源码/运行时/二进制摘要及预算。`INVALID` 表示前条件 UNSAT；前条件 UNKNOWN 或未关闭的普通 VC 使整体保持 UNKNOWN。循环/调用预算和控制器超时也是 UNKNOWN。超时终止进程组并保存输出。

CPU 时间和 RSS 来自 GNU time；RSS 是最大进程 RSS，不是同时驻留进程树的总峰值。缺失测量为 null。总报告的峰值取各例最大值。

自动后端结果的 certificate 为 `NOT_CHECKED`。证明检查器拒绝 manual 和 auto 文件中的 `Admitted` 等占位内容，不能通过编译占位文件声称整组目标已经内核检查。

## 验收与复现

```sh
SAC_SYMEXEC=/tmp/tespec-precondition-build/symexec make check
python3 scripts/run-spec-test-regressions.py \
  --examples /home/yangfp/QCIP/QCP_examples --output /tmp/curated
python3 scripts/run-qcp-corpus.py \
  --examples /home/yangfp/QCIP/QCP_examples \
  --binary bin/tespec-symexec --runtime /home/yangfp/QCIP \
  --output /tmp/corpus --timeout 2
```

有语义预期的 QCP 基准数据在 `benchmark/spec-test-qcp-cases.json`，与自动模板烟测分开。40 个配对用例均符合预期：21 PASS、10 INVALID、9 UNKNOWN。9 个 UNKNOWN 明确对应非空形状数组的不展开空间不变式保持性；它们的 Require、安全性及返回后条件通过，不能计作全部 VC 通过。

另有 281 项内存前条件矩阵全部符合预期：142 SAT、135 UNSAT、4 UNKNOWN。4 项分别是不透明谓词及其析取、超出字段类型的存储和数组字段越界；没有证明这些 UNKNOWN 已可满足。sac 的 42 项规约执行回归通过。teSpec 的 lint、104 项测试和运行时检查通过，其中一个环境相关测试跳过。另有 18 项候选执行器测试在 ASan/UBSan 下通过（`ASAN_OPTIONS=detect_leaks=0`）。

本机完整运行目录：`/tmp/tespec-evaluation/release-memory`、`/tmp/tespec-evaluation/accepted-curated`、`/tmp/tespec-evaluation/accepted-corpus`。

## 全量烟测结果

267 个 C 文件、1,147 个规约条目。其中 860 个条目以 3 组模板绑定运行两种模式，共 5,160 次；另外 287 个条目标记为 NEEDS_BINDINGS。

| 结果 | 本轮首次结构化扫描 | 最终扫描 |
| --- | ---: | ---: |
| PASS | 783 | 1,010 |
| INVALID | 953 | 1,022 |
| UNKNOWN | 2,382 | 2,469 |
| ERROR | 1,042 | 659 |

两次都使用 2 秒单例超时、展开循环上限 16。输入来自模板，不是可行性或正确性的真值标注。增多的 INVALID 包括已停止执行的矛盾输入；UNKNOWN 包括现在能保留的残余 VC。最终 UNKNOWN 中 1,832 项首先受 Require 存在性限制，500 项为其他残余 VC，61 项超时，76 项循环预算耗尽。最终无无效 JSON；前一版发现的 12 次崩溃均已修复。

摘要和完整错误分类见 [qcp-corpus-results.json](qcp-corpus-results.json)。本次提升既包括真实语义修复，也包括输入序列化、停止无效执行及报告一致性修复，不能把 PASS 增量当作独立正确率提升。

## 仍然存在的障碍

1. 只有外部签名或 Coq Import 的谓词没有可执行定义，不能据名称假定可满足。链表/树的此类定义仍会留下存在性或展开义务。
2. 不展开模式的部分数组片段重组和递归空间不变式仍需证明；本文记录的 9 项是明确实例。
3. QCP 语料中存在缺少策略文件、无法匹配的调用规约、证明注解名字依赖、不能派生的内存访问和泛型绑定缺失。烟测保留这些错误，不能将任意模板输入视为有效输入。
4. 自动内存模型主要覆盖 QCP 32 位整数/指针资源。未覆盖的架构、浮点存储和复杂抽象空间模型保持 UNKNOWN。
5. 本地递归定义超出有限展开预算后的完整 Coq 残余导出尚未覆盖所有形式；源文件会保留，不能据此声称残余证明包总能直接编译。
6. 尚未实现通用的可达反例验证、可靠 Coq 定义导入、独立可重放自动证明证书及论文消融实验。规则的健全性论证和独立复现包仍需完成；本次回归通过不等于论文级验收已经完成。

## 2026-10-18：独立执行策略与规约实例化

新增 `--execution-strategy inline|modular`，与 `--execution-mode entry-exit|all-boundaries`
正交。无函数体的调用在两种策略下使用相同规约实例化路径；有函数体时 inline 执行代码，
modular 使用契约。modular 的 assertion 与循环使用 QCP 资源转移，先保留原始检查
再选择合法后继。未修改的局部变量和空间 frame 保留；调用前固定地址以防释放资源后
重新选择地址破坏此前分离约束。

采样使用有界候选搜索及完整具体状态校验，不把搜索失败当 UNSAT。当前支持 32 位
整数/指针原始空间单元；有限定义可展开，未支持的谓词、浮点/聚合返回保持 UNKNOWN。
入口前置条件、原有 VC、工具错误分类不重定义。`result_scope` 区分实际代码执行和
契约/不变式模型；后者的结果不自动声称可由真实函数体到达。

`singleton` 7 个输入、`dll_add` 14 个来源配对输入，各运行 8 种参数组合，共 **168 次**
原生调用全部执行完成。它们都保留 `Dll` 返回 VC，所以最终是 **168 UNKNOWN、0 PASS**，
不能将本次接通说成两组全通过。SMT ON 的 84 次均尝试该返回 VC，报告未支持的 Dll。
[完整结果和成本](../../benchmark/results/execution-strategy/20261018-contract-modular-final/summary.md)
及[逐输入异常](../../benchmark/results/tespec-unexpected/recheck-20261018-contract-modular.json)
保留所有源码/输入/VC 哈希。第一批计量器配置错误单独保留为 NOT_RUN，原生执行数为 0。

原始 Coq VC 的左侧使用目标布局字段偏移 0/4/8，而历史 DLLSupplement 使用未解释的
`eval_addr_expr`，目前没有等价桥梁。已有 `prepare-layout-libraries.py` 可生成显式目标布局
解释，但这会改变依赖语义上下文，须另行固定布局/依赖哈希并证明实际返回蕴含。
不能利用生成目标的备用平凡析取，或复用旧证书，声称原上下文的实际返回 VC 已证明。

新模式逐组抽查另外发现条件后置规约的分支处理问题：合法分支已经选中，
另一个由当前输入排除的分支不应使整体 UNKNOWN。已修正为只在有其他可能
分支时删除已证明不可满足的候选；整个契约都不可满足仍返回 UNKNOWN。
新增“条件分支”和“全部分支矛盾”回归保护。最终版的
[21 组正例抽查](../../benchmark/results/spatial-smt-regressions/20261018-modular-positive-final/summary.md)
在 modular 下 SMT OFF/ON 共 42 次均为 PASS。这是逐组代表输入检查，并非所有输入的 modular 穷尽回归。
[定向测试](../../benchmark/results/execution-strategy/20261018-unit-regression-final/receipt.json)
共 219 项，3 项跳过，无失败。

最终二进制（SHA-256 `886ba50b83339375d54a23b2301856068dcab5f19238125991f535e1a5b2e549`）
完成 [21 组、900 对输入、1800 次默认 inline 回归](../../benchmark/results/spatial-smt-regressions/20261018-execution-strategies-final/summary.md)，
**零退化**，原始输入/证据哈希未变。OFF 为 496 PASS / 350 FAIL / 31 UNKNOWN / 23 预期 ERROR；
ON 为 498 PASS / 379 FAIL / 0 UNKNOWN / 23 预期 ERROR。保留的 UNKNOWN 不计作成功判定。
该最终正确性回归使用 4 个独立 worker，时间是并发负载下的实际观察值，不用于受控性能对比。
执行器源码仍位于外部既有工作树，teSpec 只保存二进制、构建身份及相关测试/接口代码。
