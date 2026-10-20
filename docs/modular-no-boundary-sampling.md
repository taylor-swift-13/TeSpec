# 移除 modular 边界采样

用户确认删除 modular 边界的选值采样。修改在唯一 teSpec/main 工作树交付；外部 sac 只本地修改、构建，不提交或推送源码。

## 当前行为

入口仍应用测试的给定值。函数调用使用 QCP 规约传递资源和符号后状态；循环使用不变式加分支条件；assertion 检查对应原始义务并保留其后继状态。不在任何 modular 边界搜索或选择新值，所有原始 witness 保留。

删除了循环体/退出分支与 assertion 的采样调用，函数调用的前态也不进入采样器。共享返回值准备仍补充 C 类型范围，但不选择返回值。`SpecTestInstantiateStates` 内另有 modular 保护，即便内部误调用也不进入候选搜索。没有扩大空间 SMT 白名单、改变 VC 表示或汇总规则。

Python CLI/API 和原生程序只有 symbolic modular 行为；`--modular-instantiation` 和 `qcp.modular_instantiation` 均已删除，不再保留 off 兼容入口。Python 同时拒绝将携带采样事件或旧 hybrid 标签的输出当作当前 modular 执行。

报告为 `modular-symbolic/v1`、`contract-symbolic/v1`、`contract-and-invariant-symbolic`，`sampling_events=[]`。这表示固定入口下的模块化符号检查，不承诺执行了被调用函数体或所有循环迭代。inline 现有路径未改变，仍可能对只有声明的调用采样。

## 回归证据

本轮与上一提交的 modular-off 及 inline 原生结果、源/输入哈希、全部原始 Coq VC 对比。证据位于 `benchmark/results/modular-symbolic-only-20261020/`；逐例产物分别在 `benchmark/results/spatial-smt-regressions/20261020-modular-symbolic-only` 与 `20261020-inline-after-no-modular-sampling`。

旧采样实验和成本不删除、不覆盖；当前数据不继承其“发生过采样”的语义。只有原始目标和输入完全一致时引用旧证明，不产生虚假的新 token 或新 ITP 耗时。

## 已完成的原生回归

21 组 900 对输入，modular 与 inline 分别运行空间 SMT OFF/ON，共 3600 次原生执行。与上一版本的对应策略比较，所有原始 Coq VC 文件及原生判定均一致；modular 全程没有任何采样事件。另有 20 个声明调用/资源传递配置与删除前的 off 模式逐项一致。

旧证明仅在完整目标和输入哈希匹配时引用，每种空间 SMT 模式的 modular 最终结果为 497 PASS、379 FAIL、1 UNKNOWN、23 个预期 ERROR。没有重新运行模型或计入虚构 token。translation12 的已知未决目标保留，空间 SMT 的全执行事件门禁此次未改。

[逐组结果与成本](../benchmark/results/modular-symbolic-only-20261020/index.md)；[完整审计](../benchmark/results/modular-symbolic-only-20261020/audit.json)。

回归驱动的原始 summary 仍使用最早的 inline 基线，因此 modular 的 29 项历史差异仍显示为 DECISION_REGRESSION。本轮审计另外与紧邻的 modular-off 版本逐个比较：判定与原始 VC 均相同，没有新退步。原始日志不改写。

初轮测试发现旧测试仍期望 hybrid/采样标签；对应失败日志保留。更新的是已经移除功能的元数据断言，原有程序结果、安全拒绝和残余义务要求没有放宽。

最终 Python 回归：473 项测试，458 通过、15 项环境相关跳过；额外的原生 on 开关拒绝测试也通过。Ruff 检查通过。

## 删除旧模式接口后的 20 组复测

按用户要求进一步删除兼容开关、配置字段、原生全局变量和报告字段。执行策略仍为 inline/modular，VC 范围仍为 entry-exit/all-boundaries；modular 没有另一个采样模式。

此次范围由前次索引的 all_expected_matched 确定：20 组、833 对变体/输入。array_load 因已有未决项明确不在这 20 组中，未将其标记完成。每组复测 modular 和 inline 的空间 SMT OFF/ON，结果及成本见 [20 组复测](../benchmark/results/modular-20-groups-20261020/index.md)。

20 组复测及证书复用审计完成：每种空间 SMT 模式共 833 对输入，最终为 431 PASS、379 FAIL、23 个预期 ERROR，全部符合原预期。原生结果中的 29 项 UNKNOWN 使用完全相同原始 VC 的既有内核证书，未调用新模型，也未伪造新的 ITP 成本。modular 与 inline 各 1666 次原生运行的判定及原始 Coq 文件均与上一版对应策略一致，总计 3332 次。每组新成本表引用原有 CN/QCP/Fulminate 表；这些未受影响的历史测量没有冒充新运行。

注意原生驱动沿用早期 inline 基线，因此其 modular 原始 summary 仍显示 29 项历史差异。`audit.json` 额外逐例比较了前一版同策略结果和完整 VC，确认本次没有新增退步。原始日志不改写。

本轮接口删除后的完整 Python 回归同样为 473 项：458 通过、15 项环境相关跳过；定向回归 39 项通过，Ruff 与维护代码的差异格式检查通过；原始生成产物保持字节不变。日志及哈希保存在本轮 audit.json。
