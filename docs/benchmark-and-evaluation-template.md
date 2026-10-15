# 以 read 为基准的 benchmark 与评测产物模板

本规范以 2026-10-15 已完成的 `read` 程序组为实例。新增程序组复用其数据结构、评测流程和统计口径；变体数量、测试输入和证明方法按程序调整，不固定正负比例。

来源收录的 76 个 CN 文件已归入 45 个程序组；本文件的完整评测实例是 `read`，不表示其他组已经完成。

当前可执行策略见 [benchmark/protocol.json](../benchmark/protocol.json)。`read` 的程序入口为 [程序组清单](../benchmark/programs/read/manifest.json)，结果入口为 [结果索引](../benchmark/results/read/index.json)，四工具总表为 [comparison.csv](../benchmark/results/read/comparison.csv)。

## 1. 数据单位与计数

层级统一为：

```text
程序组
  ├── 主程序：一个确定的实现与 spec 配置
  └── 多个变体：实现、spec 或两者均可改变
        ├── CN / QCP 语言版本及对应范围
        └── 多个测试用例：参数、逻辑输入、初始内存和预期结果
```

- **程序组**：同一类程序及其实现、规约变体的集合。
- **变体配置**：固定实现与 spec 后得到的评测对象。实现或 spec 改变，形成新配置；语义相似不等于源文件或规约完全相同。
- **语言版本记录**：同一配置可能分别由 CN、QCP 文件表示，也可能在一个记录中直接保存两个文件。记录条数不能直接当成独立配置数。
- **测试用例**：某个变体上的具体输入。相同数值用于多个变体时，分别形成不同的“变体×输入”记录。
- **测试执行次数**：工具实际执行次数；ITP 的编译、反证及内核检查是测试阶段产物，不另计为新的测试输入。

`read` 的计数如下：

| 项目 | 数量与解释 |
|---|---|
| 程序组 | 1 个：`read` |
| CN/QCP 配对配置 | 10 个：3 个原始规约配置，7 个已有构造配置 |
| 语言版本记录 | 13 条：3 条原始 CN、7 条构造配对、3 条原有 QCP；后者与原始 CN 配对，不重复增加配置数 |
| 测试记录 | 61 对“变体×输入”：9 个配置各 6 个，1 个配置有 7 个 |
| 工具测试次数 | Fulminate 61 次、teSpec 61 次，共 122 次；不含形式验证、编译和内核检查次数 |
| ITP 处理的测试记录 | 12 条；不额外增加 61 的分母 |

普通输入为 `INT_MIN、-1、0、1、7、INT_MAX`。无读取所有权的配置额外测试空指针。该配置的六个非空输入在 QCP 中没有堆值 binder，因此会折叠为同一个重复的抽象非空输入状态；61 是测试记录数，不宣称有 61 个语义互异的状态。

原始 `read.broken`、`read`、`read2` 保留在同组，分别表达遗漏出口所有权、仅保证所有权、完整返回值与单元保持的规约。原始标签保留，不把所有弱规约都归为错误规约。

## 2. 文件结构

原始上游快照和历史迁移材料放在 `arxiv/`。当前 benchmark 按程序组组织；所有执行结果、证明回执、日志和统计放在 `benchmark/results/`。

```text
arxiv/
  fulminate-cn/                     固定版本原始快照
  benchmark-support/                历史输入、迁移脚本和证明源文件

benchmark/
  protocol.json                     当前评测规则
  programs/
    index.json
    <group>/
      manifest.json                 主程序、变体、四工具结果引用
      variants/<variant-id>/
        manifest.json               源码哈希、实现/spec 身份、来源和证据关联
        cn/<source>.c               有对应版本时提供
        qcp/<source>.c              有对应版本时提供
        tests/
          inputs.json               输入及来源索引
          cases/                    已有关联输入
          generated/<case-id>/
            binds.json              QCP 参数及逻辑输入绑定
            fulminate.cn.c          保留该变体目标函数与规约的运行驱动
  results/
    index.json
    evidence.json                   历史证据当前位置及哈希
    relocation-map.json             旧路径到当前位置的逐文件映射
    historical/                     冻结的历史结果及统计
    <group>/
      README.md
      index.json
      comparison.json
      comparison.csv
      cn/{results.json,statistics.json}
      qcp/{results.json,statistics.json}
      fulminate/{results.json,statistics.json}
      tespec/{results.json,statistics.json}
      complete/
        cases.csv                   执行、ITP、最终结果及预期匹配情况
        results.json                完整测试报告
        statistics.json             各阶段与完整开销
      <execution-run>/              原始测试结果、日志和资源数据
      <itp-run>/
        receipt.json
        statistics.json
        resolved-results.json
        attempt-1/
          model-receipt.json
          usage-events.json
          prompt.txt
          proofs/                   原始目标、复用辅助库、候选证明
          compilation/              stdout/stderr、resources.json
          kernel-check/             stdout/stderr、resources.json
          coq-receipt.json
```

