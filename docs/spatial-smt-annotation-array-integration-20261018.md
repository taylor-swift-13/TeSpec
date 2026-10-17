# 中间断言与有限数组空间 SMT 接入（2026-10-18）

开始修改前已通过 SSH push 确认 `origin/main` 与 `574fb1ec5` 一致。接入仅修改 teSpec 的执行后适配层及有限空间导入器；保持唯一 main 工作树，未修改 sac、执行器二进制或已有 benchmark 源与预期。

## 实现范围

- 对 `all-boundaries` / `check-preserve` 的具体中间断言开放 exact entailment 检查，保留原 return 路径。未知事件、摘要、循环抽象、执行中断、覆盖不完整和不支持语义继续 UNKNOWN / ITP。
- 通用 `missing_i` 按原数组库定义展开为缺失索引前后两段，校验有限范围、索引和完整列表；不匹配具体程序名或固定数组值。
- 非空 LOCAL 保留为环境等式；拒绝重名、存在变量依赖、改变或新增目标绑定及符号冲突。64 位 PtrArray 与当前库步长不一致，仍保守不支持。
- 允许取消测试 ITP 之前，核对原始 manual / witness / residual / 模块接口、源哈希、案例 ID、函数和布局。组级覆盖不冒充逐 VC 到辅助 lemma 的对应；原始 Coq 文件不变。
- SMT 结果的证书仍为 `NOT_CHECKED`，没有生成新的 Coq 内核证书。原有 ITP 结论仅作回归对照。

## 实际回归

重跑已完整的全部 21 组、900 对输入，每对实际执行空间 SMT OFF / ON，共 1800 次。固定源、输入、既有证据及生产代码哈希均保持一致；0 判定退化。

| 模式 | PASS | FAIL | UNKNOWN | 预期权限 ERROR |
|---|---:|---:|---:|---:|
| OFF | 496 | 350 | 31 | 23 |
| ON | 498 | 379 | 0 | 23 |

与接入前同模式比较，仅 array_load 的 translation7、translation12 在 ON 下由 UNKNOWN 变 PASS，与其既有独立 ITP 结论一致。其他 1798 次保持既有判定，包括 OFF 的 31 UNKNOWN；UNKNOWN 不算成功完成判定。

- array_load：OFF 65 PASS / 2 UNKNOWN；ON 67 PASS，无待处理测试 ITP。
- read：OFF 22 PASS / 20 FAIL / 12 UNKNOWN / 7 预期 ERROR；ON 22 PASS / 32 FAIL / 7 预期 ERROR。原先已解决的 12 条错误规约仍被拒绝。
- 原有四工具结果成本表保持为历史完整评测；本轮只重跑 teSpec 原生流程，没有重新运行 CN、QCP 全称验证、Fulminate、模型证明或 Coq 检查。完整组数仍为 21/45。

正式产物见 [回归摘要](../benchmark/results/spatial-smt-regressions/20261018-annotation-array-v1/summary.md)、[逐组统计](../benchmark/results/spatial-smt-regressions/20261018-annotation-array-v1/group-summary.json) 和 [审计回执](../benchmark/results/spatial-smt-regressions/20261018-annotation-array-v1/post-run-audit.json)。11683 个新源、报告、VC 与日志引用完成哈希检查。每次执行保存完整 CLI / 执行器时间与 RSS；ON 另有空间阶段计量。

| 本轮原生回归计量 | OFF（900 次） | ON（900 次） |
|---|---:|---:|
| CLI wall 合计（秒） | 148.916446 | 150.306353 |
| CLI 最大单进程 RSS（KiB） | 24116 | 60748 |
| 实际模型 token / 调用 | 0 / 0 | 0 / 0 |

这些时间为包含关系，CLI 总时间、执行器和空间阶段不能相加。空间阶段 RSS 是 1 ms 采样观察峰值；另列入口/出口进程生命周期高水位，后者包含此前阶段，不冒充阶段独占峰值。原生回归无模型调用，不覆盖工具开发过程的对话 token 或历史 ITP 成本。

## 独立边界检查

- 完整有限空间测试 3400 项通过（含差分矩阵、历史输入和导入器正反例），53.860422 秒、测试进程最大 RSS 77444 KiB。[逐项证据](../benchmark/results/spatial-smt-integration/20261018-final-tests/finite-spatial-unit-tests.json)。
- 接入测试 47 项通过，包含 8 个额外真实执行器正反例、各运行 OFF / ON：不同长度/索引/值的正确数组通过；错误值、重复所有权、缺单元、缺剩余资源被拒绝。组覆盖歧义、源/布局/产物错配保留 UNKNOWN；混合组部分完成时阶段正确回填，整体保留 ITP。[运行观察记录](../benchmark/results/spatial-smt-integration/20261018-final-tests/integration-test-observation.json)。这项组件测试未单独计量 RSS，不纳入 benchmark 成本。
- 代码只读复审确认保守回退与产物绑定，没有发现需阻塞的错误 PASS/FAIL 路径。回归只能支持已测范围，不能保证未支持的任意程序。

`20261018-array-load-pilot` 是产物绑定收紧前的开发先导数据；`20261018-annotation-array-worker-smoke` 是计量脚本冒烟，两者均不计入正式 900 对输入或上述总成本。最终验收使用冻结源码的 `20261018-annotation-array-v1` 与最终组件测试证据。
