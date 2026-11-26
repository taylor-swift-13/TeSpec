# Benchmark 与 Results 存储规范

本文是 `benchmark/` 存储的唯一现行规范。其他文档中的带日期实验目录、完整运行树和原始日志描述仅记录历史实验，不构成后续评测的保存要求。发生冲突时以本文为准。

## 当前双路线产物

每组使用相同的三个入口。读取 `result-cost.json` 的 `current_evaluation` 得到本轮结果与分阶段成本。`result-cost.csv` 是同一组阶段记录的逐行导出，`result-cost.md` 展示工具结论、逐策略匹配数和阶段成本。旧 JSON 字段保留原批次口径。原始测试、证明义务和模型尝试以哈希引用。

- `tespec/current-executions.json` 每行对应一个变体、一个输入、一种执行策略。记录预期、实际执行源哈希、原生和 Auto 的状态、耗时、单进程峰值 RSS、token 和原生分支计数。
- `tespec/current-itp.json` 按同一次执行的原生报告哈希保存 ITP 结果。一个输入的一次执行合并处理全部残余义务。模型生成和修复、Coq 编译与假设审计、独立内核检查分别计量。证明源码按内容哈希存储。单独记录内核接受的运行库假设。
- ITP 生成或修复使用 `gpt-6.1-sol`，推理强度固定为 `medium`。输入和输出 token 取自 CLI 事件，缓存输入包含在输入 token 内。模型内存记录 Windows 客户端单进程 Peak Working Set，Coq 与执行器记录 Linux 单进程峰值 RSS，以 KiB 展示。
- 分支四列分别为条件查询、实例判真、实例判假和 SMT 回退次数。一个条件可能被查询多次。原生阶段只计一次，Auto 和 ITP 复用该结果。没有残余时两条后续路线均跳过。
- 原生超时未返回分支计数时填 `null`。区分真实零、阶段未调用、数据缺失及未完成；阶段合计须同时展示已测与所需执行数。旧证明的模型和强度按当时回执说明。
- 全局索引的 `current_route_measurement` 记录当前版本覆盖情况。`complete_groups` 按各组归档并审计的四工具证据计数。异常索引在 `benchmark/results/tespec-unexpected/current-routes.json`，可由组和行号定位完整输入、执行报告和 ITP 回执。

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
        ├── tespec/{routes.json,results.json,statistics.json}
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

- 每个 case 的预期、原生状态和预期匹配结果；新双路线评测分别记录 Auto 和 ITP 的状态、成本与证据来源。已判定输入的两条后续路线记为 `NOT_RUN`，历史串行批次保留原口径；
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
