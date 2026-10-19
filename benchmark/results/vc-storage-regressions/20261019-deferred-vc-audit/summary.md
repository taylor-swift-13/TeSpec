# 证明型 VC 执行后求解：实现与回归审计（2026-10-19）

已在正常具体 teSpec 测试中，将 safety、entailment、return、which-implies、partial-solve 的 witness 自动证明请求排队，在目标执行结束、返回义务收集完成后统一调用原 QCP 策略和 SMT。inline/modular 均生效，entry-exit/all-boundaries 的 VC 范围控制独立。空间 SMT 仍在原生执行后处理残余 VC。执行路径没有 ITP/模型调用；未消解义务继续 UNKNOWN，已有离线 check-vc/ITP 入口保留。

在线仍保留决定可执行后继所需的直接计算、条件/循环判定、可证明不可达分支剪枝、合法实例采样及原有资源匹配检查。必要的 SMT 可以在线调用；未证明不可达不能剪枝。这次没有重写这些算法。全称 QCP、未绑定具体输入、未启用 residual 输出、旧 Auto-VC-Checking 日志/全自动兼容路径保留原求解时序，仍不在线调用 ITP。

## 原始义务与所有权

队列按原 witness 地址识别重复求解请求，按首次请求顺序处理；没有用公式相似度合并原始义务。原节点、公式快照、策略作用域、源位置、名字映射、每次出现的证明义务继续保存。临时 witness 容器提前释放时，队列接管原节点至处理结束，避免悬空引用。原有冻结载荷共享继续生效，没有再复制整份证明状态。输出时已处理的同一节点不重复求解，仍正常打印原 Goal/auto/check 文件。

enqueue 保留原入口更新源位置的行为，并保存 boundary 报告抑制标志；这两项只延后求解不能延后上下文记录。提前执行错误的 JSON 输出入口也先处理已经排队的 VC，保留 executor_error 和 execution_completed=false；尚未发生的指令不凭空产生证明。硬超时等无法完成的执行不能声称队列已清空或测试成功。

新增 `spec_test.vc_scheduling` 记录 requests、queued_witnesses、solved_witnesses、retained_on_release、pending_witnesses。solved 表示已完成一次自动求解尝试，并不表示 VALID。排队 witness 数不是 JSON 去重报告数，也不是原始定理数量。

## 最终结果

| 检查 | 结果 |
| --- | --- |
| 已完整 21 组、900 对输入、OFF/ON 合计 1800 次 | 0 退化；原始字段/判定/源位置一致 |
| 上述原 Goal、proof_auto、goal_check | 5262 文件逐字节一致；46 次提前 ERROR 原本没有这些文件 |
| modular 的 21 组代表正例 OFF/ON | 42/42 PASS，126 个 Coq 文件逐字节一致；不是全部 900 对 modular |
| 旧/新二进制循环及边界专项 | 39 对全部精确一致，99 个生成的 Coq 文件逐字节一致 |
| Python 回归 | 108 项执行/模式/查询/分类/空间 SMT/采样测试 + 5 项比较器测试通过 |
| 原生队列测试 | 600 个原始节点、1200 次请求、300 个提前释放节点；正常及 ASan/UBSan 通过 |
| 原有共享存储和 VC 索引 ASan/UBSan | 通过，包括碰撞、重哈希、共享引用与独立 flags/maps |

1800 次最终分类：OFF 496 PASS、350 FAIL、31 UNKNOWN、23 预期 ERROR；ON 498 PASS、379 FAIL、0 UNKNOWN、23 预期 ERROR，与基线完全相同。这里的“回归通过”不等于 1800 个程序正例 PASS。专项还覆盖最后一轮错误、break/continue、零次循环、do-while、for-continue、短路副作用、指针别名、unsigned、执行上限、提前 ERROR，以及两个策略/VC 范围参数。

