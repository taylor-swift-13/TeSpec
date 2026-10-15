# 按程序组织 CN 原始变体和多个实现

当前实验单位改为程序组，不再把每个 CN 来源文件当作独立程序。全部 76 个来源保留，按明确的变体对应关系归入 45 个程序组，识别出 61 个原始 C 实现轮廓。该实现计数基于去除注解/空白、统一本地函数名后的 C token 指纹，不是语义等价判定；局部变量重命名、预处理和不同 ABI 的等价性不自动推断。

## 数据层级

```text
程序组
  多个实现（含不同整数类型、别名模式或接口，分别记录签名）
    原始 CN 规约变体 / 新构造的规约变体
      CN 文件 / 已核对的 QCP 文件 / 验证与测试记录
```

`subjects/<程序组>/manifest.json` 是逐组入口；`families.json` 是完整索引。文件继续保存在原位置，通过路径和 SHA-256 关联，不复制覆盖原始文件。原 main 和调用断言仍在原文件中；函数模块的 main 指纹单独保留，runtime-extras 和 runway 的 main 直接计入实现范围。

同一实现的不同规约归到同一个 implementation_id；真正改变代码的变体有不同 implementation_id。每个原始变体都有 independent specification_id、上游静态/运行时测试预期、trusted 函数列表及来源。上游 broken 标签不直接解释为错误实现，弱而有效的规约也不强行归入错误规约。

## 具体例子

| 程序组 | CN 原始来源变体 | 原始实现数 | 处理 |
|---|---|---:|---|
| read | read.broken、read、read2 | 1 | 分别保留缺少出口所有权、仅保证所有权、完整值与所有权的规约 |
| add | add_0、add_1、add_2 | 1 | 保留弱后置条件与完整后置条件的差异；原 main 分别保留 |
| init_array | init_array、init_array2、init_array_rev | 2 | 两个正向版本归同一实现；反向遍历是另一实现 |
| transpose | transpose.broken、transpose、transpose2 | 2 | 前两个同实现不同历史规约；经 swap 的 unsigned 版本保留独立类型/实现 |
| incr | unsigned/signed 及 broken 变体 | 3 | 保留代码和类型差异；不同接口或算术模型不能混用规格 |

原始 read 的三种规约已逐一关联对应 QCP 目标，范围仅为 read 函数，不声称验证了原 trusted main。其余原始 CN 规格的 QCP 对齐状态单独标记；已有的修正规格 QCP 版本只列为候选，不冒充原始错误/弱规格的等价翻译。新构造的 77 个不同 CN/QCP 配对保留原有验证状态。

## 现有变体、输入和结果沿用

不设每组变体下限、上限或正负比例。优先沿用已有 CN/QCP 版本、不同实现、有效弱规格、错误规格、错误实现和历史工具失败例；它们保持原有分类与证据。已经构造的负例保留 baseline_case 约束，但不要求每个程序再制造三个同类变体。

完整入口是 existing-variants-and-results.json 和 existing-variant-results.csv。当前包含 76 个原始 CN 版本、77 个不同的构造配对和 103 个已有 QCP 源码版本，共 256 条版本记录；跨类别可引用同一源码，不将其相加为独立程序数。45 个程序组都有相关历史验证/运行记录，这不表示 45 组或全部变体都验证通过。

378 条输入集合记录包括重复实验、原 main 驱动及仅准备未执行的绑定，不是 378 个独立测试。1386 条结果观测包括重复轮次、阶段结果和证明回执，不是 1386 个独立测试。42 个组有可追溯输入记录，其余三个双链表组有验证记录但此索引未找到显式有限输入。现有 192 条初始 teSpec 实例结果及 UNKNOWN 原样保留，并关联回输入 ID。

源码哈希匹配的结果、由锁定清单关联的结果、C 对照/反例记录和仅历史记录分别标注。36 条旧报告的来源哈希不匹配当前可用源码，保留在 historical_unmatched_result_ids，不挪给新版本。旧证明另链接其实际证明文件哈希；缺失/改变的支持文件明确标记。原报告中的二进制、ABI、运行模式和证明范围继续有效，归索引不等于新环境中的重跑或新判定。

read.broken 的原始错误规约不会被完整 read2 规约替代。新的修正规约、原始负例、弱而有效的规约可以同时作为变体使用。旧 76×7 来源槽位只作历史账本，不再按其缺项状态补齐数量。

## 性能数据

18 条原始来源性能记录不删除、不修改，也不重复作为独立样本求平均。`performance-all-source-aliases.csv` 为每行添加程序组、实现、配对配置和代表标记；`performance-distinct-positive-cases.csv` 选出 11 个不同正确配置的原始实测记录，覆盖 8 个程序组。每个配置优先选择完整/正常来源（如 read2、add_1、zero），选择顺序写在 build.py 中，不按快慢挑选。一个程序组的不同实现/类型仍可各自报告性能。

原始 CN 变体没有因归组重新验证；上游 expected 与实际执行结果分开。归组不改变任何原始 C 文件、规约、已有证明或性能数值。所有同组变体及来源别名必须放在同一训练/测试划分中。

## 重建与审计

```sh
python3 benchmark/selection/paired-mutations/grouping/build.py
python3 benchmark/selection/paired-mutations/grouping/reuse.py
python3 benchmark/selection/paired-mutations/grouping/validate.py
python3 benchmark/selection/paired-mutations/grouping/validate-reuse.py
```
