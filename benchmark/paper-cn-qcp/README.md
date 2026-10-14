# 论文用 CN–QCP 配对 benchmark

本目录用于比较**同一 C 程序、同一组输入、语义对应的函数 contract**。原来的
`benchmark/experiments/` 是代码／规约生成实验，`benchmark/executor_e2e/` 是开发回归，
`benchmark/comparison/` 是探索性比较及证明归档；本目录是独立、固定的论文数据集。

初始集合有 **14 个共同集程序＋2 个 case study**，每个 4 组输入，共 64 组输入。
每例有参考规约和错误后条件。15 例有 CN/QCP 配对源文件；CAV 整数幂例保留原始
QCP 规约及 CN 表达差距记录，没有用手写枚举算法伪装成等价的直接 CN 输入。

当前工作集见 [80 项目录](expansion80/README.md) 和 `package-audit.json`：原 80 项
已有 79 套 CN/QCP 双版本、10,027 个冻结输入，每套包含 reference、spec mutation、
implementation mutation。第 80 项工业 pKVM buddy allocator 尚缺完整配对，不能宣称
80 项全部完成，也不能据程序数量声称优于其他论文实验。另在 `memory-controls/`
增加 3 个独立内存机制对照，共 384 个冻结输入；它们不冒充原始 CN/QCP 上游例子，
不改变原 80 项的分母。下面的 16 项清单保留为初始集合的历史说明。

## 最新扩展：超出 80 项的原始内存程序

本轮新增 **20 个源自 QCP/CN-Fulminate 的程序，256 个固定输入**，全部包含两类 mutation。
其中 6 个已完成 CN/QCP 双边回放，两边 600 个结果全部一致；11 个 QCP 原始复杂内存例子、
3 个 Fulminate 原始复杂内存例子保留单边结果及配对缺口。已准备的配对套件总数为 **88**，
连同单边分组共 **109 个目标函数条目**；不把单边/UNKNOWN 算作完整比较。

覆盖新增跨函数结构体字段、frame、双向/多态链表、侵入式环形链表、队列的分配释放、
链表插入和归并排序。新输入只实例化 Pre 自由变量；旧固定输入保留历史版本。
详细来源、绑定规则、支持缺口与复现命令见 [内存扩展记录](memory-expansion.md)，
机器可读结果见 `review-20261014/memory-expansion/summary.json`。

## 较早的 QCP 原生内存例子扩充（历史记录）

`qcp-native-examples/catalog.json` 新增 **7 个 QCP examples 原程序、28 组冻结绑定**，
每例保留逐字节一致的参考源文件及原规约，另存规约 mutation 和实现 mutation。
这批属于 QCP 原生例子分组，CN 翻译尚待完成，不计入上面的已配对程序数量。

| 原文件 | 堆描述与内存类型 |
|---|---|
| `QCP_demos_LLM/2DIntArray.c` | `IntArray2::full`，连续二维整型矩阵 |
| `QCP_demos_LLM/2DIntPtrArray.c` | `IntPtrArray2::full`，指针表与独立行存储 |
| `QCP_demos_LLM/2DCharPtrArray.c` | `CharPtrArray2::full`，字符串指针表与终止符 |
| `QCP_demos_human/dll_queue.c` | `store_queue`，首尾指针及双向链表 |
| `QCP_demos_human/functional_queue.c` | `store_queue`，两个单链表共同表示一个队列 |
| `QCP_demos_human/bst_insert.c` | `store_tree`，二级根指针与二叉树；选原 `low_level_spec` |
| `QCP_demos_human/eval.c` | `store_expr`，含 union 的表达式节点及环境数组 |

绑定直接实例化各原规约的 `With`：嵌套列表、队列逻辑序列、树构造子和表达式构造子，
不把复合谓词替换成手写 `data_at` 堆。当前 eval 输入覆盖 CONST/VAR 分支，递归运算符
构造子的输入还需补齐。所有原始声明函数也保留；未添加假的 malloc/free/reverse 实现。

本次 84 次变体执行的 test_result 全部为 UNKNOWN：9 次入口证明未完成、63 次执行期间
读权限匹配错误、12 次缺少函数体。原始 ERROR 诊断另存于 `diagnostic_status`，不隐去。
这些是当前算法面对原规约的支持缺口，不能记为 mutation 被发现或已完成双工具验证。
详见 `qcp-native-examples/replay-report.json`。运行与完整性检查：

