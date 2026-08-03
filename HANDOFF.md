# TeSpec 开发交接

更新日期：2026-08-03

仓库：`https://github.com/taylor-swift-13/TeSpec`

默认分支：`main`

本文编写前最后一次已推送提交：`21a71ec2`

## 1. 项目当前目标

TeSpec 是一个确定性的 QCP concrete specification tester。输入包括：

- C implementation；
- QCP specification；
- spec 引用的本地 QCP/Coq 依赖；
- 顶层 C 参数和 QCP `With` 变量的 concrete bindings。

工具对每个 bind 独立执行目标函数，并用真实终态检查原始 `Ensure`，输出
`PASS / FAIL / UNKNOWN / ERROR`。核心执行和结果分类不能调用大模型，也不能把
有限 concrete tests 描述成一般程序验证。

当前仓库还包含一个双向生成 benchmark：

- `code-to-spec`：给 C implementation，生成 QCP spec；
- `spec-to-code`：给 QCP spec 和 C ABI，生成 C implementation。

benchmark 当前只保留一道正式题：`ModeConvert_AMMFun`。三个 `demo` 是提示中的
无关示例，不是额外评测题。

## 2. 当前可复现状态

在本文编写时：

- Python 要求：3.10+；
- QCP executor：`bin/qcp-symexec`；
- bundled QCIP runtime：`runtime/qcip`；
- 已提交的 Coq `.vo` 模块：392 个；
- residual proof checker 要求 Coq 8.20.x；
- `make check` 通过，共 79 项测试；
- benchmark gold oracle：30/30 reference states 通过，12/12 mutants 被杀死；
- Git 工作区在增加本文前是干净的，并与 `origin/main` 同步。

任何功能修改完成后至少运行：

```bash
make check
git diff --check
git status --short
```

## 3. 仓库地图

| 路径 | 作用 | 是否可直接修改 |
|---|---|---|
| `spectest/core.py` | 分析 spec、物化 bindings、调用 QCP、归类结果、管理 residual VC | 可以，但必须增加通用回归；禁止题目特判 |
| `spectest/cli.py` | `analyze`、`run`、`check`、`check-proof` CLI | 可以，保持 CLI 向后兼容 |
| `bin/qcp-symexec` | 已修改并打包的原始 QCP 符号执行器 | 二进制；替换时必须验证运行时与清单 |
| `runtime/qcip` | QCIP/QCP headers、strategies、Coq 源码及预编译模块 | 共享运行时；不要混入题目私有依赖 |
| `skills/qcp-spec-test` | 使用 concrete binds 测试 spec 的工作流 | 与 CLI 行为同步维护 |
| `skills/tespec-e2e` | 从 implementation 编写、修正并 mutation-test spec | 每题固定 30 个有效 binds |
| `skills/tespec-artifacts` | 初始化、清理、hash、验证 `e2e/` 持久产物 | 只能由管理脚本写 artifact manifest |
| `e2e/iplib_ModeConvert_AMMFun` | 当前唯一完整 E2E 证据包 | 变更持久文件后必须重新 finalize/validate |
| `benchmark/experiments/spec-synthesis-tester-ablation-20260731` | 当前唯一双向生成 benchmark | 协议输入受 SHA-256 清单约束 |
| `tests` | 核心、产物、mutation matrix、benchmark 回归 | 功能修改必须同步补测试 |
| `paper` | 论文源文件 | `.aux/.log/.out` 是本地可再生产物 |

## 4. TeSpec 核心执行链路

主要入口是 `python3 -m spectest` 或安装后的 `qcp-spectest`。

### 4.1 分析

```bash
python3 -m spectest analyze IMPL.c \
  --spec-file SPEC.qcp \
  --function FUNCTION \
  --write-binds /tmp/binds.json
```

`spectest.core.attach_spec_to_source` 负责确定性地把独立 spec 附到目标函数上；
`analyze_source` 发现 C 参数、value-level/type-level `With`、derived bindings 和
支持状态。不要让模型手工拼接 annotated C。

### 4.2 Concrete execution

```bash
python3 -m spectest run IMPL.c \
  --spec-file SPEC.qcp \
  --function FUNCTION \
  --binds BINDS.json \
  --output-dir /tmp/tespec-run
```

