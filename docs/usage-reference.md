# TeSpec 使用接口参考

`qcp-spectest` 的公开输入是：

1. 一份同时包含 QCP spec 和 C implementation 的源文件；
2. 目标函数及可选的 named spec；
3. 若干组 `binds`，每组 bind 就是一条具体测试用例。

输出按 bind 给出 `PASS / FAIL / UNKNOWN / ERROR`，并保存特化源文件、QCP
日志和 Coq VC。核心框架完全确定性，不调用大模型。

## 执行语义

这不是普通的全称验证模式。工具先把目标函数的全部 C 形参和顶层 spec 的逻辑输入
同时绑定到具体值，再用修改过的 QCP 符号执行器逐语句执行目标函数：

- `while`、`for`、`do-while` 不要求循环不变式；条件每轮求值并剪枝；
- 有函数体的 callee 不使用 callee spec，而是直接执行函数体；
- 调用发生时自动计算实参，建立 fresh callee 参数栈单元，把当前 heap 带入；
- callee 返回后自动删除其参数栈单元，把返回值和修改后的 heap 合回 caller；
- 支持嵌套调用和有限递归，每次调用使用独立 PSTree 运行帧；
- 具体列表上的 `Zlength`、`Znth` 和列表下标在送入 SMT 前归约；SMT 判真的
  safety VC 进入 `proof_auto.v`，不再重复生成 manual split witness；
- 递归 `Let` 谓词展开时，对构造器等式做通用一阶合一，直接实例化存在变量；
  分支选择只依赖闭合 guard，不在每一层递归调用 SMT；
- 目标函数执行结束后仍按原始 `Ensure` 生成和检查 VC。

自动和 manual 的边界按证明来源固定：

- `qcp_auto`：QCP/SMT 已写入并核验 `proof_auto.v`；
- `manual`：QCP/SMT 未关闭，保持
  `UNKNOWN / residual_vc_requires_proof`，只允许在 `proof_manual.v` 中由模型
  或人完成。

核心不包含 `coq_auto`，也永远不会填写 `proof_manual.v`。自动层不读取程序名、
案例名或 binds id；QCP 归约只处理 assertion AST 上的通用闭合运算和有界量词，
随后统一交给 SMT。

因此每条顶层用例必须填写 `args`（目标函数 C 实参）和 `values`（required
value-level `With`）。不填写 callee binds；callee 的 C 参数绑定完全来自调用点。
即使 callee 自己带 spec，只要函数体可见，具体模式也优先执行函数体；只有无函数体
的外部声明才回退到 spec 摘要。

循环和调用都有防护上限：

- 超过 `loop_unroll_limit`：`UNKNOWN / loop_unroll_limit_exceeded`；
- 超过 `call_depth_limit`：`UNKNOWN / call_depth_limit_exceeded`。

上限不会被当成成功。

## 最短用法

项目已经自带修改版执行器和 QCP/QCIP 运行时资源，不需要
`/home/yangfp/sac_c_parser` 或 `/home/yangfp/QCIP` 才能运行：

- `bin/qcp-symexec`：修改版具体符号执行器；
- `runtime/qcip/QCP_examples`：通用 headers 和 strategies；
- `runtime/qcip/SeparationLogic`：通用 Coq VC 基础库。

领域相关资源不放在全局 runtime。每个回归案例自己保存 C、header、strategy 和
`.v` 依赖；Coq 文件按逻辑模块路径放在
`cases/CASE/dependencies/coq/LOGICAL/MODULE.v`。工具从源码及递归 include
中发现 direct/`From ... Require Import`，本地优先并递归 stage 传递依赖。
不存在项目级 `providers` 兜底目录：源码中的 `include strategies` 必须能从
源码目录或该 job 显式配置的 `qcp.include_dirs` 中解析，避免案例隐式串用依赖。

可先检查项目内资源和系统依赖：

```bash
scripts/check-runtime.sh
```

先分析目标 spec：

```bash
cd /path/to/specTest
python3 -m spectest analyze SOURCE.c --function FUNCTION [--spec SPEC]
```

如果逻辑签名位于非相对路径可找到的 header，给 analyze 同样的 `-I DIR`。工具会
递归读取本地 quoted includes，仅用于发现 `Extern Coq` 参数类型。

分析结果分别列出：

- `argument_bindings`：目标函数全部 C 形参，每个都为 required；
- `value_bindings`：value-level `With`；

- `"required": true`：用户或模型必须填写；
- `"binding_mode": "derived"`：由 `Require` 中的常量或其他逻辑 bind 推出，
  不应重复填写；
- type-level `With {A}`：默认可保持多态；需要具体实例时在该 case 的
  `"types"` 中填写，例如 `"types": {"A": "option Z"}`。

注意 `Require n == N` 中，顶层 C 参数 `n` 必须在 `args` 中填写，逻辑变量
`N` 仍按分析结果在 `values` 中填写。只有 callee 的 C 参数会在实际调用点自动
得到。

创建 binds：

```json
[
  {"id": "empty", "args": {"p": 4096, "n": 0}, "values": {"xs": []}},
  {
    "id": "three",
    "args": {"p": 8192, "n": 3},
    "values": {"xs": [4, 8, 15]}
  }
]
```

然后直接运行：

```bash
python3 -m spectest run SOURCE.c \
  --function FUNCTION \
  --binds BINDS.json \
  --loop-unroll-limit 64 \
  --call-depth-limit 64 \
  --output-dir .spectest/my-run
```

已有 job 也可运行：

```bash
python3 -m spectest check cases/callee_heap/job.json
```

