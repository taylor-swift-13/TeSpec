# Benchmark 逐组评测进度

在唯一 `/home/yangfp/teSpec` 工作树的 `main` 上依次完成各组。只有主程序做 CN/QCP 全称验证；其他变体逐输入测试。复用输入哈希匹配的既有证据，补测缺少的成本阶段。正式状态以 `benchmark/results/group-result-cost-index.json` 为准。

| 组 | 配置／语言记录 | 测试对 | Fulminate 预期匹配 | teSpec OFF／ON 预期匹配 | 完整成本 |
|---|---:|---:|---:|---:|---|
| read | 10／13 | 61 | 60/61 | 61/61、61/61 | 已有完整模板 |
| abs | 8／9 | 57 | 56/57 | 57/57、57/57 | 已齐全 |
| abs_mem | 1／2 | 7 | 7/7 | 7/7、7/7 | 已齐全 |
| abs_mem_struct | 1／2 | 7 | 7/7 | 7/7、7/7 | 已齐全 |

`abs` 逐输入预期为 38 PASS、19 FAIL；缺少最小整数排除前条件的变体在 INT_MIN 处应因有符号取负溢出失败。Fulminate 对这个输入返回 PASS，计为漏检，不调整预期迎合工具结果。teSpec 两种模式均自动判定，无需 ITP，相关模型和证明成本为 0，ITP 均值与峰值不适用。

`abs` 首轮 GCC 默认内建优化把返回值未使用的 abs 调用消除，导致检查被绕过。该轮明确保留为排除的诊断数据，正式轮通过 `tools/benchmark/gcc-no-builtins.sh` 加 `-fno-builtin` 重跑，保存插桩 C 源码及二进制哈希。后续有标准库同名函数的组沿用此规则，确保实际调用被插桩函数。

`abs` 主程序 CN 和 QCP 原始 VC 生成复用已匹配的历史测量；gpt-6.1-sol 填写 4 个原始全称 VC，实际 token 由 CLI 事件计量，Coq 编译、假设审计和独立 coqchk 均完成。两个返回 VC 无全局假设；两个安全 VC 原始语句含运行时抽象地址解释参数 `eval_addr_expr : rvalue_expr -> addr`，它声明于 `runtime/qcip/SeparationLogic/SeparationLogic/CNotation.v:46`。未增加证明公理，也不把这两个证书描述为 Closed under the global context。首次编译的假设审计期望过严，后续确认编译与首次编译成本均计入，原始 GNU wall 精度为 0.01 秒。

所有结果、日志、证明、时间、RSS、token 和阶段成本保存到 `benchmark/results/<group>/`。本轮只对正式缺项补测；不会把历史自动状态误当作完整内核证书，也不会补造缺测的 0。`abs_mem` 已完成 7 个合法输入及主程序 4 个全称 VC 的模型证明、Coq 编译审计和独立内核检查；token 101196。缺少历史计量的原生阶段已补测。初始化时控制器误判目标文件名的预检输出保留为 `20261016-primary-native-diagnostic`，不混入正式单次验证的成本；这次预检没有完整 wall 记录，未补造。`abs_mem_struct` 已补齐，下一组为 `add`。

`abs_mem_struct` 的 8 个原始全称 VC 已编译并通过假设审计。初始堆重排使用的运行时引理依赖函数外延性，最终 Candidate 中以点态状态结合和见证交换构造性证明替换，已去掉该额外公理。所有 7 次模型尝试、失败编译和未通过的假设审计均计入成本，原始提示词、事件日志、每次 Candidate 和控制器回执保留。CN 对原始文件内未标 trusted 的 main 也验证，QCP 文件省略 main、验证 abs_mem 和 abs_y；范围差异明确记录，不能据单次数值推导工具普遍性能结论。

本轮新增 abs、abs_mem、abs_mem_struct 三组，共 71 对变体与输入（teSpec OFF／ON 各 71 次）；Fulminate 合计 70/71 预期匹配，两种 teSpec 模式均 71/71。加上已有 read，完整组为 4/45，其他 41 组仍明确待补齐。三组主程序分别有 4、4、8 个全称 VC 的完整 QCP 证明与独立内核检查。abs_mem_struct 所有 7 次模型尝试合计 668848 token；最终 Coq 假设审计为 2 个无全局假设、6 个仅含原始运行时地址参数，未引入函数外延性。