每个 bind 独立特化和执行。核心支持 concrete C 参数、逻辑值、指针 heap、有限
循环/递归、可见 callee、QCP `Let` separation definitions 和 source-declared
strategies。不要为函数名、case id、具体回归值、predicate 名或 struct layout 添加
自动层特判。

结果语义：

- `PASS`：QCP/SMT 关闭该 bind 的全部 VC；
- `FAIL`：具体执行或 obligation 确定违反 spec；
- `UNKNOWN`：存在 residual VC 或达到有限执行上限；
- `ERROR`：bindings、parser、依赖或执行环境错误。

`bindings_violate_require` 是无效测试输入，不是程序错误。`UNKNOWN` 绝不能升级为
`PASS`，除非 `check-proof` 对对应 manual residual proof 返回成功。

### 4.3 Residual proofs

只能编辑 manifest 指向的 `proof_manual.v`，然后运行：

```bash
python3 -m spectest check-proof PATH/TO/vc/manifest.json
```

禁止 `Admitted`、`Abort`、新增公理或假设。模型/人工填写的证明必须标记为
`manual`，不能算作 QCP/core automation。

## 5. 当前 E2E 证据包

目录：`e2e/iplib_ModeConvert_AMMFun/`

权威文件：

- 原始来源：`source/original/`；
- frozen spec：`spec/final_spec.c`；
- 30 个 concrete binds：`tests/binds.json`；
- 8 个 refinement mutants：`mutants/refinement/`；
- 4 个 held-out mutants：`mutants/heldout/`；
- reference 与 mutation 摘要：`reports/`；
- 语义清单：`manifest.json`；
- 文件完整性清单：`artifact-manifest.json`。

当前结果是 reference 30/30 `PASS`、8/8 refinement mutants killed、4/4 held-out
mutants killed。它只证明列出的 concrete inputs 上没有观察到违反，不是一般正确性
证明。

修改 E2E 持久文件后执行：

```bash
python3 skills/tespec-artifacts/scripts/manage_artifacts.py finalize \
  --kind e2e \
  --task-id iplib_ModeConvert_AMMFun \
  --root e2e/iplib_ModeConvert_AMMFun

python3 skills/tespec-artifacts/scripts/manage_artifacts.py validate \
  --manifest e2e/iplib_ModeConvert_AMMFun/artifact-manifest.json
```

不要手工编辑 `artifact-manifest.json`。

## 6. 当前双向生成 benchmark

目录：`benchmark/experiments/spec-synthesis-tester-ablation-20260731/`

### 6.1 Public inputs

`code-to-spec` 只公开：

- `input/impl.c`；
- 三组 `demo/*.c`、`demo/*.qcp`、`demo/*.annotated.c`；
- 当前 ablation condition 指定的工具接口。

`spec-to-code` 只公开：

- `input/interface.h`；
- `input/spec.qcp`；
- 同样的三组 demo 和工具接口。

模型输出必须符合 `output-schema.json` 或 `code-output-schema.json`。

### 6.2 Ablation conditions

- `no-tool`：模型只自行检查；
- `qcp-tool`：允许看到原始 `qcp-symexec` 的公开报告；
- `tespec-tool`：允许看到 `syntax_checker.py` 的 attachment、binding、parser、
  state-interface 或 C parser 报告。

模型通过 `codex exec --ephemeral` 运行，workspace 为只读，内部 Codex 工具行为会被
审计。三组条件必须保持相同的 stateless call 数量，最终提交在进入 hidden judge
前冻结。公开工具不能读取 hidden C states、mutants、counterexamples 或最终分数。

### 6.3 Hidden judge

持久测试输入是 `hidden/states.json`，schema 为 `tespec-c-state-suite/v1`。每个 case
记录：

- 顶层 C `args`；
- concrete object address；
- struct type；
- C field values。

它不记录 gold spec 的 binder 名。`state_adapter.py` 从候选 spec 的
`Require store(field_address, with_variable)` 建立字段到候选 `With` 变量的结构映射，
然后只在 hidden judge 的临时输出目录生成执行器所需 binds。binder alpha-renaming
不应改变分数。

