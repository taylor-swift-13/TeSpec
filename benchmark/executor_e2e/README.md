# 分类端到端测试

测试入口是 `scripts/run-executor-e2e.py`。每个测试通过公开的 `python3 -m spectest run` 命令调用打包的执行器，检查实例化、Require 可满足性、实际符号执行、VC 文件和资源报告。两个模式都运行；不启动 ITP Agent。

当前矩阵包含 **52 个功能程序、37 个专项场景，18 类、1,322 次运行**。功能程序各有 4 组输入、原程序/错误后条件/程序变异三个版本，以及两个执行模式；专项场景各运行两个模式。

| 分类 | 检查内容 | 运行数 |
|---|---|---:|
| `scalar_control` | 分支、switch、短路求值 | 96 |
| `integer_semantics` | 负数除法和余数、位运算、移位 | 96 |
| `loops` | for/while/do、嵌套循环、continue、边界次数 | 120 |
| `recursion` | 递归、互递归、多个返回路径 | 72 |
| `calls` | 重复调用、局部帧、递归别名、实参快照 | 96 |
| `arrays` | 求和、复制、反转、前缀和、排序、查找 | 240 |
| `strings` | 终止符、长度、字符替换 | 48 |
| `pointer_alias` | 别名写入、交换、二级指针、指针槽 | 96 |
| `structs` | 字段、嵌套结构体、按值参数、结构体返回 | 96 |
| `linked_structures` | 链表遍历、递归、双向链表反转 | 72 |
| `trees` | 二叉树、递归写入、共享子树 DAG | 72 |
| `allocator_patterns` | 零长度、对齐取整、清零 | 48 |
| `logical_predicates` | 定义展开、守卫、嵌套定义、存在量词 | 96 |
| `vc_boundaries` | assert/inv/Require/Ensure/which-implies 不改写执行状态 | 18 |
| `precondition` | 别名冲突、数组重叠/相邻、值域及纯约束矛盾 | 16 |
| `c_safety` | 越界、悬空局部、缺失所有权、溢出、除零、非法移位 | 24 |
| `incomplete` | 循环/调用预算、缺失函数体/契约/返回值 | 10 |
| `declarations` | 仅声明、有/无规约、抽象 Require | 6 |

## Oracle 和负例

`cases.py` 独立计算返回值和可观察堆内容。运行器先编译、运行原生 C，检查其结果与 Python 计算一致，再执行规约测试。原生程序使用有定义的小整数和有效内存；故意不安全的专项场景只交给规约执行器。单元格、数组、字段和指针关系共同组成观察结果。

每个功能程序包含两类反例：

1. 修改绑定的预期返回值，保留实际程序与堆输入。
2. 改变程序中的运算、分支或内存写入，保留原后条件。原生 C 必须证明至少一个输入能区分该变异；某个输入未触发差异时，允许它通过。

正确用例要求 Require=SAT、执行完成、安全性及后条件通过。错误后条件要求执行完成，但返回 VC 留为 manual、后条件和总体状态 UNKNOWN。这证明自动阶段没有关闭错误义务，不能解读为 ITP 已证明反例。矛盾 Require 要求 UNSAT/INVALID；明确的不支持和执行错误有单独预期。`contract_binding_unknown` 当前可能没有可交给 ITP 的调用入口 VC，该限制单独保留。

运行器还检查结果 ID 完整性、模式语义版本、四类 VC 文件、不可变文件哈希、执行器时间/CPU/峰值 RSS，并拒绝复用非空输出目录，防止读取旧结果。执行器尚未启动的输入错误不要求执行器资源测量。测试运行前后核对二进制哈希。

## 复现

在 teSpec 的 `tespec` 工作树运行：

```bash
python3 scripts/run-executor-e2e.py --output /tmp/tespec-e2e-new-run
```

依赖 Python 3.10+、C 编译器、`/usr/bin/time` 和随 teSpec 提供的执行器/runtime。可显式设置 `--binary`、`--runtime`、`--cc`、`--jobs`。按类别或程序缩小范围：

```bash
python3 scripts/run-executor-e2e.py \
  --category structs --category trees --category linked_structures \
  --output /tmp/tespec-memory-new-run

python3 scripts/run-executor-e2e.py --program defined_cell \
  --output /tmp/tespec-return-correlation-new-run
```

`--category`、`--program` 可重复，两组过滤条件取交集。无匹配程序时报错。任何原生 oracle 不一致、结果不符或产物缺失都使脚本以非零状态退出。

产物结构：

```text
report.json                      # 分类统计、每条预期差异、时间/CPU/RSS
inventory.json                   # 程序、变异、输入和源码哈希
artifacts/<类别>/<程序>/
  native-reference/              # 原生 oracle 源码、编译及执行日志
  native-mutant/
  <版本>/program.c
         binds.json
         expected.json
         <模式>/report.json
                artifacts/<输入>/  # 特化源码、executor.json、日志、VC
```

紧凑结果存于 [executor-e2e-results.json](../../paper/executor-e2e-results.json)，完整本地运行保留于报告的 `artifact_root`。新增程序只需添加一个 `Program` 描述，给出源码、类型化输入、原生初始化/观察、Python oracle 与可区分的程序变异；执行器不按程序名称分派。

## 相关工作与覆盖边界

用户提供的 *Code-Specify-Test-Debug-Prove: Flexibly Integrating Separation Logic Specification into Conventional Workflows* 中，工具名称是 Fulminate、Darcy 和 CN。其 §4.3–4.5 研究部分规约、24 个规约错误，以及分配器的零长度、对齐、整数范围等问题。本矩阵据这些错误类别设计所有权、错误条件、off-by-one、部分契约和分配器边界测试。[论文](https://doi.org/10.1145/3808278)、[官方实验产物](https://zenodo.org/records/19577402)。

QCP 使用 32 位地址模型；本机原生 C 使用主机 ABI。交叉检查比较整数、字段值和指针别名关系，不比较数字地址、`sizeof` 或二进制布局。

这里的程序为独立编写，没有移植 pKVM 分配器，也没有复现论文性能数据。链表、树、DAG 使用有限的符号地址形状；任意抽象递归谓词、动态分配和完整 C 语言仍需进一步覆盖。原生 oracle 交叉检查所选实例，不能替代执行器健全性的机器检验证明。

QCP 原始示例另有两层评估：`run-spec-test-regressions.py` 的 40 个有预期用例，以及 `run-qcp-corpus.py` 的整个目录合成输入扫描。扫描中的 UNKNOWN/ERROR/NEEDS_BINDINGS 是覆盖障碍，不能作为通过的正确性测试。