缺少语言版本时明确记录缺口，不生成占位翻译。目录名中的稳定 ID 用于关联；可读名称写入清单，不依赖文件名推断规约含义。

旧报告的路径字符串和原始证据不批量改写。通过结果索引及路径映射解析当前位置，避免破坏已有源文件、目标和证明的哈希。

## 3. 四种工具的职责

| 工具 | 评测对象 | 完成要求 |
|---|---|---|
| CN | 每组指定的主程序 | 复用匹配的正式验证记录；确实缺失时才补验证 |
| QCP | 同一主程序的对应版本，使用未绑定具体输入的全称 VC | 完整统计 VC 生成、证明生成、Coq 编译／审计和独立内核检查；不能只报原生自动阶段 |
| Fulminate | 各变体的具体输入 | 运行真实的 CN 插桩测试，保留正常返回、断言失败、运行错误、构建失败等原始状态 |
| teSpec | 各变体的具体输入 | 执行测试，加上必要的 ITP 阶段，再汇总正式结论 |

在本评测中，QCP 是全称验证版本，teSpec 是具体输入测试版本；二者都包含各自必要的证明、编译、假设审计和内核检查，而不是将 QCP 等同于底层可执行文件。

主程序的全称验证每组只计一次，不因变体或输入数量重复计费。其他变体不要求额外做全称验证；其测试生成的具体 VC 若需要 ITP，属于完整测试的一部分。

复用验证、测试和证明必须核对实现、spec、输入、依赖、工具版本及证明上下文。仅同名或同组不能转移 PASS、反例或资源数字。已有共享辅助库可以复用，但须记录复用范围。

`read` 主程序是 `constructed:case_6d90d7cd08323aa9`。CN 验证和 QCP 原生 VC 生成选择了源码哈希匹配的历史 `read2` 第 1 次记录，未重跑，也没有将旧的三次重复实验相加。QCP 另补齐了实际计量的 gpt-6.1-sol 证明生成及 Coq 编译／审计／内核检查，完整回执位于 `benchmark/results/read/20261015-qcp-verify-complete/`。作用范围是 `read` 目标函数，不包含原始 trusted `main`。

## 4. 完整测试流程

```text
冻结变体源码、spec、测试输入和预期结果
    ↓
执行测试，保存逐用例结果、残留 VC、日志与资源数据
    ↓
对尚未确定的 VC 复用已有检查回执，或运行 ITP
    ├── 证明全部必要义务成立 → 可形成最终 PASS
    ├── 正式反证必要义务，且入口可满足 → 最终 FAIL
    └── 仍无法确定 → 最终 UNKNOWN，测试流程未完成
    ↓
汇总最终结果、预期匹配情况及包含 ITP 的完整开销
```

自动阶段的状态保留原样，不能用后来的结论覆盖原始日志。但正式 benchmark 成绩使用执行和 ITP 合并后的最终结果，不能把自动阶段正确率当成完整测试正确率。

已有决定性结果无需重复 ITP。ITP 不能通过改 spec、改目标、增加无依据假设或编写 `Admitted` 来得到接受结果。

## 5. 状态与评分

| 状态 | 含义及评分要求 |
|---|---|
| PASS | 当前输入下满足检查要求；错误变体也可能在某些输入上恰好通过 |
| FAIL | 当前输入下存在已确认的违反；与预先确定的错误预期匹配时算正确检出 |
| UNKNOWN | 尚未完成判定；需要 ITP 或其他可审计的求解过程，不算成功检出 |
| ERROR | 保留实际原因；仅明确批准且诊断匹配的错误类别可作为预期测试结果 |

`read` 中，`Require emp` 后执行 `*p`，因缺少可读单元而报错，是已批准的预期 ERROR。它不是前条件不满足：空堆前条件本身可以满足。解析错误、工具崩溃或其他无关 ERROR 不能因此自动计为正确检出。