当前结构接口要求：

- 每个 typed `With` 输入变量必须由一个直接 `Require store` 唯一映射；
- 支持 `&(((Type *)root)->field)` 和 `&(root->field)`；
- 重复变量、重复字段、缺失字段、非唯一对象或不一致地址必须拒绝；
- `Require` 中额外的常量约束允许存在；
- 不求解 computed binder expressions。

`code-to-spec` 需要 reference 30/30 通过并杀死全部 12 个 mutants。其分数是 positive
pass rate 与 mutation score 的均值，避免 vacuous postcondition 获胜。
`spec-to-code` 使用固定 public gold spec，在 30 个 hidden C states 上全部通过才算
正确。`split.json` 将测试划分为 6 个语义组，每组 5 个 case。

注意：这里的 “hidden” 指 runner 不向被测模型暴露。测试和 mutants 当前仍在公开
仓库中，因此它们对仓库读者并不保密。如果未来要发布真正不可见的 leaderboard，
必须把 `hidden/states.json` 和 held-out mutants 移到独立私有 judge，并重新设计清单
和 CI 注入方式。

### 6.4 Benchmark commands

只运行 gold oracle，不调用模型：

```bash
python3 benchmark/experiments/spec-synthesis-tester-ablation-20260731/run.py \
  --oracle-audit
```

检查候选 spec 的公开语法/结构接口：

```bash
python3 benchmark/experiments/spec-synthesis-tester-ablation-20260731/syntax_checker.py \
  code-to-spec --submission candidate.qcp
```

完整三条件 live run：

```bash
YUNWU_API_KEY=... \
python3 benchmark/experiments/spec-synthesis-tester-ablation-20260731/run.py \
  --direction both \
  --condition all \
  --attempts 1 \
  --rounds 2
```

当前 runner 中 `MODEL = "gpt-5-nano"`，provider base URL 是
`https://yunwu.ai/v1`。修改模型或 provider 必须同时更新
`dataset-manifest.json`，并明确区分协议变化与模型消融结果。API key 只能通过
`YUNWU_API_KEY` 传入，禁止写入源码、prompt、trace、文档或 Git 历史。

## 7. 产物边界

benchmark 目录只保存题目、demo、判题协议和 hidden judge 输入，不保存任何模型
运行结果。默认结果目录在仓库外：

```text
/home/yangfp/teSpec-artifacts/benchmark-results/
```

可通过 `TESPEC_ARTIFACT_ROOT` 或 `--output-dir` 修改。不要重新创建
`benchmark/results`，也不要把 live model traces、frozen submissions、judge 临时
binds、stdout/stderr 或 matrix workspace 提交到 benchmark。

普通 TeSpec CLI 默认产生的 `.spectest/`、Python bytecode、Ruff cache、Coq 编译
缓存和论文 `.aux/.log/.out` 都是可再生产物，应保持 ignored。相比之下，
`e2e/<case>/reports/` 是冻结 spec 的可审计持久证据，由 artifact manifest 管理；
它与 benchmark live-run 结果不是同一类文件。

## 8. SHA-256 清单维护

`benchmark/.../dataset-manifest.json` 锁定 public inputs、runner、checker、adapter、
hidden states 和 mutants。任何被锁定文件发生变化后都必须更新对应 SHA-256，否则
`tests/test_bidirectional_synthesis.py` 会失败。

计算单个文件：

```bash
sha256sum PATH
```

不要为了让测试通过而删除清单项。先判断变更是否属于协议：

- public input/demo 变化：新 benchmark revision；
- hidden states/split/mutants 变化：新 judge revision；
- runner/checker/adapter 变化：新 harness revision；
- 仅仓库外 raw results 变化：不修改清单。

## 9. 测试入口

```bash
make lint       # Ruff check + format check
make test       # unittest
make runtime    # bundled binary/runtime/Coq module sanity
make check      # 上述全部
```

测试职责：

- `tests/test_spectest.py`：核心分析、bindings、执行与 proof 行为；
- `tests/test_mutation_matrix.py`：mutation runner；
- `tests/test_artifacts.py`：产物初始化、清理、finalize、validate；
- `tests/test_bidirectional_synthesis.py`：benchmark 清单、prompt 隔离、C-state
  mapping、alpha-renaming、public checker、gold oracle 和仓库外结果路径。

