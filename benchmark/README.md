# Benchmarks

当前选集采用 **[完整 CN/Fulminate 基线＋分类 QCP/CAV 扩展](selection/README.md)**。
固定上游 CN 版本的 54 个主程序及 22 个补充 C 输入全部收录，保留 pKVM 工业例；
另按符号堆、逻辑定义、量词、注解边界和 ITP 补证选择 32 个 QCP 目标、18 个 CAV 目标。
总量由覆盖范围决定，不再固定为 80。逐项来源、选入理由、待补能力和证据入口见
[清单](selection/catalog.json)及[可读表格](selection/programs.csv)。

| 目录 | 用途 |
|---|---|
| `selection/` | 当前选例规则、完整 CN 源码快照、分类清单和能力缺口 |
| `paper-cn-qcp/` | 已有配对输入、内存扩展、冻结结果及证明证据 |
| `executor_e2e/` | 开发回归 |
| `comparison/` | 专项诊断和历史比较 |
| `experiments/` | 代码／规约生成实验 |

完整收录与完整配对运行分别统计；源文件归档不产生新的测试结论。检查当前选集：

```sh
python3 benchmark/selection/build_catalog.py
```

## 双向生成实验

The generation benchmark evaluates two inverse generation tasks:

- `code-to-spec`: synthesize a QCP specification from a C implementation;
- `spec-to-code`: synthesize a C implementation from a QCP specification and
  ABI declarations.

There is no training split and no semantic feedback loop. The model receives
three unrelated QCP examples in raw and annotated forms. The three ablation
conditions provide no tool, the original QCP symbolic executor, or TeSpec.
Final submissions are frozen before the hidden test machine runs.

The current audited task is
[`experiments/spec-synthesis-tester-ablation-20260731`](experiments/spec-synthesis-tester-ablation-20260731).
It contains six semantic groups of five hidden cases. Specification
submissions must also reject all hidden incorrect-program mutations. Hidden
cases record concrete C object states; candidate-specific QCP binds are derived
structurally from `Require store(...)` terms only after submission freeze.

Raw model traces and judge artifacts are not part of the benchmark. By default,
the runner writes them outside the repository under
`../teSpec-artifacts/benchmark-results/`. Durable protocol inputs and their
SHA-256 values are recorded in the experiment's `dataset-manifest.json`.