错误变体不是每个输入都应 FAIL。例如返回常数 `0` 的错误实现在原值为 `0` 时满足完整 read 规约，这条用例的正确结果就是 PASS。评分必须逐用例确定预期，不能只根据变体的正负标签决定。

不满足该变体前条件的输入应单独标记，不作为实现违反规约的反例。程序没有穷尽所有输入时，不把有限测试通过写成全称验证通过。

## 6. ITP 证据要求

`read` 的 12 个自动 UNKNOWN 来自两个遗漏出口所有权的配置，各 6 条输入。它们的目标要求 `emp`，实际堆中仍有整数单元；正确操作是反证目标，而不是证明错误目标成立。

每条记录保留以下证据：

1. 与实际执行生成的 VC 字节一致的目标副本及 SHA-256。
2. 入口可满足性证明。
3. 原始出口 VC 及空间拆分 VC 的反证。
4. 候选证明源码、编译日志和退出码。
5. 假设审计；本例 36 项结论均为 `Closed under the global context`。
6. 独立 `coqchk` 检查命令、退出码及日志。
7. 模型、token、时间、内存和各次尝试的真实回执。

证明只引用实际目标定义和经核对的辅助库，不导入生成文件中尚含 `Admitted` 的证明模块。`read` 的 12 次需 ITP 的测试执行分别隔离计量，每次由 gpt-6.1-sol 填写该次的三个证明义务，合计 36 项结论。每次分别编译辅助库、目标、候选证明并运行独立 coqchk；失败修复尝试也计入该次成本。只复用已检查的具体堆辅助库，以前的反证解答未提供给模型。辅助库的历史编写成本不追溯计入本次，因此这是一轮明确记录了复用条件的测量，不是从零构造全部证明的冷启动成本。

## 7. 时间、内存和 token

### 时间

- QCP 和 teSpec 均分开报告四阶段：原生生成／测试执行与自动处理、agent 填写证明及修复、Coq 编译与假设审计、独立内核检查。每阶段单列时间、内存和 token，另保留完整总计。
- 完整测试时间包含必要的 ITP 开销和失败尝试。没有实际执行的步骤不填虚构数值。
- 以一次测试执行为 ITP 单位，该次全部待处理 VC、证明修复、编译和内核检查合计一次；每次独立计量，不跨输入共享一次模型调用或内核检查。最终展示逐次实测的算术平均值。历史共享批次单独保留，不纳入新均值。
- 阶段耗时之和是“已测阶段工作量”；分时复用历史执行记录时，不称为同一次连续端到端运行的墙钟时间。
- Fulminate 分开报告插桩／编译／首次执行，以及单独再次执行生成程序的运行时间；不能把包含首次执行的流水线称作纯编译时间。

### 内存

- Linux Coq／测试进程使用 GNU time `%M` 的峰值 RSS，单位 KiB。
- Windows 模型客户端使用采样观察到的进程 `PeakWorkingSet`，保留原始 bytes 及采样间隔。
- 完整流程报告顺序阶段中最大的本地进程驻留内存；它不是所有阶段内存之和，也不是并发进程树总内存，更不包含远端模型服务／GPU 内存。
- 分别保存模型客户端、Coq 编译、内核检查和测试执行的峰值，避免把证明环境的成本误认为 C 程序堆大小。

### Token

- 模型使用 `gpt-6.1-sol`，保存实际命令、尝试次数和 CLI `turn.completed` 用量事件。
- `total_tokens = input_tokens + output_tokens`。
- cached input 是 input 的子集，reasoning output 是 output 的子集，均不重复相加。
- 实际未调用模型的原生阶段可记 0；没有采集到用量的模型调用记缺失，不能记 0。
- 历史未计量的对话编写证明保留为历史。新一轮实际计量不能伪装成旧批次的追溯数据。

结论完整性与资源完整性分别标记：`verdict_complete` 与 `resource_metrics_complete`。任一必需数据缺失时，不把对应标记写成完成。

## 8. read 的基准结果

以下为本模板对应的固定数据，不是其他程序组的目标成绩。

| 工具 | 范围 | 结果 |
|---|---|---|
| CN | 主程序全称验证，复用一次 | VERIFIED |
| QCP | 主程序全称验证，复用原生阶段并完成证明链路 | 原始全称 VC 的证明及 VC_Correct 模块通过编译、封闭假设审计和独立内核检查 |
| Fulminate | 61 对变体与输入 | 60/61 符合预期 |
| teSpec 完整测试 | 同一批 61 对，包含 ITP | 61/61 符合预期 |

