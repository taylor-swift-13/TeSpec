# Modular 边界状态与非阻塞采样修复（2026-10-20）

本轮修复执行器的边界资源传递及采样失败处理。程序/spec/输入/逐输入预期均未改，仍在唯一teSpec/main工作树线性开发；外部sac只本地构建，不提交或push。本仓库只交付二进制、版本哈希、接口、测试与评测产物。

## 修复后的行为

- 断言边界先解析明确给出的局部值，再关联已有局部槽和指针值，保留入口快照、别名及地址等式；只使用已有冻结输入绑定，不把循环可修改参数重新固定为入口值。
- 边界的frame计算复用QCP空间策略和统一器，按资源所有权提取未消耗部分；值条件仍交给原始边界VC。匹配临时引入的值见证与纯条件不带入执行状态。
- 私有匹配副本及真正后继复用QCP TryFold。支持策略中已绑定地址表达式的等价比较，以及同一元素类型的sizeof结构式与已求值大小之间的匹配；不推测未知基址、索引或结构体布局。原执行堆的字段/指针路径保留。
- --modular-instantiation on 改为尽力采样：只在副本上搜索；失败时记录SYMBOLIC_FALLBACK，逐字保留输入状态继续。搜索和试探性展开的资源限制不污染实际执行结论。off仍直接保留符号状态。inline的调用及采样路径保持原行为。
- 矛盾的调用后条件另标contract_postcondition_inconsistent，整体保持UNKNOWN；权限错误、原始VC及真正执行限制不由采样回退消除。hybrid中的completed描述执行图到达出口，不能据此声称存在满足矛盾后条件的具体轨迹。

新on策略明确标为modular-hybrid/v2、contract-sample-or-symbolic/v2、contract-and-invariant-hybrid及retain-original-symbolic-state/v1；off仍为modular-symbolic/v1。VC范围entry-exit/all-boundaries独立。空间SMT仅继续接受完整审计过的纯采样合同轨迹，含符号回退、断言/不变式抽象等未支持事件时仍保守拒绝，不扩大可接受集合来凑通过率。

## 完整回归结果

21组全部900对变体/输入，采样on/off分别跑空间SMT OFF/ON，共3600次modular原生执行。每种配置结果一致：496 PASS、350 FAIL、31 UNKNOWN、23预期ERROR。所有非预期ERROR输入均执行到出口；没有contract_instantiation_unknown或modular_boundary_frame_unknown阻塞。

原来7个array_load客户端中，translation5/6/8/9/11自动PASS；translation7留下一个原始整体VC，translation12留下调用弱规约后的原始VC。两者均完整执行。采样开关下所有SYMBOLIC_FALLBACK的输入与后继约束字符串完全相同。

旧incr/read/slf3_basic_inplace_double/zero的58份证书经过原始Goal、proof_auto、goal_check、源码、绑定、目标清单及原回执的完整哈希审计，可分别引用到本轮on/off相同目标，共116次引用；没有把引用算成新模型调用，也没有重复计量历史证明成本。原58份证书独立复核器--artifact-only审计通过，索引字节不变。

新增8次ITP后，每种采样×空间配置的最终结果为：

| PASS | FAIL | UNKNOWN | 预期ERROR | 预期匹配 |
| ---: | ---: | ---: | ---: | ---: |
| 497 | 379 | 1 | 23 | 899/900 |

剩余的是同一个translation12客户端，四种配置各一次UNKNOWN。20组所有输入最终匹配；array_load仍保留这项ITP后缺口，未宣称21组全部完成。原四工具完成范围21/45及旧modular20/21的历史记录不覆盖。相对旧采样版，原来14次执行阻塞全部消除；相对inline的既有原生门槛仍保留29项空间自动处理差异，未修改门槛。

inline另跑同样1800次。与修改前批次精确比较，原生状态、原始VC/Coq文件字节及输入身份全部一致。最终466项Python测试通过（15项按环境跳过），其中策略、无函数体调用、所有权、循环可修改参数、非法断言与不可能后条件等原生检查实际执行。先前协议断言及completed旧语义断言的失败日志保留；更新的是新策略的元数据和符号延续预期，没有降低PASS/FAIL/UNKNOWN/ERROR判定要求。