涉及 QCP executor 的全量测试通常需要约一分钟。不要把小型模型消融测试加入 Git；
它们应写到仓库外，完成分析后删除或明确归档。

## 10. 已删除或明确不再支持的旧方向

以下内容已按产品决策移除，不应在没有新需求和设计评审时恢复：

- four-class `complete / soundness / incomparable / correct` benchmark；
- four-class candidate construction infrastructure；
- condition-specific skill snapshots；
- superseded multi-task benchmark fixtures；
- 仓库内 benchmark results。

当前任务不是判断固定 `(impl, spec)` 的四分类，而是生成缺失的一侧，并由冻结后的
hidden test machine 判断生成结果。

## 11. 已知限制与优先改进方向

1. benchmark 只有一道正式题，当前结果只能说明该题上的工具消融，不能支持跨题
   泛化结论。
2. `state_adapter.py` 是针对 direct struct-field `store` 的轻量结构映射，不是通用
   QCP constraint solver。扩展到数组、别名、多对象或 derived expressions 时应新增
   schema 和通用 adapter 测试，不能堆目标函数特判。
3. `syntax_checker.py` 的 state-interface validation 当前只对
   `ModeConvert_AMMFun` 启用。增加第二道题时应把 task contract 数据化，而不是继续
   添加函数名分支。
4. runner 的模型和 Yunwu provider 当前写死在协议中。若要做可比较实验，建议显式
   引入 versioned run config，并把模型、轮数、timeout、condition 和 seed/请求元数据
   写入仓库外报告。
5. hidden inputs 位于公开仓库，只实现模型工作区隔离，不实现对参赛者保密。
6. `spectest/core.py` 较大。未来拆分时应按 analysis、binding encoding、QCP process、
   Coq residual proof、reporting 分层，并先用现有测试锁定行为。

增加新 benchmark 题之前，优先完成第 2、3 项的数据化；否则多题会复制当前题的
硬编码结构。

## 12. 修改检查清单

### 修改 TeSpec core

1. 确认规则对 QCP AST/类型普遍成立，不引用 case/function/bind id。
2. 增加最小正例、负例和 UNKNOWN/ERROR 边界测试。
3. 运行 `make check`。
4. 检查没有生成文件、凭据或 `.spectest/` 被加入 Git。

### 修改当前 benchmark

1. 明确 public surface、hidden judge 或 harness 哪一层发生变化。
2. 保持模型冻结后才进行 hidden judgment。
3. 保持三种 condition 的 stateless call 数相同。
4. 更新相关 schema/split/hash 和 benchmark README。
5. 运行 gold oracle和 `make check`。
6. raw results 只写仓库外，不提交小测试结果。

### 增加新的 E2E case

1. 使用 `tespec-artifacts init` 创建独立 `e2e/<case-id>`。
2. 保留原始 implementation，版本化 spec。
3. 生成恰好 30 个有效且不重复的 binds。
4. reference 全部 `PASS` 后再进行 mutation testing。
5. final spec 冻结后使用未参与修正的 held-out mutants。
6. finalize 并 validate artifact manifest。

## 13. 接手后的建议顺序

```bash
git status --short
python3 -m pip install -e '.[dev]'
scripts/check-runtime.sh
make check
python3 benchmark/experiments/spec-synthesis-tester-ablation-20260731/run.py \
  --oracle-audit \
  --output-dir /tmp/tespec-oracle-audit
```

然后依次阅读：

1. `README.md`；
2. `benchmark/README.md`；
3. 当前 experiment 的 `README.md`、`dataset-manifest.json` 和 `split.json`；
4. `run.py`、`state_adapter.py`、`syntax_checker.py`；
5. `tests/test_bidirectional_synthesis.py`；
6. 需要修改核心时再阅读 `spectest/core.py` 和 `skills/qcp-spec-test/SKILL.md`。

若上述命令与本文不一致，以当前代码、测试和 versioned manifest 为准，并在同一次
提交中更新本文。
