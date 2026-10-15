# CN/QCP 程序、实现和规约变体基准

当前采用**已有数据优先、变体数量可变**的组织方式：程序组 → 多个实现 → 多种规约 → 输入与结果。CN 原有变体、已有 QCP 翻译、构造变体、测试和证明记录全部保留；不再要求每个程序固定几个正例、负例或实现。

## 入口

- [程序与原始变体分组](grouping/README.md)：76 个 CN 来源归入 45 个程序组，保留 61 个原始实现轮廓。
- [已有变体、输入和结果索引](grouping/existing-variants-and-results.json)：具体版本及对应测试/验证记录。
- [可读 CSV 总表](grouping/existing-variant-results.csv)：每个版本的来源、输入集合数及记录数。
- [逐程序目录](grouping/subjects/)：实现、规约以及证据索引的关联 ID。
- [性能数据](performance/20261015-positive18/README.md)：18 条来源记录、11 个不同正确配置、8 个程序组；保留原测量数值，另提供去重视图。
- [当前策略](grouping/policy.json)：无固定数量或正负比例，来源和结果范围必须明确。

## 结果使用规则

已有结果属于实际运行的源码、规约、输入、工具版本和检查范围。源码相同的记录可按来源哈希关联；仅凭同名程序、同实现或同一程序组，不能把 PASS、反例或资源数字挪到另一规约。报告保留精确匹配、清单/用例关联和仅历史记录三类依据，索引不产生新的验证判定。

输入分为实际执行的冻结输入、已有 C 反例/对照驱动、准备但未执行的输入，以及原文件中未确认执行的 main。UNKNOWN、工具错误、残留 manual VC、预期拒绝和正式反证分别保留。未测的时间、内存和 token 不填 0。

## 重建与审计

```sh
python3 benchmark/selection/paired-mutations/grouping/build.py
python3 benchmark/selection/paired-mutations/grouping/reuse.py
python3 benchmark/selection/paired-mutations/grouping/validate.py
python3 benchmark/selection/paired-mutations/grouping/validate-reuse.py
```

`generate.py`、`manifest.json`、`cases/` 和原重放脚本保留历史构造批次的可复现性。旧七槽位/PENDING 字段不是当前接纳或缺项判据，也不代表对应程序没有原始变体或旧结果。[旧七槽位设计](legacy-seven-slot-design.md) 仅作历史记录，不要求继续按 76×7 补文件。

## 程序、变体、测试用例与验证单位

层级为：程序组 → 变体（固定的一对实现与规约）→ 多个测试用例。实现或规约都可以改变，两者同时改变也可以；改变后作为新的变体。CN 与 QCP 是相应变体的语言版本，对应范围单独记录。

每个程序组只指定一个主程序（确定的实现与规约），CN、QCP 形式验证各完成一次，优先复用匹配的历史验证与证明；仅补缺失部分。其余变体只要求测试，已有形式验证保留为可选历史证据。主程序验证覆盖满足前条件的输入，不随有限测试用例数重复。QCP 一次验证产生的全部 VC 都须完成，manual 证明和所需内核检查也必须完成，才算通过。Fulminate 和 teSpec 则分别按变体及测试用例运行；越过该变体前条件的输入另行标记。每个变体应有多个适用用例，缺失用例明确记为覆盖缺口，已有的输入集合不自动等于完成覆盖。

主程序验证的时间、峰值内存、实际 token 按程序组的主程序及工具记录一次；测试指标按变体、用例及工具记录，再注明用例数汇总。不把验证开销乘以用例数。源码、规约、依赖、工具版本、配置和证明上下文匹配时可复用旧验证结果；复用测试结果还须输入匹配。历史重复实验保留，不作为新的重复运行要求。
