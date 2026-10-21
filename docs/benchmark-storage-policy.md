# Benchmark 与 Results 存储规范

本文是 `benchmark/` 存储的唯一现行规范。其他文档中的带日期实验目录、完整运行树和原始日志描述仅记录历史实验，不构成后续评测的保存要求。发生冲突时以本文为准。

## 目录边界

```text
benchmark/
├── protocol.json
├── programs/
│   ├── index.json
│   └── <group>/
│       ├── manifest.json
│       ├── evaluation-plan.json
│       └── variants/
│           └── <variant>/
│               ├── manifest.json
│               ├── cn/<source>.c
│               └── qcp/<source>.qcp.c
└── results/
    ├── index.json
    ├── group-result-cost-index.json
    └── <group>/
        ├── index.json
        ├── cases.csv
        ├── result-cost.md
        ├── result-cost.json
        ├── result-cost.csv
        ├── cn/{results.json,statistics.json}
        ├── qcp/{results.json,statistics.json,proof/}
        ├── fulminate/{results.json,statistics.json}
        ├── tespec/{results.json,statistics.json}
        └── evidence/
            ├── evaluation.json
            ├── native-verification.json
            ├── inline.json
            └── modular.json
```

现有组可以继续使用已经发布的等价文件名和路径，不为目录外观复制数据。`index.json` 负责指出该组唯一的活动结果和证明。

## `benchmark/programs` 保存什么

这里只保存实验输入和语义身份：

- CN、QCP 源文件；
- 变体 ID、来源、实现/spec 身份和源文件 SHA-256；
- 主 CN/QCP 配对；
- case 的参数、逻辑输入、初始内存、合法前条件、预期状态和判定依据；
- `expected_by_tool`、`expected_by_execution_strategy` 等显式预期覆盖；
- 必要的 include、规约和证明依赖及其哈希。

普通输入直接写入 `evaluation-plan.json`。只有无法简洁表示的大型数组、图或字节堆才保存独立 fixture。不得为每次运行长期建立 `tests/<run-id>`、重复 harness 或 binds 目录。

## `benchmark/results` 保存什么

这里只保存不可替代的结论和成本：

- 每个 case 的预期、原生状态、ITP 后最终状态和是否匹配；
- Fulminate、teSpec spatial SMT OFF/ON、inline/modular 的判定；
- 各阶段 wall time、最大进程 RSS、token、模型调用数和尝试次数；
- 复现命令、工具/二进制哈希、源哈希、输入或 harness 哈希；
- CN 主程序成功验证摘要；
- QCP 原始 Goal 哈希、义务数量、证明结果、假设审计和独立内核检查；
- 异常或预期 ERROR 的关键诊断、退出状态和必要日志哈希；
- 组级结果成本表及全局索引。

一次重跑更新该组的活动证据摘要，不新增日期目录。历史失败和修复尝试写入同一摘要的 `attempts`，只记录影响成本或结论的状态、时间、RSS、token、错误摘要和日志哈希。

## 正式 QCP 证明例外

正式证明必须保留：

- 原始 Goal；
- 最终 `Candidate.v`；
- Coq 编译与假设审计收据；
- 独立 `coqchk` 收据；
- 模型、token、时间、RSS 和全部计费尝试的摘要。

如果新运行的 Goal SHA-256 与已有正式证明完全相同，只引用既有证明，不复制第二套 Goal、Candidate 或检查目录。

## 不进入 Git 的数据

- executor/job 快照；
- instrumented C、编译产物和临时 harness；
- OFF/ON、inline/modular 重复生成的 Goal、auto、manual、check 文件；
- 空日志及可由命令重建的 stdout/stderr；
- driver/worker 源快照；
- 整仓文件哈希清单和重复 toolchain 快照；
- 每次运行的逐阶段目录树；
- 临时模型工作区、编译目录和缓存；
- 仅因日期或对话产生的新目录。

这些数据可以在 `/tmp` 或未跟踪的临时评测目录中存在到发布审计完成，之后删除。

## 发布顺序

1. 在临时目录运行全部工具并完成 ITP/Coq/内核检查。
2. 生成组级结果、成本和证据摘要。
3. 运行 `validate_group_evaluation.py` 检查活动源、输入、CN、QCP Goal/证明绑定和最终判定。
4. 运行 `python3 tools/benchmark/compact_group_evidence.py --group <group>`。
5. 再次运行验证器；只有压缩后仍通过才可提交。
6. Git 只提交上述长期文件。

每个程序组最终只有一份输入与预期、一份当前正式结果、一份四工具成本表、一份极简证据摘要，以及必要时的一份正式 QCP 证明。

## 已发布旧格式的迁移

前 22 组使用 `tools/benchmark/compact_published_groups.py` 一次性迁移。迁移先核对源文件和主程序证明哈希，把旧测试绑定与分模式预期并入组内输入计划，再保留逐阶段成本、模型实际用量、失败尝试摘要和正式 QCP/ITP 证明依赖，最后删除可再生文件。大型机器证据使用紧凑 JSON，人工查看使用 MD/CSV 成本表。

迁移审计入口为 `benchmark/results/storage-migration-audit.json`；各组 `index.json` 的 `durable_evidence` 指向当前输入和策略结果。审计逐项检查迁移前后的数值与判定不变量、源/证明字节和活动 JSON 哈希，不冒充重新运行验证器或 Coq 内核。

```sh
python3 tools/benchmark/compact_published_groups.py --audit
python3 tools/benchmark/validate_group_evaluation.py --group <group>
```

迁移前旧验证器已有的格式不兼容和审计失败单独记录在迁移回执中；清理不改写这些历史问题或实验结论。
