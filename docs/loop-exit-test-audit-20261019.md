# 循环退出测试审查（2026-10-19）

结论：在本次审查范围内，充分固定控制条件相关值的普通 inline 循环能够确定退出。没有发现值已经固定而简单整数条件仍无法判定的例子。现有 loop_unroll_limit 不能统称为“SMT 不会判断退出”：它至少包含输入只固定了根地址、真实死循环、展开预算不足三类情形。

本轮执行器 SHA256：`4e551edce5c3733671b6118dd689cd0e30d12e04416a2046a29bfd9361f55ace`，来自 `ce34e04a8`。新增 116 次原生执行：34 个冻结查询用例 × 两种 VC 范围 = 68；init_array 三个版本共18输入与 list_all 反转4输入 × 空间 SMT OFF/ON =44；一个有限循环两个展开上限 × 两种 VC 范围 =4。另复核上轮39对控制流专项。未修改执行器、程序、规约或冻结预期，未运行 ITP。

## 已确定退出的实例

- bound_loop：n=3，0 起步逐次自增，两个模式 PASS，branch_evaluation.smt_fallback=0。
- 数组指针差值循环、vector_sum、concat：现有固定长度输入均完成，回退为0。
- 嵌套循环：0×5、3×4、30×30 均完成并 PASS；30×30 的 entry-exit 记录4807次共享纯查询、SMT回退0。该计数包含证明阶段查询，不等于4807次源码条件判断。
- composite_loop_dll 两个明确节点链接/数据的用例，两种 VC 范围均 PASS，回退0。链表本身不会必然导致退出困难。
- init_array/init_array2/init_array_rev 共18个原输入，两模式36次均 execution_completed=true，回退0。当前12 PASS、24残余VC UNKNOWN；24个 UNKNOWN发生在证明层，不能说成未退出循环。
- list_all 的 IntList_rev_loop，逻辑列表长度0/1/2/3，空间两模式8次均完成。空表回退0，非空表有共享查询SMT回退；最终均因入口证明尚未闭合而UNKNOWN，不是退出失败。

branch_evaluation 是共享纯可达性查询入口的统计，正数无法定位到某一个 while 条件，更不能解释为 SMT UNKNOWN 次数。0说明该入口无需回退，但不表示整个执行器没有任何其他 SMT 调用。逻辑列表内容固定可能足以确定长度和退出，即使内部节点地址仍为符号；此时 SMT/资源策略仍可能是正常且必要的。

## 确实没有固定唯一退出轮次的原用例

`qcp_shape_dll_iter` 和 `qcp_shape_dll_reverse` 的输入只给 `l/p=4096`，values={}；前条件为 `dlistrep_shape(root,0)`，没有给逻辑长度或完整next链接。它们代表一族有限长度不固定的链表，不能视为完整具体堆测试。

当前两种 VC 范围共4次均在8次展开上限停止：UNKNOWN / loop_unroll_limit / execution_completed=false。entry-exit 每例有32次共享纯查询SMT回退。iter轨迹中的后继持续成为新的存在变量，例如末尾 `y_580_free` 仍与 `dlistrep_shape(y_580_free,y_576_free)` 相连；退出分支和继续分支在不同允许堆上都可能成立。未观察到证据表明这里是一个完全具体布尔式的SMT超时。

补足具体节点/尾部终止关系，或使用带固定逻辑列表/长度的输入，才是在测试一个确定有限实例。现有 shape-only 用例应继续作为欠实例化的能力边界测试保留；本次没有替它们选择任意长度来改成PASS。

## 条件可判定，仍因预算停止

原控制专项 `nonterminating-limit` 为 `n=3; while(n>0){}`。每轮条件都确定为真，SMT回退0，但没有状态进展，16次展开后UNKNOWN。它不是“退出条件无法计算”。

本轮新增只调整运行配置的诊断：原 bound_loop、n=3、相同源/输入，在展开上限2时两模式均UNKNOWN/loop_unroll_limit，回退0；上限8时两模式均PASS，回退仍0。这说明有限循环也能因预算停止。到达上限不代表循环必然不终止，也不代表单步条件难以判断。

## 覆盖审查与后续建议

对45组 variants/*/cn/*.c 和 variants/*/qcp/*.c 去除注释后扫描，直接包含while/for的组只有 init_array 和 list_all；本次已补跑其现有循环目标。这个扫描不包含头文件调用图、递归、Fulminate harness的清理循环或其他paper数据集。此前21个完整组的1800次回归不能单独作为循环退出覆盖证据；循环能力还需查询用例与控制专项支撑。

完整具体输入测试、shape-only能力边界、死循环、有限循环预算不足应分别说明。后置/入口/不变式VC的UNKNOWN应与执行未完成分开解释。当前只保留整次执行的既有判定体系，不新增逐VC expected，也不改变输出格式。

证据见 [机器审计与逐例查询记录](../benchmark/results/loop-exit-audit/20261019/audit.json)、[44次benchmark复跑](../benchmark/results/loop-exit-audit/20261019/benchmark-replay/summary.json)、[有限循环预算诊断](../benchmark/results/loop-exit-audit/20261019/finite-limit-diagnostic/summary.json)。原生时间/RSS见各report和measurement；模型/ITP调用为0。仅做定向审查，不更新历史组成本或完整组数。

复现冻结查询：
```sh
python3 -B scripts/replay-query-simplification.py --binary bin/tespec-symexec \
  --output /tmp/tespec-loop-query-review --check
```
44次复跑驱动为结果目录的 replay-benchmark.py；输出目录须未存在。有限预算诊断各job.json可直接用run_job重放。init_array_rev保留原策略字节，使用既有with_legacy_strategy_locator.py临时定位兼容，执行后清理；没有改源规约。
