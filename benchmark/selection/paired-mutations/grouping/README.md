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

## 新构造变体和计数

每个程序组至少准备一个正确配置、三个错误规约配置、三个错误实现配置。CN 原有的其他正确实现、错误实现、弱规格和历史变体额外保留，不强行塞进七个槽位。每个构造的负例显式关联 baseline_case：错误规约必须保持该基线实现，错误实现必须保持该基线规约，因此不同类型/接口不能靠互相错配制造负例。

旧 manifest.json 的 76 个来源槽位和 532 项计划作为历史来源账本保留，不再作为独立程序数。当前 126 个已生成来源配置去重为 77 个不同配对，其中 11 个正确配置，来自 8 个程序组。8 个组具备至少七个构造配对，其余 37 个组尚未完成，不能把 45 组都标为已验证。

## 性能数据

18 条原始来源性能记录不删除、不修改，也不重复作为独立样本求平均。`performance-all-source-aliases.csv` 为每行添加程序组、实现、配对配置和代表标记；`performance-distinct-positive-cases.csv` 选出 11 个不同正确配置的原始实测记录，覆盖 8 个程序组。每个配置优先选择完整/正常来源（如 read2、add_1、zero），选择顺序写在 build.py 中，不按快慢挑选。一个程序组的不同实现/类型仍可各自报告性能。

原始 CN 变体没有因归组重新验证；上游 expected 与实际执行结果分开。归组不改变任何原始 C 文件、规约、已有证明或性能数值。所有同组变体及来源别名必须放在同一训练/测试划分中。

## 重建与审计

```sh
python3 benchmark/selection/paired-mutations/grouping/build.py
python3 benchmark/selection/paired-mutations/grouping/validate.py
```