```sh
python3 benchmark/paper-cn-qcp/qcp-native-examples/validate.py
python3 benchmark/paper-cn-qcp/qcp-native-examples/run.py --output .spectest/qcp-native-examples
```

较早候选清单中的多态链表、LiteOS 环形侵入式双链表已加入本轮新分组；
带父指针 BST、AVL 旋转的完整绑定与回放仍待完成。

CN 来源也不全是数组：初始集合的 `cn_list_length` 是链表，`cn_transpose` 是结构体，
`cn_swap` 是分离单元，`cn_slf9_basic_transfer_aliased` 是别名指针。原 80 项中实际有
17 项 CN 来源、13 项 QCP 来源、46 项 CAV 来源、3 项机制控制和 1 项工业分配器候选。
当前集合偏数组反映选样偏向，不能据此推断 CN 数据集只有数组。

## 2026-10-14：固定输入、内存覆盖与复现

- `audit-package.py` 检查文件哈希、CN/QCP 可执行体对应、两类 mutation、绑定名字、
  入口地址、别名与内部偏移、显式存储块不重叠；不宣称能判定任意前条件。
- `replay-frozen.py` 直接读取套件里的 `qcp_bind` 和原生内存构造，评估时不调用 LLM、
  不重新采样。`--sample-count 0` 跑完整固定集合；其他值是明确记录 ID 的回归子集。
- 原 79 套涵盖分离/别名单元、结构体、一维数组、字符串、链表与二叉树。
  `memory-controls/` 补入连续二维矩阵、数组内部指针、含指针字段的结构体。
  共享/循环图、双链表、非连续二维指针矩阵、union、malloc/free 及生产分配器仍有缺口。
- 对每个输入独立判断 mutation 是否违反对应性质；幸存输入应为 PASS。
  UNKNOWN、超时、执行错误和缺失结果都不计为杀死 mutation。
- `instantiation/` 保存抢劫、背包与内部指针的地址实例化对照；来源、绑定、二进制哈希
  和各阶段结果保存在运行报告里。完整遍历与顶层后条件证明分别统计。

从 teSpec 根目录运行（需要已有 CN `tespec-cn-5.2` opam switch）：

```sh
python3 benchmark/paper-cn-qcp/audit-package.py
python3 benchmark/paper-cn-qcp/validate.py
python3 benchmark/paper-cn-qcp/replay-frozen.py \
  --output .spectest/cn-qcp-full --sample-count 0 --jobs 3 --timeout 3
python3 benchmark/paper-cn-qcp/replay-frozen.py \
  --suites benchmark/paper-cn-qcp/memory-controls/suites \
  --output .spectest/memory-controls-full --sample-count 0 --jobs 2 --timeout 3
python3 benchmark/paper-cn-qcp/instantiation/run.py --output .spectest/address-ablation
```

所有输出目录必须是新的。并发运行结果用于正确性回归，不能据此比较工具耗时。
原始大体积输出在本地 `evidence/20261014*` 中保留；最终汇总见 `review-20261014/`。

完整重跑采用每输入 3 秒、循环与调用上限 128；所有套件都使用全部固定输入：

| 集合 | 程序/输入 | CN：PASS / FAIL | teSpec：PASS / FAIL / UNKNOWN |
|---|---:|---:|---:|
| 原 80 项中已配对部分 | 79 / 10,027 | 14,487 / 15,594 | 9,558 / 10,339 / 10,184 |
| 补充内存机制对照 | 3 / 384 | 570 / 582 | 221 / 301 / 630 |

表中工具结果包括 reference、spec mutation、implementation mutation 三种变体；
FAIL 是预期的 mutation 反例，不代表参考程序错误。原生 32/64 位的全部参考输入均通过。
未观察到 false PASS、false FAIL 或缺失结果。UNKNOWN 是实验发现，不能算作 mutation
被发现，也不能宣称所有程序性质已经证明。结果摘要见 `review-20261014/summary.json`。

### 地址与逻辑堆的实例化原则