teSpec 自动阶段为 22 PASS、20 FAIL、12 UNKNOWN、7 ERROR；ITP 后的正式结果为 **22 PASS、32 FAIL、7 个预期 ERROR、0 UNKNOWN**。12 条 ITP 结果并未增加测试分母。61/61 是预期匹配率，不是 61 个程序都通过验证。

Fulminate 的一条不匹配是：返回值取负的错误实现，在 `INT_MIN` 输入上存在有符号溢出，实测为 Fulminate PASS、teSpec FAIL。保留该差异，不修改原始结果以凑齐正确率。

### 四工具时间、内存与 token 总表

下表直接取自各工具的 `statistics.json`，与 `comparison.csv` 一致；峰值为各自已计量阶段中最大的本地进程驻留内存。

| 工具 | 计量范围 | 已测阶段总耗时（秒） | 峰值进程内存（MiB） | 总 token |
|---|---|---:|---:|---:|
| CN | 主程序验证一次 | 0.0787 | 43.0273 | 0 |
| QCP | 主程序完整验证一次 | 177.7868 | 1996.0273 | 126,128 |
| Fulminate | 61 对变体与输入 | 7.2791 | 43.2422 | 0 |
| teSpec（包含 ITP） | 61 对变体与输入＋12 次独立 ITP | 2424.8860 | 2035.5195 | 1,534,552 |

- CN、Fulminate 本批未调用模型，因此 token 为实际的 0；不是漏采集。
- QCP 原生阶段的 1 个自动 VC、0 个 manual 不能替代完整证明产物。本批补齐了 gpt-6.1-sol 调用和 Coq 检查，模型 token 按实际回执计入。若其他实例已有完整可检查的自动证明，则可以复用；只有实际未调用模型时才能将相应 token 记为 0。
- Fulminate 表中耗时包含插桩／编译／首次执行 7.0446 秒，以及单独运行 0.2346 秒。仅运行测试时的峰值为 1.3672 MiB；完整已测阶段峰值来自插桩流水线。
- teSpec 完整流程总计用于四工具审计；ITP 最终展示仅采用下方逐次实测的平均值，原始用量回执保留。

原始统计入口：[CN](../benchmark/results/read/cn/statistics.json)、[QCP](../benchmark/results/read/qcp/statistics.json)、[Fulminate](../benchmark/results/read/fulminate/statistics.json)、[teSpec](../benchmark/results/read/tespec/statistics.json)。

QCP 完整验证的阶段耗时为：复用的原生自动阶段 0.006401 秒、模型证明生成 49.3910 秒、Coq 编译／假设审计 1.6964 秒、独立内核检查 126.6930 秒。模型 input 125,511（其中 cached input 118,656），output 617，共 126,128 token。原始未绑定输入的全称 VC、VC_Correct 证明模块及内核检查回执见 [完整 QCP 验证回执](../benchmark/results/read/20261015-qcp-verify-complete/receipt.json)。

### 分阶段原始测量与 ITP 展示

生成／执行与 agent 填写证明、Coq 编译审计、独立内核检查分别计量，各自保存时间、峰值内存和 token。原始阶段总量保存在 statistics.json、[stages.csv](../benchmark/results/read/stages.csv) 和 [stages.json](../benchmark/results/read/stages.json) 中供审计；最终 ITP 展示使用下面的每次执行平均值。

后续 ITP 以一次测试执行为单位：该次执行的所有待处理 VC、所需证明修复与检查合计计量一次。不同测试执行分别测量，不能把一个 VC 或一项定理计作一次 ITP。read 已按 12 次需要 ITP 的测试执行分别独立运行，再计算算术平均值；原先共享批次和均摊估算仅保留在 Git 历史及原始批次回执中。每阶段峰值内存保留原值，不按执行次数相除。

### teSpec ITP 平均开销（展示口径）

12 次需 ITP 的测试执行分别计量，同次执行的全部待处理 VC 合计一次，包含修复尝试。时间、token 和各次进程峰值内存分别取算术平均；不是将一次批次峰值除以 12。

