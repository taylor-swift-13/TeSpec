# 数据集检查结果

本目录保存输入可用性核对及参考证明重放，不是最终性能实验。
下面的 `summary.json` 和 `automatic.csv` 是首次运行的历史结果；修复后的 QCP
自动阶段结果见 `after-fix-summary.json`、`after-fix-qcp-runs.json` 和
`after-fix-logs/`。两组结果都只覆盖现有 14 个共同集程序，80 个来源候选池不在分母中。

修复后，同一 56 个共同集参考实例为 28 PASS、28 UNKNOWN、0 ERROR；56 个错误
规约实例为 30 FAIL、24 UNKNOWN、2 PASS、0 ERROR。树例的固定策略已通过 Coq
内核重放，消除了非空树字段读取的 ERROR，但该例的入口和返回 VC 仍为 UNKNOWN。
有限数组的错误后条件检测从 UNKNOWN 改为有证据的 FAIL；2 个 PASS 是错误变体
未被该输入触发。证明重放日志见 `after-fix-tree-coqchk.log.gz`。

- 16 个程序、64 组输入在 32 位与 64 位 native 下的 **128 次 oracle 检查全部通过**。
- 共同集 14 个程序：Fulminate 的 56 个参考实例全部 PASS；错误规约的 52 个被触发
  实例全部 FAIL，4 个未触发变异的实例 PASS。
- 同一共同集的 teSpec 自动阶段：参考实例 28 PASS、25 UNKNOWN、3 ERROR；错误
  变体 16 FAIL、35 UNKNOWN、3 ERROR、2 PASS。3 个 ERROR 来自非空树的原始
  store_tree 展开／读内存问题，保留在分母中。这不是 ITP 完成后的结果。
- 无界平方根 contract：Fulminate 的原始 CN 版本明确报告无法推断量词上界；
  teSpec 4 个参考实例从自动 UNKNOWN 经完整 VC 证明和独立内核重放变为 PASS。
  4 个错误后条件实例在自动阶段 FAIL。
- CAV 无界存在量词例：QCP 保留原关系；4 个参考实例经完整 ITP 后 PASS。错误变体
  当前自动 UNKNOWN。CN 直接等价 contract 未提供，因此不并入共同集的检测率。

`automatic.csv` 是按输入的结果；`automatic-runs.json` 保存命令、资源记录与日志索引；
`summary.json` 汇总版本、哈希和计数；`itp-*.json` 是完整结果合并报告；`logs/` 保存
压缩的原始诊断。报告里的 `/tmp/...` 是采集时位置，重放应使用根目录的 run.py 和
replay-study.py，不依赖这些历史临时路径。数据集内保留可重新生成的源、绑定和证明。

CN abs 用例在检查过程中改名为 bench_abs，以消除 GCC 内建 abs 替换导致的插桩绕过；
此处采用修正后重跑的记录。其他早期草稿运行不纳入这些计数。

参考证明由人工提供，不能把本次重放时间记作 Agent 自动构造证明时间。正式测量需要
固定模型、预算、重试策略和隔离资源，并把已有参考证明隐藏。