## 新ITP的结论与审计纠正

8次执行分别包括全部残余目标的冻结上下文、实际gpt-6.1-sol填写/修复、Coq编译与假设审计及完整独立coqchk。共17次模型调用，所有失败编译与修复均计入对应执行。8次均有内核通过的证书，共16个登记定理。

translation7的4次执行：证明入口SAT及唯一原始整体VC；该目标的另一合法蕴含分支为自反式，能够直接证明，无需删改数组分支。最终PASS。4个入口SAT全局封闭，4个原始整体目标的证明仅依赖原类型中的eval_addr_expr/sizeof_*参数，没有新增证明或库公理。

translation12的4次执行：入口SAT与一个纯分解子目标的否定通过内核检查，均全局封闭。这说明弱read合同允许的返回值不足以推出客户端所需的固定值；弱合同本身可以是正确但信息不足的合同，不等于read的真实函数体出错。

必须保留的审计纠正：该纯子目标是原整体VC的一个分解方向；原始父目标还包含空间蕴含的另一分支。反证纯子目标不能独自推出父目标或整个测试为FAIL。本轮初始ITP控制器把该子目标当作必要整体义务，原回执中写了FAIL；发布审计明确拒绝这个提升，原回执和当时控制器源码保留，最终index及结果表一律保留UNKNOWN。后续控制器策略已纠正。没有把反证子目标包装成“正确检出源码错误”，也没有改预期或用不安全假设补证。

## 成本（8次实际ITP执行的平均，含全部修复）

| 阶段 | 平均秒 | 单次最大进程内存的平均MiB | 平均token |
| --- | ---: | ---: | ---: |
| 模型填写与修复 | 129.605750 | 192.801270 | 440707.625 |
| Coq编译与假设审计 | 4.208144 | 537.900391 | 0 |
| 独立内核检查 | 127.537770 | 1828.440430 | 0 |
| ITP合计 | 261.351664 | 1828.440430 | 440707.625 |

实际token总计3,525,661，input+output，缓存输入为input子集，不重复相加。模型内存为Windows客户端PeakWorkingSet，不包含远端服务/GPU；Coq为GNU time最大单进程RSS。每次先取所有尝试/阶段最大峰值，再取8次均值；不是批次峰值除以次数。4次完整证明与4次仍有父目标未决的诊断都进入成本，不能只统计成功的证明。ITP合计与分项重叠，原生CLI/执行器/空间SMT也嵌套，均不重复相加。worker=2下的负载实测不作为受控性能比较。

另外保留187次中间执行器修复/调试调用（空间OFF 96、ON 91），含临时失败、每次二进制哈希、原命令、日志、时间和RSS；同一客户端的多次尝试累计记录，不作为新独立输入。它们与正式3600次modular和1800次inline回归分开，详细成本在development-native-diagnostics.json。

各组新增benchmark/results/<group>/modular-boundary/20261020/result-cost.md/json/csv，四种配置逐例证据、时间/RSS/token齐备；历史CN/QCP/Fulminate与旧证明成本仍引用原组表，未捏造新测量。

## 产物与复现

- [各组可读结果与成本索引](../benchmark/results/modular-boundary-result-cost-index.md)
- [总索引、各组表及配置结果](../benchmark/results/spatial-smt-regressions/20261020-boundary-fix-audit/summary.json)
- [新增ITP逐执行证据与实测](../benchmark/results/array_load/20261020-boundary-itp/index.json)
- [ITP后异常台账](../benchmark/results/tespec-unexpected/recheck-20261020-modular-boundary-fix.json)
- [所有修复诊断成本](../benchmark/results/spatial-smt-regressions/20261020-boundary-fix-audit/development-native-diagnostics.json)
- [inline精确差分](../benchmark/results/vc-storage-regressions/20261020-boundary-fix-inline-exact/summary.md)

```sh
python3 -B tools/benchmark/regress_execution_strategies.py \
  --execution-strategy modular --modular-instantiation on --workers 2 \
  --output benchmark/results/spatial-smt-regressions/<fresh-run>
# 另以 --modular-instantiation off 对照；空间OFF/ON均由驱动执行。
python3 -B tools/benchmark/publish_modular_boundary_fix.py
```
