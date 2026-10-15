<div align="center">

# TeSpec

### Concrete specification testing for QCP-annotated C

输入 **C implementation + QCP spec**、spec 引用的 **Coq definitions /
strategies** 和具体 **binds**，直接得到逐测试用例的
`PASS / FAIL / UNKNOWN / ERROR / INVALID`。

[![Python 3.10+](https://img.shields.io/badge/Python-3.10%2B-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![Coq 8.20](https://img.shields.io/badge/Coq-8.20-7C3AED)](https://coq.inria.fr/)
[![Automation](https://img.shields.io/badge/Automation-QCP%20%2B%20SMT-0E7490)](#结果解释)
[![Core](https://img.shields.io/badge/Core-model--free-334155)](#结果解释)

[`测试一道新题`](#测试一道新题) ·
[`命令行接口`](#命令行接口) ·
[`Binds`](#binds-输入) ·
[`完整参考`](docs/usage-reference.md)

</div>

---

TeSpec 先检查实例化的 Require 是否可满足，再检查安全性和 Ensure。指针地址默认符号化；通过逻辑变量绑定内存内容，允许部分实例化。

两种模式都会实际执行循环和可用函数体，并检查入口 Require、程序安全性和最终 Ensure：

- `--execution-mode entry-exit`（默认）：入口/出口检查；中间证明注解默认忽略。`--annotation-policy check-preserve` 在状态副本上检查注解。
- `--execution-mode all-boundaries`：所有边界检查；额外在每次经过 assert/inv、调用及返回边界时生成检查 VC；检查不修改执行状态。

旧名称 `expand` / `no-expand` 仍分别作为 `entry-exit` / `all-boundaries` 的输入别名；teSpec 报告统一使用新名称。原始 SAC 输出保留二进制协议名称。

只有声明且有规约的目标执行 Require 检查，安全性和 Ensure 为 `NOT_RUN`；执行中调用只有声明时报告 `UNKNOWN/missing_function_body`，没有契约时报错。前条件不满足为 `INVALID`，未关闭 VC 为 `UNKNOWN`。自动流程不启动证明 Agent。

新默认执行器为 `bin/tespec-symexec`，旧的 `bin/qcp-symexec` 保留给已冻结的历史实验。运行目录只保留 `report.json` 和 `artifacts/`；每例记录分阶段结果、VC、墙钟时间、CPU 时间和最大进程 RSS。

[本次实现与验收记录](docs/evaluation/spec-test-implementation.md)包含两种模式的使用方式、实际测试结果和剩余障碍。

可选 `--spatial-smt` 对剩余有限空间 return VC 进行自动判定；默认关闭，未判定的 VC 继续保留给 ITP。参见[空间 SMT 后端](docs/spatial-smt.md)。

## 使用流程

每次测试都对应一个具体 bind。程序执行结束后，TeSpec 仍使用实际终态检查
目标函数的原始后置条件；“程序能够运行结束”本身不等于 `PASS`。

## 快速开始

```bash
git clone https://github.com/taylor-swift-13/TeSpec.git
cd TeSpec
python3 -m pip install -e .
scripts/check-runtime.sh
```

运行 spec test 需要 Linux x86-64、glibc 和 Python 3.10+。只有检查 manual
residual proof 时需要 Coq 8.20.x。

运行时无需 QCP/sac 源码，使用仓库自带的 `bin/tespec-symexec` 和
`runtime/qcip`（验证头文件、策略和逻辑库）。重新构建执行器才需要仓库外的
sac checkout；teSpec 不收录 sac 执行器、编译器或 SMT solver 源码。

## 测试一道新题

新题不需要复制到 `cases/`，也不需要登记或修改项目文件。准备包含目标
implementation 与 QCP spec 的 C 文件；如果 spec 导入了 Coq 模块或 strategy，
同时提供这些依赖文件。

若公开题面把两者保存为独立的 `impl.c` 和 `spec.qcp`，保持两份输入不变并在
下面的命令中添加 `--spec-file spec.qcp`。TeSpec 会确定性组装供 QCP 使用的临时
source；模型只需要填写 binds。

推荐把一道新题组织成：

```text
my-problem/
├── SOURCE.c
├── predicates.h                  # 可选：QCP declarations / Let definitions
├── predicates.strategies         # 可选：QCP strategy rules
└── dependencies/coq/
    └── Logical/Module.v          # 可选：Import Coq 对应的逻辑模块路径
```

例如源码包含 `Import Coq Require Import Logical.Module` 时，对应文件放在
`dependencies/coq/Logical/Module.v`。其传递导入也按逻辑模块路径保存；工具会
递归发现并复制到每个 bind 的 VC 目录。

### 1. 自动发现需要绑定的变量

```bash
python3 -m spectest analyze /path/to/SOURCE.c \
  --function FUNCTION \
  --write-binds binds.json
```

分离输入等价写法：

```bash
python3 -m spectest analyze impl.c \
  --spec-file spec.qcp \
  --function FUNCTION \
  --write-binds binds.json
```

`analyze` 会列出：

- `argument_bindings`：目标函数的全部 C 形参；
- `value_bindings`：spec 中需要具体化的 value-level `With`；
- type-level `With {A}`：需要具体类型实例时填入 `types`。

如果同一函数有多个 full spec，添加 `--spec SPEC_NAME`。如果 QCP declaration
或 `include strategies` 位于其他目录，可重复传入 `-I INCLUDE_DIR`。

### 2. 填入具体测试输入

编辑刚生成的 `binds.json`。一个文件可以放任意多条测试：

```json
[
  {
    "id": "no_wrap",
    "args": {
      "state": 4096,
      "data_length": 2,
      "area_length": 8,
      "force": 0
    },
    "values": {
      "l": [1, 3, 0]
    }
  },
  {
    "id": "wrap_and_force",
    "args": {
      "state": 8192,
      "data_length": 3,
      "area_length": 8,
      "force": 1
    },
    "values": {
      "l": [1, 7, 0]
    }
  }
]
```

顶层函数的全部 C 参数必须出现在 `args`。执行所需的 heap 由具体指针参数、
`values` 和 `Require` 一起物化；callee 的参数在调用点自动计算。

### 3. 直接运行

```bash
python3 -m spectest run /path/to/SOURCE.c \
  --function FUNCTION \
  --binds binds.json \
  --output-dir .spectest/my-run
```

分离输入使用同一份 binds：

```bash
python3 -m spectest run impl.c \
  --spec-file spec.qcp \
  --function FUNCTION \
  --binds binds.json \
  --output-dir .spectest/my-run
```

有限循环或递归较深时，可显式调整安全上限：

```bash
python3 -m spectest run /path/to/SOURCE.c \
  --function FUNCTION \
  --binds binds.json \
  --loop-unroll-limit 128 \
  --call-depth-limit 128 \
  --timeout 60
```

命令会在终端打印逐 bind 结果，并在输出目录保存 `report.json`、特化后的
`specialized.c`、QCP 日志和对应 VC 证据。

## 命令行接口

| 接口 | 用途 |
|---|---|
| `analyze SOURCE --function F [--spec-file S]` | 分析内嵌或独立 spec，并可用 `--write-binds` 生成模板 |
| `run SOURCE --function F --binds binds.json [--spec-file S]` | 用 concrete binds 执行 implementation 并检查原始 spec |
| `check job.json` | 运行已保存、可复用的 job |
| `check-proof vc/manifest.json` | 检查已填写的 manual residual Coq 证明 |

查看任意接口的完整选项：

```bash
python3 -m spectest analyze --help
python3 -m spectest run --help
python3 -m spectest check --help
python3 -m spectest check-proof --help
```

## Binds 输入

| 区域 | 绑定对象 | 支持的友好输入 |
|---|---|---|
| `args` | 顶层 C 形参 | 整数、布尔、具体指针地址、原始 QCP expression |
| `values` | value-level `With` | `Z`、`bool`、嵌套 list、constructor tree、raw QCP term |
| `types` | type-level `With {A}` | `option Z`、`list Z` 或任意合法 Coq 类型 |

常用逻辑值：

```json
{
  "integer": -7,
  "list": [1, 2, 3],
  "nested_list": [[1, 2], [], [3]],
  "constructor": {"ctor": "Some", "args": [9], "type_args": ["Z"]},
  "typed_raw": {"type": "addr_avl_tree", "qcp": "avl_node_model(...)"},
  "large_unread_heap": {"symbolic": true}
}
```

构造子可以递归嵌套，因此 `option`、pair、tree 和用户自定义 inductive 不需要
Python 预先认识。无法唯一推断的任意 Coq 类型可以使用显式 `type + qcp` 形式。

指针地址可以保持符号化；用逻辑值实例化内存内容和结构，别名关系由 Require 中的
等式与空间断言表达。只有测试地址本身的数值性质时才需要绑定具体地址。更多格式见
[binds reference](skills/qcp-spec-test/references/binds.md)。

## 结果解释

| 状态 | 含义 |
|---|---|
| `PASS` | Require 已判定 SAT，执行已完成，所选 VC 已关闭；仅声明的目标另标注 specification-only |
| `INVALID` | 实例化 Require 不可满足 |
| `FAIL` | 某个具体 obligation 确定为假，该执行不满足 spec |
| `UNKNOWN` | 存在 residual VC，或达到循环/调用深度上限；绝不视为成功 |
| `ERROR` | binds、parser、依赖或运行环境错误 |

自动证明只来自通用 assertion 归约与 QCP/SMT，保存为 `proof_auto.v`。核心没有
二级 `coq_auto`，也不会自动填写 `proof_manual.v`。

`Import Coq` 引入的 `.v` 文件提供逻辑定义和证明环境；它不自动等价于可执行的
heap 规则。自定义 separation predicate 如果使用 QCP `Let` 定义，可以直接展开；
如果只用 `Extern Coq` 声明，还必须提供相应 strategy，执行器不会猜测其内存布局。

如果产生 residual VC，可由人或模型填写 manifest 指定的 manual proof，再运行：

```bash
python3 -m spectest check-proof .spectest/my-run/CASE/vc/manifest.json
```

检查器会拒绝 `Admitted`、`Abort`、新增公理等 proof escape，并通过 Coq 8.20
内核检查证明。manual 结果始终与 QCP/SMT 自动证明分开标记。

## 支持的测试对象

- 标量、指针、数组和数组切片；
- 闭合结构体及其字段内数组；
- QCP `Let` 分离谓词；
- 有策略定义的 `Extern Coq` predicate；
- 单链表、双链表与数组/结构体的递归组合；
- 有限循环、嵌套循环、函数调用和有限递归；
- `Z`、`bool`、嵌套 `list`、多态类型和任意 constructor tree；
- 整数与当前 QCP store 支持的闭合浮点路径。

当前承诺范围以数组、闭合结构体、单/双链表及其组合为主；树和一般图暂不在承诺
范围内。完整 assertion 语法见
[QCP assertion coverage](docs/qcp-assertion-coverage.md)。

## 模型辅助（可选）

仓库按职责提供三个独立 skill：

- [qcp-spec-test](skills/qcp-spec-test/SKILL.md)：测试已有 QCP spec，填写
  binds、诊断 `FAIL / UNKNOWN`、检查 residual proof；
- [tespec-e2e](skills/tespec-e2e/SKILL.md)：从实现出发创建或修复 spec，
  生成 30 个 binds 并进行 mutation 回归，产物统一写入 `e2e/`；
- [tespec-artifacts](skills/tespec-artifacts/SKILL.md)：初始化、清理、哈希索引和
  校验上述任务产物。

人已经填写的 binds 会原样保留。模型不参与核心执行和自动结果分类。

完整 job schema、执行语义与证据文件说明见
[使用参考](docs/usage-reference.md)。

---

<div align="center">
<sub>Concrete tests · explicit proof provenance · no hidden model calls</sub>
</div>

### 执行状态与诊断

两种模式都从实例化 Require 出发，实际执行循环和有函数体的调用，并持续化简当前公式 P。
Assert、Inv、Require、Ensure 只在副本上生成检查义务，不替换 P。每次调用创建新鲜参数和局部存储，指针所指的堆保持共享，返回全部实际可行结果。

可添加 `--instance-trace`，或设置 `qcp.instance_trace: true`。
该兼容选项记录逐程序点的 P、内存和纯约束；它不维护另一份可变实例状态。
轨迹位于 `artifacts/<case>/executor.json`，默认关闭。

详见 [形式化](paper/instance-semantics.md) 和
[执行保持语义的回归记录](docs/evaluation/inline-preserve-implementation.md)。

分类端到端测试见 [测试说明](benchmark/executor_e2e/README.md)：18 类、1,322 次运行，
含原生 C/Python oracle、错误后条件和程序变异；[结果](paper/executor-e2e-results.json)。