| 阶段 | 平均耗时（秒） | 平均单次进程峰值（MiB） | 平均 token |
|---|---:|---:|---:|
| agent 填写证明 | 69.9816 | 189.0798 | 127879.33 |
| Coq 编译与审计 | 4.1723 | 569.1663 | 0 |
| 独立内核检查 | 127.0494 | 1935.2458 | 0 |
| ITP 合计 | 201.2033 | 1935.2458 | 127879.33 |

平均输入 token 126648.00，平均输出 token 1231.33。模型 gpt-6.1-sol。

Coq 阶段为 GNU time 的单进程峰值 RSS；Windows agent 客户端为 PeakWorkingSet，不含远端模型／GPU。合计内存先取每次执行各阶段的最大值，再对 12 次执行取平均。原始逐次峰值与最大峰值保留在 JSON 供审计。旧共享批次仅作为历史。

CN/QCP 的主程序验证与 Fulminate/teSpec 的变体测试采用不同评测对象和分母，不能据此直接推导相同工作量下的速度或正确率优势。

## 9. 复用与生成入口

从仓库根目录执行以下审计／发布命令，读取已有记录即可，不会重新调用模型或重跑全称验证：

```sh
python3 tools/benchmark/build_program_groups.py --check
python3 tools/benchmark/validate_read_results.py
python3 tools/benchmark/validate_metered_read_itp.py
python3 tools/benchmark/complete_read_pipeline.py
```

最后一个命令会核对已有证据并重建完整结果、四工具入口和统计视图。数据源及证据保持原样。

确需新跑时，相关驱动如下：

| 驱动 | 作用 |
|---|---|
| `test_read_variants.py` | 实际运行变体的 Fulminate／teSpec 测试；拒绝覆盖已有测量 |
| `prepare_read_itp_model.py` | 在新的 task 目录准备不可变目标、复用辅助库及候选模板 |
| `meter_itp_model_windows.py` | 实际模型调用，采集 token、生成时间及客户端内存 |
| `meter_read_itp_coq.py` | 对该轮候选编译、审计并独立内核检查，采集时间与 RSS |
| `summarize_metered_read_itp.py` | 历史共享批次的计量汇总 |
| `read_itp_per_execution.py` | 为每次执行准备独立证明任务，编译／内核复查、汇总与审计 |
| `run_read_itp_per_execution_windows.py` | 顺序运行各执行的 agent 证明与 Coq 检查，失败修复成本全部保留 |
| `prepare_qcp_primary_model.py` | 准备主程序原始全称 VC 及其 VC_Correct 证明模板，不绑定具体测试输入 |
| `measure_qcp_primary_complete.py` | 复用 QCP 原生阶段，对模型证明编译、审计并独立内核检查，计入完整验证成本 |
| `validate_qcp_primary_complete.py` | 核对全称目标、模型用量、完整证明及资源回执 |
| `publish_read_tool_results.py` | 发布 CN、QCP、Fulminate、teSpec 的独立入口 |

这些驱动位于 `tools/benchmark/`；当前实现绑定 read 的目标、配置和运行目录。扩展到其他组时需替换对应映射与输入策略，不能原样调用后声称覆盖了新程序。重测必须使用新的 run／attempt 位置，不覆盖已发布测量。执行器、编译器和 SMT 实现仍在 teSpec 仓库之外，仅通过二进制接口调用。

## 10. 新程序组交付清单

- 程序组清单明确指定主程序，绑定可复用的 CN/QCP 验证证据及作用范围。
- 多个已有或新构造变体按实现与 spec 身份组织；数量可变，不强制“三正三负”或固定七槽位。
- 每个变体有多个适用输入；CN/QCP 的配对范围、输入差异、重复状态及缺口明确记录。
- 预期结果逐用例确定；特殊 ERROR 的批准类别与诊断匹配条件明确。
- 两种测试工具均有真实执行记录；残留 UNKNOWN 有已检查的 ITP 结论，或者明确标记未完成。
- ITP 目标与实际执行 VC 哈希一致，证明／反证、假设审计及独立内核回执齐全。
- 四工具均有独立结果与统计入口；正式 teSpec 统计包含测试和必要的 ITP。
- 时间、峰值内存、模型、token、重试、共享工作和复用范围可追溯，无估填或重复计数。
- 原始结果不可改写；最终结论单独汇总。源文件、日志、证明与指标的引用和哈希审计通过。
- 声明完成范围：程序组、变体配置、语言版本记录、测试对数、测试执行次数分别计数，不把有限覆盖写成穷尽验证。

## 11. 每组必备的结果与成本表

