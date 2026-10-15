# Benchmarks

CN/Fulminate benchmark 按程序组组织，入口为 [programs/index.json](programs/index.json)，共 45 组。原始 76 个 CN 文件保存在仓库的 [arxiv/fulminate-cn](../arxiv/fulminate-cn/README.md)，不在 benchmark 下存放来源快照。

```text
benchmark/programs/
  index.json
  <程序组>/
    manifest.json
    variants/<变体 ID>/
      manifest.json
      cn/<程序文件>.c
      qcp/<程序文件>.c
      tests/
        inputs.json
        cases/<输入记录 ID>.json
```

CN/QCP 文件仅在已有对应版本时出现；不伪造缺失的翻译。变体允许实现、规约或两者改变，不规定正负比例。每组仅主程序需要形式验证，优先复用匹配的 CN/QCP 历史验证和 Coq 证明；其他变体只要求多用例测试。目前主程序的显式绑定仍待整理，`primary_variant: null` 不代表旧证明失效，也不表示已完成绑定。

测试输入按变体归入组内；所有原始结果、日志和统计数据统一保存在 `benchmark/results/`，组内清单仅引用结果路径。历史 main 的存在不代表已执行；输入集合可含多个用例，不能把集合数当用例数。已有测试未覆盖的变体仍保留缺口。

历史输入、迁移脚本和证明源文件保存在 [arxiv/benchmark-support/selection](../arxiv/benchmark-support/README.md)。`benchmark/results/evidence.json` 给出文件当前位置及原始哈希；[path-map.json](../arxiv/benchmark-support/path-map.json) 解析旧报告中的原路径。迁移不修改证据原文，不重新运行验证、不改变 PASS/UNKNOWN 或时间、内存、token 值。

结果目录：

```text
benchmark/results/
  index.json
  evidence.json
  relocation-map.json
  historical/selection/       已有测试、验证、模型与性能结果
  historical/grouped/         各变体关联的历史结果
  read/20261015-variants/      read 组新补的多用例测试、日志和统计
```

`read` 本轮覆盖 10 个配对配置、13 条版本记录、61 对变体与输入。Fulminate 运行 61 次，teSpec 运行 61 次；UNKNOWN、ERROR 与 FAIL 分开统计。其他程序组尚未补齐的测试仍保留为缺口。

重建与审计：

```sh
python3 tools/benchmark/build_program_groups.py
python3 tools/benchmark/build_program_groups.py --check
python3 tools/benchmark/audit_archive.py
```

其他既有目录 `paper-cn-qcp/`、`executor_e2e/`、`comparison/` 和 `experiments/` 是独立历史实验或开发回归，不属于这 45 组来源快照。

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

## 完整测试口径

完整测试包括执行测试和必要的 ITP 阶段，正式结果以两阶段合并后的结论为准。自动阶段的 UNKNOWN 应在 ITP 中证明或反证；已有决定性结果无需重复 ITP。主程序的全称验证仍单独复用，不要求所有变体额外做全称验证。规则见仓库根目录下 `benchmark/protocol.json`。

read 的正式入口为 `benchmark/results/read/complete/results.json`、`statistics.json` 和 `cases.csv`，包含 61 对变体与输入的执行结果、ITP 结论及最终结论。原始自动数据完整保留，但不作为完整测试的最终正确率。时间统计包含两阶段实际测得的工作、失败证明尝试和内核检查；共享工作仅计一次。ITP 峰值内存和对话内证明编写 token 未测，保留 null，不能用执行阶段开销代替完整开销。