## Binds 输入

`args` 绑定目标函数 C 实参：

- 整数/布尔形参用 JSON 整数或布尔；
- 指针形参用具体数值地址，例如 `4096`；不同且不可别名的对象使用不同地址；
- 复杂表达式可用原始 QCP expression；
- 必须包含目标函数全部形参，不能包含未知名字；无参函数写 `"args": {}`。

`values` 绑定 spec 的 value-level `With`：

- `Z`、`nat`、整数型：JSON 整数，如 `-7`；
- `bool`：JSON `true / false`；
- `list Z`：JSON 数组，如 `[1, 2, 3]`，自动编码成 `cons(..., nil)`；
- 嵌套 list（例如 `list (list Z)`、`list (list (list Z))`）直接使用嵌套 JSON
  数组；编码器按 `With` 声明的 Coq 类型递归编码；
- 任意归纳类型的构造子树：
  `{"ctor": "Some", "args": [9], "type_args": ["Z"]}`；
- 显式类型和值：
  `{"type": "option Z", "value": {"ctor": "Some", "args": [9]}}`；
- 任意 Coq/QCP 类型的无损后备形式：
  `{"type": "addr_avl_tree", "qcp": "avl_node_model(...)"}`；
- 已知正确的任意 QCP 逻辑项也可直接写
  `{"qcp": "<QCP expression>"}` 或原始字符串。

`ctor` 可递归嵌套，所以 tree、option、pair、用户自定义 inductive 等不需要
Python 预先认识其类型。QCP 的 C assertion parser 从目标 `With` 类型推断
constructor 的多态实参；`type_args` 用于明确记录/校验输入意图。

例如 `sll(p, xs)` 同时给 `args.p` 一个地址、给 `values.xs` 一个列表；QCP
根据 `Require` 在该地址物化有限 heap。执行器不按 `sll`、struct 名或字段名写
特例：

- QCP `Let P(...) = assertion` 按定义做多态/值参数替换和分支展开；
- 递归或相互组合的 `Let` 谓词不要求预设深度；只要控制下一节点的地址/构造器
  数据已由 binds 闭合，就按实际结构展开，并受 predicate application limit
  保护；
- `Extern Coq` 分离谓词使用源码通过 `include strategies` 声明的规则；
- 只有 Coq declaration、没有 `Let` 或 strategies 的谓词没有可执行语义，工具
  不会猜测它的 heap 布局，只能保留 residual VC 或报告无法执行。

## Job 格式

```json
{
  "source": "callee_heap.c",
  "function": "callee_heap",
  "spec": "optional_named_spec",
  "binds": [
    {
      "id": "three_increments",
      "args": {
        "p": 4096,
        "n": 3
      },
      "types": {
        "A": "option Z"
      },
      "values": {
        "v": 4,
        "N": 3
      }
    }
  ],
  "output_dir": "../../.spectest/callee_heap",
  "qcp": {
    "loop_unroll_limit": 64,
    "call_depth_limit": 64,
    "include_dirs": ["QCP_examples/QCP_demos_LLM"],
    "timeout_seconds": 30
  }
}
```

`qcip_root` 和 `binary` 通常不需要填写；默认分别解析为当前项目的
`runtime/qcip` 和 `bin/qcp-symexec`。只有显式测试另一套运行时时才覆盖它们。
因此复制整个 `specTest` 目录后，路径会随项目位置自动变化。

每个 bind 可单独覆盖 job 的 `"spec"`。每组 `args` 必须包含目标函数全部 C
形参；每组 `values` 必须包含分析结果中所有 required value-level 变量，不能
包含未知变量；`types` 只能包含该 spec 的 type-level `With` 变量。

## 结果和 residual VC

- `PASS`：QCP/SMT 已关闭全部 VC；
- `FAIL`：QCP 得到确定的不一致 obligation；
- `UNKNOWN`：路径上限或尚未关闭的 VC，不等于 spec 错误；
- `ERROR`：job、parser、执行器、超时或环境错误。

QCP/SMT 未关闭的目标保存到 `vc/manifest.json`，结果为
`UNKNOWN / residual_vc_requires_proof`。只允许修改 manifest 指定的
`proof_manual` 文件，然后运行：

```bash
python3 -m spectest check-proof PATH/TO/vc/manifest.json
```

检查器验证其余 Coq 文件哈希，拒绝 `Admitted`、`Abort`、新公理等绕过方式，并用
Coq 8.20 编译完整证明。`check-proof` 的 PASS 表示 manual residual 已通过
Coq 检查；它不被重新标记成 QCP 自动证明。

## Codex skill

skill 位于 `skills/qcp-spec-test`，并安装到
`~/.codex/skills/qcp-spec-test`。skill 规定：

- 框架、执行、分类、proof checking 不使用模型；
- 只有缺少 binds 时的测试选择，以及 residual Coq 证明可使用模型；
- 模型生成的证明始终写入 `proof_manual`，并按 manual proof 报告；
- 人写 binds 时必须原样保留；
- 不为 callee 生成 binds。

需要独立无人值守模型层时：

```bash
skills/qcp-spec-test/scripts/run-agent.sh SOURCE.c FUNCTION [BINDS.json]
```

该脚本参考 CAV 的 Codex runner，固定使用 `gpt-5.4-mini` 和 medium
reasoning。

## Assertion 语法

Python 只解析 function-spec 外壳和 `With`，`Require / Ensure` assertion
主体完整交给项目自带 `bin/qcp-symexec` 中的 QCP assertion parser。详细语法见
[QCP assertion coverage](qcp-assertion-coverage.md)。