测试实例应固定程序可观察的输入。对 `IntArray::full(a,n,l)`，固定 `n,l` 就固定
元素内容；数组位置由基址与元素宽度确定。对 `sll(p,xs)`，具体 `xs` 固定长度与数据，
内部节点仍可能是存在量化的地址；普通不观察绝对地址的遍历通常只需要这些关系。
树构造子可以固定形状、键和值，但共享节点或地址参与计算时需要更丰富的逻辑模型。
因此绑定所有 `With` 变量不等于消除了谓词内全部存在量化，也不必等于逐字节堆转储。

实际的“抢劫”例子是 `LLM_bench/Algorithms/house_robber/house_robber.c` 的 `rob`。
对 `n=5, l=[2,7,9,3,1]`，`nums` 符号化或固定为 4096 都得到入口 SAT、安全 PASS、
执行完成；最后残留 `HouseRobberAnswer(l,12)`。原生 32/64 位返回 12，另用枚举所有
不含相邻下标的选择集合独立验证最优值。该后置条件通过存在的选择列表及最大值定义
描述全局最优性，不能仅靠入口地址实例化自动证明。这里逻辑列表已刻画全部输入数组。

基地址按实际块大小、对齐与目标 ABI 分配；保留 `p == q`、`cursor == a + k` 等
约束，不能给每个参数强行分配独立区域。`undef_full` 固定区域和大小，不应擅自
把未初始化数据改为零。新内存的分配结果是执行结果，除非实验明确控制 allocator，
不属于函数入口绑定。

背包 `n=capacity=3` 的两个输入列表和 16 个未初始化 DP 单元已确定所需区域。
数值化 weights/values/dp 三个基址即可消除入口处的区间非重叠搜索；后置条件中的
`exists dp_l` 是输出，不应强行绑定。当前执行器在内部指针案例上另有局限：数值
4104 与 `IntArray::full(4096,5,l)` 的第 2 个元素未能匹配，而保留符号基址和偏移
可通过。该现象保留为回归，不通过修改程序体或切换绑定来隐藏。


## 程序清单

| ID | 来源 | 核心性质 | 分组 |
|---|---|---|---|
| cn_abs | CN tutorial / abs | 有符号整数绝对值，正负分支及边界 | 共同集／基础 |
| cn_swap | CN tutorial / swap | 分离的两个单元交换 | 共同集／基础 |
| cn_transpose | CN tutorial / transpose | 结构体字段交换 | 共同集／基础 |
| cn_array_swap | CN tutorial / array_swap | 指定下标交换，其他元素不变 | 共同集／中等 |
| cn_list_length | CN tutorial / list/length | 递归链表长度与内容保持 | 共同集／中等 |
| qcp_list_length | QCP examples / sll.c | 迭代链表长度与内容保持 | 共同集／中等 |
| qcp_list_reverse | QCP examples / sll.c | 链表结果等于原序列反转 | 共同集／中等 |
| qcp_list_append | QCP examples / sll.c | 两个分离链表的内容拼接 | 共同集／中等 |
| qcp_array_sum | QCP examples / sum.c | 有界整数数组求和，内容不变 | 共同集／中等 |
| qcp_array_sum_zero | QCP examples / sum.c | 返回原数组和，并将数组清零 | 共同集／中等 |
| cav_binary_search | CAV-Bench / input/algo | 查找结果或不存在性，排序前提 | 共同集／中等 |
| cav_array_reverse | CAV-Bench / input/algo | 数组反转的逐元素关系 | 共同集／中等 |
| control_weak_call | teSpec 机制对照 | 弱递归子契约与精确顶层后条件 | 共同集／中等 |
| control_tree_size | teSpec 机制对照 | 二叉树内容保持与节点数 | 共同集／中等 |
| control_unbounded_root | teSpec 机制对照 | 对所有非负整数成立的最小平方根关系 | case study：可表达、直接插桩拒绝 |
| cav_simple_power | CAV-Bench / ground_truth/p076 | 自然数指数的无界存在量词 | case study：原始量词形式的表达差距 |

CN 教程固定到 manifest 中的提交，**不宣称是 POPL 2025 原 artifact 的精确版本**。
QCP/CAV 输入保存原文件快照和 SHA-256。5 个 QCP 函数来自 sll、sum 两个源文件族；
报告应同时给函数级和来源族级汇总。3 个机制对照例单列，不能算作上游真实案例。

## 公平比较规则

1. 两种版本的可执行 C 函数体和布局相同。`abs` 统一改名 `bench_abs`，避免 GCC
   内建替换绕过插桩；CN 的链表类型做保持布局的字段重命名，具体见 case.json。
