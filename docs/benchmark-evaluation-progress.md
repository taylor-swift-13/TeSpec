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

三组新增测试的空间 SMT 开／关模式均有真实执行，但没有产生需要空间 SMT 求解的 VC（查询数均为 0）；SMT 实际消解能力仍由 read 的 12 条查询证明。新增记录只证明这三组在两种开关下的结果与成本，不据此声称 SMT 求解性能提升。32 个评测／SMT Python 模块的审计快照逐文件匹配会话起始 commit，完整快照和依赖版本保存在各组统计中。

## 夜间续跑：add 已完成

用户要求今晚继续争取 45 组，并专项记录 teSpec 不符合预期。已启用本线程夜间续跑，进度和执行约束见 docs/benchmark-nightly-20261016.md，状态见 benchmark/results/nightly-20261016/status.json。

add 已覆盖 10 个 CN/QCP 配置、12 条语言记录、122 对输入。Fulminate 120/122 预期匹配，遗漏两个 spec_3 的有符号加法溢出；teSpec OFF/ON 均为 76 PASS、46 FAIL，122/122 匹配。原生 CN/QCP 主程序生成沿用哈希匹配的 add_0 历史测量，两个原始通用 VC 的实际 gpt-6.1-sol 证明、Coq 编译审计及独立内核检查完成，总 token 54537。

目前 5/45 组完整，40 组待补齐。teSpec 专项台账位于 benchmark/results/tespec-unexpected/，原始状态和最终 ITP 状态分列，不能将 UNKNOWN 或非预期 ERROR 算成成功。下一组 add_read 的有限测试已完成 8 对（含无符号回绕边界），两种模式和 Fulminate 均匹配，正补齐主程序证明。

add_read 现已完整：8 对有限输入（含 2^32 回绕边界）在 Fulminate、teSpec OFF/ON 均匹配；原始完整堆见证的单个全称 VC 经模型修复、Coq 编译审计与独立内核检查通过，假设审计 Closed under the global context。共两次模型调用 149618 token，首次编译失败与修复成本均计入。错误原因是 Coq 运行时 `%` 定义为 Z.rem，而 unsigned_last_nbits 使用 Z.modulo；证明借助非负条件建立二者等价，没有更改程序或规约。当前 **6/45 组完整，39 组待补齐**；下一组 add_two_array，以 nightly 状态文件为准。

## 夜间续跑：add_two_array 已完成

完整进度 **7/45 组，38 组待补齐**。add_two_array 覆盖 1 个 CN/QCP 配对配置、2 条语言记录、8 对合法数组输入，包含交换读取下标和无符号回绕边界。Fulminate 8/8；teSpec OFF/ON 最终均为 8/8，均无需 ITP。初次驱动漏传策略目录导致 16 条 ERROR，修正后同源码/spec/binds 全部通过。原始 ERROR、复现条件、修复证据和原因分类留在专项台账，分类为驱动配置错误，不作为已证实的执行器缺陷；所有失败尝试成本计入，Fulminate 只复用计量一次。

主程序 3 条原始通用 VC 已完成模型填写、Coq 编译审计及独立内核检查，总模型调用 2 次、168378 token，首轮未填写候选也计费。QCP 原生生成含最初策略解析失败的实际成本，Coq 审计也包含控制器命名空间导入修复的成本。此组的原始 VC 类型带 sizeof_* 解释参数，两条数组拆分证明引用 UIntArray.full_split_to_missing_i，额外依赖 Coq 标准 FunctionalExtensionality.functional_extensionality_dep。已独立编译原始目标类型及该运行时引理的假设审计，确认来源后明确标为 VERIFIED_KERNEL_CHECKED_WITH_RUNTIME_LIBRARY_ASSUMPTIONS；不是 Closed under the global context，也没有新增公理声明。

目前已扫描 7 组共 270 对输入，teSpec 最终未解决不匹配为 0；另有 12 条历史自动缺口经 ITP 解决，16 条初次配置错误经输入/源码不变的重测解决。下一组 array_load。


## 2026-10-16 夜间：const_example

当前完整 8/45；const_example 7 个输入三种测试均符合预期，CN 原始主函数 foo 验证通过；QCP 原始 2 VC 全称证明、假设审计和独立内核检查完成。原配置失败及修正成本保留，不作为 teSpec 工具缺陷。array_load 客户端覆盖与 const_example_lessgood trusted-only 主函数范围缺口单独登记，均未算完整。


## example_let 完整（2026-10-16 02:06）

当前完整 9/45；累计 413 对变体/合法输入。example_let 的 16 个配对、18 个变体记录（32 个 CN/QCP 文件）、136 对输入，预期 46 PASS、90 FAIL，Fulminate、teSpec OFF/ON 均逐例 136/136。主程序 CN 验证通过；QCP 3 个原始全称 VC 全部编译并独立内核检查成功，1 个全局封闭、2 个仅原运行时地址参数 eval_addr_expr，无新公理。实际 gpt-6.1-sol 4 次调用、264,704 token，包含控制器诊断注入失败造成的重复模型尝试；全部失败编译及诊断成本已计入。QCP 总时间 308.840423 秒、最大单进程 RSS 1767.289063 MiB；四阶段分别保存。当前 teSpec 最终未解决偏差 0，read 自动阶段 12 条经 ITP 解决，另有 30 条配置错误保留并正确关联重跑（16+14）。下一组 Dbl_Linked_List__singleton；array_load 和 const_example_lessgood 的覆盖/可信入口范围缺口不算完成。
