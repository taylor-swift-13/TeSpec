# Modular 关闭边界实例化实验（2026-10-20）

用户要求取消 modular 实例化后重测。本次增加 --modular-instantiation on|off：默认 on 保留旧行为，本实验显式 off；execution-strategy 和 entry-exit/all-boundaries 仍独立。off 直接传递原有 QCP 边界状态，不进行有界整状态选值采样。入口参数/堆绑定、C 返回类型范围约束、原有规约/断言/不变式资源处理、分支剪枝、在线 SMT 与原始证明义务保留。无函数体调用在 modular off 下也保留符号规约后态，inline 的无函数体采样策略不变。

执行器结果明确标为 modular-symbolic/v1、modular_instantiation=off、contract-symbolic/v1 和 contract-and-invariant-symbolic。所有1800次 sampling_events 均为空。内部历史 contract-sample 抽象事件名仍可能出现，表示使用了规约路径；不能据此宣称发生选值，实际策略以这些新标识和 sampling_events 为准。

## 覆盖与原生结果

21组全部900对已有变体/输入，空间SMT OFF/ON共1800次；源码、spec、输入、逐输入预期未改。worker=2，时间/RSS为本轮负载实测，不作受控性能比较。

| 每种空间模式 | 原采样版 | 关闭采样版 |
| --- | ---: | ---: |
| PASS | 491 | 493 |
| FAIL | 350 | 350 |
| UNKNOWN | 36 | 34 |
| 预期 ERROR | 23 | 23 |
| 原生预期匹配 | 864/900 | 866/900 |

相对原采样modular版，只有4次 UNKNOWN→PASS，其余1796次状态不变，无已有决定性状态退化。相对历史inline基线的原比较门槛仍为passed=false、39项差异，未放宽门槛来接受实验结果。

## 原来阻塞的7个 array_load 客户端

| 客户端 | 关闭采样后的结果（OFF/ON一致） |
| --- | --- |
| translation6、translation11 | PASS，执行完成 |
| translation5、translation8 | UNKNOWN，执行完成，各留下两个原始出口VC |
| translation7、translation12 | UNKNOWN，边界frame未确定，后续read无法取得完整数组资源，执行未完成 |
| translation9 | UNKNOWN，虽然到达出口且已列出的VC均VALID，仍保留此前modular_boundary_frame_unknown限制，不能算PASS |

translation5/8的原始出口VC中，入口根a_pre被固定为4096，当前数组根为另一个量a，但缺少a=a_pre关联；目标要求从IntArray.full a推出IntArray.full a_pre。这里只给出原VC的诊断，未证明这些目标成立或反证，未将工具产生的过强目标解释为源码规约错误。不能删除目标或补无依据假设来凑PASS。translation7/12的一次read失败状态含单元与IntArray.missing_i，调用需要IntArray.full，表明还要解决边界资源/frame衔接，不能只把采样器绕过去。

结论：取消强制选值解除了一部分采样阻塞，但不能替代边界资源保留和实例关系传递；本实验没有进一步修改这些机制。

## ITP范围与成本

旧incr/read/slf3_basic_inplace_double/zero的58次残余VC仍为原生UNKNOWN。源码、绑定、完整原始Goal、proof_auto、goal_check及残余目标清单与已有58份内核证书全部一致，逐项比较和证书哈希已记录。本轮仅披露同目标历史证据，不把历史模型/内核回执当作新的测量；未新增模型、Coq或ITP调用，未发布新的完整证明成绩。新产生的4次数组残余VC保留未证明状态，另外6次边界限制也保持UNKNOWN。本报告是原生消融实验，不覆盖已有20/21 modular完整结论及原21/45四工具完成范围。

每组独立result-cost.md/json/csv保存在benchmark/results/<group>/modular-symbolic/20261020/，包含逐输入原始命令、源码/绑定/VC哈希、日志、两模式对照和原生阶段时间/RSS均值。CLI、执行器、空间SMT是嵌套阶段，不相加；新ITP阶段未运行的成本为null，不填零。原生实际token=0。CN/QCP/Fulminate及旧inline/modular成本不覆盖。

## 回归与复现

inline另跑相同1800次，原生回归零退化；与修改前完整inline批次精确比较，全部原生字段、VC与Coq文件字节、生成输入身份一致，仅按既有比较器规则归一化输出目录。464项Python测试通过，15项按配置跳过；其中启用了SAC_SYMEXEC，原生执行策略测试实际执行。

```sh
python3 -B tools/benchmark/regress_execution_strategies.py \
  --execution-strategy modular --modular-instantiation off --workers 2 \
  --output benchmark/results/spatial-smt-regressions/<fresh-run>
```

- [原生全部运行与资源](../benchmark/results/spatial-smt-regressions/20261020-modular-symbolic/results.json)
- [对照、每组成本索引及58份同目标证据](../benchmark/results/spatial-smt-regressions/20261020-modular-symbolic/ablation-summary.json)
- [异常逐例台账](../benchmark/results/tespec-unexpected/recheck-20261020-modular-symbolic.json)
- [inline精确差分](../benchmark/results/vc-storage-regressions/20261020-modular-symbolic-inline-exact/summary.md)