每个程序组必须提供 `benchmark/results/<group>/result-cost.md`、`result-cost.json` 和 `result-cost.csv`。Markdown 展示四工具结果及成本，JSON 保存完整字段、计量单位、缺项和证据引用，CSV 供汇总分析。统一入口为 `benchmark/results/group-result-cost-index.md` 及对应 JSON。

结果表包含：主程序身份、语言版本记录数量、CN/QCP 主程序验证结论、Fulminate/teSpec 测试对数及预期匹配数。成本表包含：CN 验证；Fulminate 插桩／编译／首次执行及单独测试；QCP/teSpec 的生成或测试执行、agent 填写证明、Coq 编译审计、独立内核检查及 ITP 平均小计。各项报告时间、峰值进程内存、token 和统计单位。

ITP 按一次执行的全部待处理 VC 合计，展示平均成本；read 已对 12 次需要 ITP 的执行分别调用 agent、编译和独立内核复查，展示实测算术平均值，不再使用共享批次均摊。内存峰值不除以次数。ITP 小计与分项不可重复相加，缺测字段记 null／待补齐，不能补 0。完整状态要求四工具结论及必要资源字段均已发布；历史证据存在但尚未绑定时仍标待补齐，后续核对后复用。

运行 `python3 tools/benchmark/build_group_cost_tables.py` 可从各工具已发布回执重建所有组的表；read 发布器自动调用它，无需重跑模型或证明。当前 45 组均有表格入口，已完成的组和剩余缺项以 `benchmark/results/group-result-cost-index.json` 为准；文件存在不等于评测完成。

read 的最终 ITP 平均表必须同时展示平均耗时、平均 token 和平均单次进程峰值内存。内存均值来自各次独立测量的峰值，不是把总峰值除以次数；原始各次峰值及最大峰值均保留供审计。

## 12. 可选 spatial SMT 模式评测

工具提供 `--spatial-smt` 后，每组须保留显式关闭／开启模式的独立对照，使用同一实现、spec 和输入，记录各模式实际命令、模块哈希、依赖版本、查询预算、逐例分类、时间、RSS 与 token。结果不能覆盖旧的默认模式记录。SMT 无法决定的测试结论继续使用每次执行独立 ITP；若自动获得决定性结果，则不虚构 ITP 成本。

read 已完成 61 对相同用例的两模式对照，共 122 次新执行。关闭复现 22 PASS、20 FAIL、12 UNKNOWN、7 ERROR；开启为 22 PASS、32 FAIL、0 UNKNOWN、7 ERROR，61/61 符合逐例预期，其余 49 条分类不变。12 条查询已重放 SAT，非空四字节反例堆、原始 VC 哈希及历史 Coq 反证逐条一致。开启模式执行阶段平均 0.170630 秒、平均单次峰值 RSS 26.5344 MiB，新增 token 0，本批没有需要 ITP 才能决定的测试结论。

SMT 的 certificate 保持 NOT_CHECKED，不能标为新 Coq 内核证书。20 条本来已 FAIL 的数值错误用例保留 residual 清单，已有决定性 INVALID 足以判 FAIL；清单条数不能当作 UNKNOWN 测试数。关闭模式完整成本仍须包含复用的 12 次 ITP，而不是把本次新调用模型次数为 0 写成没有历史证明成本。

产物为 `benchmark/results/<group>/<run>-spatial-smt/{results.json,statistics.json,cases.csv,comparison.md}`；组结果与成本表链接两模式数据。read 测试时功能实现尚未提交，结果保存精确工作区模块哈希并明确这个限制。组件实现的已有未提交工作不混入 benchmark 产物提交。


## 13. 逐组执行入口与成本审计

新组可用 `benchmark/programs/<group>/evaluation-plan.json` 明确 CN/QCP 配对、主程序身份、目标函数、逐输入期望、合法前条件与排除的输入。不能由工具实际输出反推预期。`test_group_variants.py --group <group>` 按计划保留 Fulminate 插桩编译／首次执行、单独运行，以及 teSpec 显式 OFF／ON 的独立计量；单次执行不得被跨用例共享 ITP 所替代。