2. CN/QCP 的 Require/Ensure 保持同一数学关系及所有权条件。允许语法和数据表示
   对应，例如 CN map 与 QCP list，递归逻辑函数与 Coq 定义；不添加替代性质的
   C 检查器，不缩短量词范围，不弱化规格。
3. 工具运行的 main 只构造输入并调用函数。独立 native oracle 单独编译运行，
   不提供给 Fulminate，也不计入工具检测能力。
4. 共同集只比较函数入口／出口 contract，原程序的中间证明提示单独保留在来源
   快照中，不作为主实验输入。teSpec 使用 expand。CN 通用验证不是实例测试结果；
   `--tools cn-verify` 只是可选诊断，尤其不能将缺少循环不变式归为测试能力不足。
5. 内存输入按值、形状、别名和分离关系匹配；不要求 native 地址与逻辑地址数值
   相等。程序不观察裸地址、字节序或平台相关 sizeof。native oracle 同时跑 ILP32
   与 LP64；QCP 执行器 ABI、内存模型和 CN 版本记录在结果中，不宣称两种底层模型
   已经形式化等价。
6. 正确规约的 UNKNOWN、执行不支持、翻译失败和超时保留。错误变体在某输入上
   未被触发时允许 PASS；每个 input 的 `wrong_post_violated` 指明是否应当暴露错误。
7. 这是一套有目的的中小规模样本，不是完整 CN、QCP 或 CAV 覆盖率，也不是随机样本。
   它支持逐类比较与 case study，不支持“全面优于 CN/Fulminate”的结论。

## 文件与执行

每例目录含 `subject.cn.c`、`subject.qcp.c`、`wrong_post.*.c`、`case.json`、
`binds.json` 和 `job.json`，需要的 Coq 定义就近保存。case.json 记录来源、转换、
输入、预期返回／内存值及错误变体标签。`contracts.md` 解释规约对应关系。
`manifest.json` 固定清单，`SHA256SUMS` 固定可交付输入。

在项目根目录运行（输出目录必须为空）：

```bash
python3 benchmark/paper-cn-qcp/validate.py
python3 benchmark/paper-cn-qcp/run.py --output /tmp/paper-bench-run
python3 benchmark/paper-cn-qcp/run.py --cases cav_simple_power \
  --tools native,qcp --output /tmp/paper-power-run
python3 -m spectest check benchmark/paper-cn-qcp/cases/cn_array_swap/job.json
```

默认跑共同集和具有 CN 版本的无界量词对照。CN 使用 `tespec-cn-5.2` opam switch，
可通过 `--switch` 更换；每阶段默认超时 60 秒。完整证明重放使用 `replay-study.py`，
证明候选和固定目标哈希在 case study 的 proofs 目录。它检查全部原始 VC，包含入口、
安全性和返回目标。证明脚本是预先提供的参考证据；其重放成本不等于 Agent 构造成本。

## 用于论文的实验设计

- **共同支持范围和代价**：逐程序记录 teSpec/Fulminate 参考规约的 PASS、UNKNOWN、
  错误和超时；用相同输入比较错误规约检测。另报告预处理、实例执行、SMT、ITP 的成本。
- **错误规约检测**：分母使用已确认违反错误后条件的输入，同时报告每个错误规约是否
  被任意输入发现。未触发变异的输入、UNKNOWN 和工具错误不能混成同一个类别。
- **ITP 增益和成本**：固定自动阶段产物，比较自动结果与补充 ITP 后的结果；记录
  调用数、tokens、时间及完整 VC 检查结果。冻结参考证明不得泄漏给被评估 Agent。
- **case study**：展示原始规约、对应翻译或确切缺口、Fulminate 诊断、teSpec 轨迹与
  完整 ITP 证据。把“不能直接表达／插桩原形式”与“经过额外改写仍可测试”分清。
- **验证前筛查成本**：如后续测量此问题，比较同一证明流程是否加前置测试，并把前置
  测试的所有 ITP 成本计入总成本。本次数据集整理不产生这项性能结论。

`results/` 中的检查是可用性与标签核对；不是隔离环境下的性能测量。参考规约的正确性
依据与具体输入 oracle 分开：上游来源和规约审阅支持参考含义，native 检查支持所选
输入上的行为；全程序通用正确性并未由这些有限测试建立。
