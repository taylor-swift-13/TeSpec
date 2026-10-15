# 历史空间 VC 离线回放报告

已实现独立 Python/Z3 编码模块，位置：`tools/finite_spatial_smt`。
没有接入执行器，没有运行 C 程序、teSpec 端到端测试或 ITP，也没有覆盖历史测试分类。

## 历史 UNKNOWN 收集与离线回放

| 指标 | 数量 |
|---|---:|
| 历史 UNKNOWN 观察记录（含报告、执行器和 stdout 副本） | 48,556 |
| 按原始 VC 文本及布局去重 | 25,598 |
| 当前支持片段内的原始 VC | 1,007 |
| 规范化去重后实际求解的 VC | 969 |
| VALID | 108 |
| INVALID | 861 |
| UNKNOWN（已纳入支持片段） | 0 |
| 因前提不可满足而空真成立 | 0 |

全部 969 个结果与不依赖 Z3 的具体堆解释器一致。涉及的源函数为：`array_fill_value`、`array_increment`、`array_negate`、`chars_initialize`、`read`、`set_zero`、`string_to_upper_ascii`。
这是有限空间 VC 集，不是 969 个独立程序；也不能把该片段的 100% 求解率推广到整个 UNKNOWN 池。
未纳入支持片段的 24,591 个原始 VC 保留原文、来源哈希和排除原因，包括递归谓词、自定义函数、无法明确展开的量词，以及本次不处理的纯逻辑或其他检查模式。

read 的 12 条原始 executor UNKNOWN 记录对应 6 个不同 VC，离线编码均为 INVALID；旧报告仍保持 UNKNOWN。

## 离线回放开销

- 总耗时：26.782 秒。
- 每 VC 中位耗时：16.079 毫秒；最大：150.947 毫秒。
- 整个 Python 离线回放进程峰值 RSS：67.44 MiB，非逐 VC 峰值。
- Z3：4.13.3；每个 SMT 查询预算：2000 毫秒。
- 模型调用、token、执行器调用和 ITP 调用均为 0。

## 可审查产物

- `cases.json`：规范化 VC。
- `inventory.jsonl.gz`：所有原始 VC、观察记录、来源哈希与筛选结果。
- `replay/queries/`：每项 SMT-LIB 查询。
- `replay/results.jsonl`：求解结果、反例堆、独立解释器交叉检查及耗时。
- `implementation.json`：回放所用编码器与语义定义的哈希，以及来源/查询完整性审计。

编码模块和组件测试独立存放在本仓库 `tools/finite_spatial_smt/`；组件测试结果位于该目录的 `results/`，不计入 benchmark。

## 可信范围

结果是 VC 层面的 VALID/INVALID，不是整程序 PASS/FAIL，也不单独建立执行路径可达性。
本模块已通过测试与独立解释器交叉检查，但尚未完成编码器对 QCP 语义的 Coq 正确性证明，SMT 结果亦未由 Coq 内核检查：`certificate = NOT_CHECKED`。
本轮不修改论文，不将尚未证明的性质写为已完成贡献。