`prepare_group_primary.py --group <group> --task-dir <隔离目录>` 只用于缺少可复用完整计量的主程序阶段。已有匹配来源、计量和证明应继续复用。原始通用 VC 字节冻结，agent 只修改 Candidate.v，必须实现原始 VC_Correct 模块接口。`measure_group_qcp_complete.py` 计量证明编译、假设审计和独立内核检查；`--attempt N` 继续计入之前所有模型尝试及失败编译。模型调用通过 Windows 计量器实际请求 gpt-6.1-sol，保存 CLI usage 事件和本地进程峰值。

`publish_group_evaluation.py --group <group>` 发布四工具入口，`build_group_cost_tables.py` 重建分组结果成本表，`validate_group_evaluation.py --group <group>` 检查全部语言版本覆盖、输入／源码／日志／VC／证明哈希、预期匹配及阶段加总，不重跑实验。未解决的 UNKNOWN、非预期 ERROR 或缺测不能被发布成完整。无需 ITP 时总成本为 0，但条件均值和内存峰值不适用，不填虚假实测 0。

有标准库同名函数时，使用 `tools/benchmark/gcc-no-builtins.sh` 的 `-fno-builtin`，防止编译器消除被测调用。保存插桩 C 和二进制哈希，工具无误报告不等于目标函数实际执行。`abs` 的错误优化诊断批次明确排除，正式重新计量。

必须逐条记录 Print Assumptions 的真实输出。原始 VC 的类型本身若含运行时参数，例如 `eval_addr_expr : rvalue_expr -> addr`，独立内核可检查相对于该参数的证明，但这不等于 Closed under the global context；保留原始 VC 和参数定义位置，禁止改写目标来隐藏该依赖。

## 14. 运行时库假设与配置重试

Coq 内核通过表示相对于实际审计出的环境假设检查通过，不自动等于 Closed under the global context。若原始 VC 类型依赖抽象 C 类型参数，须保留原始参数和类型审计。若空间库已有引理依赖 Coq 标准函数外延性，只能在组计划明确列出该标准库依赖、独立编译原始 VC 与运行时引理的 Print Assumptions、证明新增依赖确来自该引理后，报告 VERIFIED_KERNEL_CHECKED_WITH_RUNTIME_LIBRARY_ASSUMPTIONS。记录所有依赖名称、原始审计文本、来源位置及作用范围；不得新增公理声明或用任意公理消掉失败 VC。普通无此依赖的组继续按原先更严格的审计处理，不能把这类证书写成无全局假设。

测试配置修正要保留原始 ERROR 和重测记录。只有同一程序/spec/binds 哈希的重测才可关联为已修复配置问题；原始分类不改，最终结果另列。重试时间全部计入，逻辑测试输入数与实际尝试数分开；每个逻辑测试的峰值取其实际各尝试峰值最大值，再对测试取算术平均。匹配的 Fulminate 测量可复用一次，不能重复计费。每轮必须保存实际执行的 evaluation-plan.executed.json；后续成本／假设元数据补注可追加，但不能改变已执行函数、输入配对或逐例预期。


### 同组不同入口与配置修正的证据约束

组内来源可含不同函数名；每个配对可在 evaluation-plan.json 的 function 字段显式覆盖全组默认函数，测试命令必须使用该入口。含 main 或 verify_main 的客户端不得因仅测试 read 帮助函数就算覆盖。无参数入口不把相同执行复制成不同输入。

每次模型调用应在启动时冻结实际 prompt，并按 receipt 的 prompt_sha256 审计；不得用调用结束后被编辑的 prompt 取代。空 ghost 绑定也必须写 values:{}。若首次配置漏写空对象，保留原 ERROR 和成本，只可在两个绑定 JSON 除缺失/显式空 values 外完全相同的条件下关联重跑；不允许忽略参数或实际 ghost 值变化。


### 不完整组和失败的主程序验证

来源或依赖被 CN 拒绝时，失败尝试的时间、RSS、原命令、原日志及关键依赖哈希仍放在组下；未跑工具和证明阶段保留 PENDING，不用 0 代替。coverage-gap.json 单独描述原因和剩余工作；这类未执行的 teSpec 测试不算零异常，也不进入已扫描分母。结果成本表只有在 CN 主程序 VERIFIED 且 QCP 主程序 VERIFIED_KERNEL_CHECKED（含明确披露库依赖的限定结论）、其余阶段齐备时才能计为完整；单纯测量齐全的失败验证不能算完整组。

测试驱动在任何计量前检查显式 values 对象和 (CN variant, case id) 唯一性，避免不同入口覆盖同一个缓存路径。原始测量和生成文件字节不为排版而改写。