最终全组请求 11056 次、独立排队 4248 个、完成尝试 4248 个、pending=0；modular 82 个全部处理；专项 1191 个全部处理，6 个节点由释放路径转交队列。ASan/UBSan 覆盖测试所包含的队列/共享存储实现，静态库不是全量插桩，关闭了进程生命周期缓存的 leak 检查，不宣称全库零泄漏。

精确比较只规范化输出目录、新增 scheduling 诊断以及经过 schema、字段类型、非负整数和守恒式校验的 branch_evaluation 计数。branch_evaluation 来自共享的纯可达性查询入口，也包含自动证明中 TryEntailFalse 的调用；去掉重复求解后计数可以变化，不是只数 C 的 if/while。原始公式、状态、轨迹、位置和 Coq 字节不得屏蔽。新增比较器测试验证此边界。

## 保留的开发失败

- 初版延后处理遗漏 boundary 抑制上下文，modular entry-exit 多报告 VC，先导差分和 2 项 Python 测试检出；已修复并完整重跑。
- 首次全组精确对照有 416 条源位置差异，涉及 incr/incr_first/init_point/zero；判定和 Coq 字节当时已经一致，但仍未接受。保留原求解入口在线更新源位置后，最终 1800 条全部精确一致。
- 新增“错误 assertion 后再空指针读取”测试初始一律预期 ERROR。既有 verdict.conjoin 规则在已证 INVALID 时优先 FAIL，旧/新二进制完全一致。仅修正这个新专项的 all-boundaries 预期为 FAIL；executor_error 及未完成执行标志继续比较，没有改 benchmark 冻结预期。修正前后 39 对记录均保存。
- 原生测试初次编译缺 SMT include 路径，已修复，编译失败日志保留。

所有中间报告和本次日志保留在同名前缀目录，见 evidence-sha256.json。工程试跑包含实际时间/RSS；不能只保留最后成功尝试。原生 token=0，无新模型、ITP、Coq 内核证书或 CN/Fulminate 测量；历史四工具成本不覆盖，完整组数仍 21/45。全组回归使用并发 worker，时间/RSS受共享宿主负载影响；专项旧/新配对串行运行，均不是受控性能实验。本次不主张普遍加速。

## 证据与复现

- [最终全组精确差分](../20261019-deferred-vc-full-exact-final/summary.json)
- [最终 modular 精确差分](../20261019-deferred-vc-modular-exact-final/summary.json)
- [最终 39 对专项](../20261019-deferred-vc-release/summary.md)
- [逐项哈希审计](summary.json)
- [外部源码前后哈希](external-source-audit.json)
- [日志](logs/tespec-deferred-vc-python-release.log)

基线二进制从 teSpec 提交 `1c29a63a6` 的 `bin/tespec-symexec` 恢复。候选二进制 SHA256 为 `4e551edce5c3733671b6118dd689cd0e30d12e04416a2046a29bfd9361f55ace`。构建在现有外部 sac 工作树完成；仅交付二进制、构建元数据、测试驱动与结果，不复制执行器实现，不提交/push sac。

```sh
git show 1c29a63a6:bin/tespec-symexec > /tmp/tespec-deferred-baseline
chmod +x /tmp/tespec-deferred-baseline
python3 -B tools/benchmark/regress_deferred_vc_scheduling.py \
  --baseline-binary /tmp/tespec-deferred-baseline \
  --candidate-binary bin/tespec-symexec \
  --output /tmp/tespec-deferred-reproduce \
  --ignore-storage-metric vc_scheduling \
  --ignore-runtime-metric branch_evaluation --iterations 16 64
SAC_SYMEXEC=/home/yangfp/teSpec/bin/tespec-symexec python3 -B -m unittest \
  tests.test_execution_strategies tests.test_execution_modes \
  tests.test_query_simplification tests.test_vc_status \
  tests.test_spatial_smt tests.test_contract_instantiation tests.test_vc_differential
```

外部原生测试命令与构建配置哈希在构建元数据及日志中保留。该源码工作树未提交的其他既有修改也由 source_modified_files_sha256 逐一绑定，不冒称仅由 sac HEAD 可重建当前二进制。
