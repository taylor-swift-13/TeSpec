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


## incr_first 完整（2026-10-16 02:14）

完整 10/45，累计 429 对变体/合法输入。incr_first 两个 CN/QCP 配对、4 个来源版本、16 对输入，含无符号回绕和被框架保留的第二个单元边界，Fulminate 与 teSpec OFF/ON 均 16/16。CN 指定主程序整文件验证通过；QCP 原始 8 个全称 VC 一次模型填写全部编译、假设审计并独立内核检查成功，3 个全局封闭、5 个仅原运行时地址参数，未引入新公理。gpt-6.1-sol 实际 1 次、84,524 token，QCP 分阶段总时间 196.071603 秒，最大单进程 RSS 1767.371094 MiB。


## quadruple 完整（2026-10-16 02:18）

完整 11/45，累计 549 对变体/合法输入。quadruple 的 16 个配对、18 个变体记录（32 个 CN/QCP 文件）、120 对输入，预期 46 PASS、74 FAIL；Fulminate、teSpec OFF/ON 均 120/120。包含三个非零 unsigned 2^30 倍数，return-zero 变体在这些掩蔽输入正确 PASS，未把全局错误变体的每个输入都机械标 FAIL。CN 原始整文件（含未标 trusted 的 main）验证通过；QCP 原始 1 个全称 VC 一次模型填写、Coq 编译假设审计全局封闭、独立内核检查成功。实际 gpt-6.1-sol 1 次、54,643 token；QCP 总时间 172.423548 秒、最大单进程 RSS 1998.078125 MiB；分阶段保存。下一组 incr。Dbl_Linked_List__singleton 的来源/工具兼容性拒绝已经保存失败成本、日志和关键依赖哈希，不计完整，也不虚构尚未执行的 teSpec 结果。


## incr 进行中（2026-10-16 02:35）

22 个变体记录、18 个 CN/QCP 配对、103 对测试。独立预期为 28 PASS、63 FAIL、12 明确的执行阶段权限/未初始化读取 ERROR；Fulminate 对这 12 个预期拒绝的原生状态应为 FAIL，工具状态映射在执行前计划中已明确。12 个 teSpec ERROR 还必须匹配 qcp_execution_error、SAT 入口和 cannot read memory 诊断，不能把任意解析/配置错误算检出。Fulminate 实际 97/103：6 个原始 Block 未初始化读取返回 PASS，为漏检；原始状态及未初始化 C 局部变量输入保留，不改预期。

teSpec ON 原生 103/103；OFF 原生 90/103，13 个遗漏出口 ownership 的测试 UNKNOWN。首个执行已完成 2 次实际模型调用（含首轮 entry_sat 编译失败），其入口/出口具体堆辅助事实、两个原始残余 VC 反证、入口 SAT 共 5 个定理全局封闭并独立内核通过，OFF 当前最终 91/103，余下 12 个待独立 ITP。不能复用一次模型成本或一个批次峰值给 13 个执行。

CN 主程序原文件已验证；QCP 原始 2 VC 全称证明、假设审计和独立内核通过，实际 gpt-6.1-sol 1 次、75,692 token。证明阶段成本已保存。整组仍未完整，四工具进行中表和不完整 ITP 成本保持 PENDING，完整进度仍 11/45。

当前 Windows 串行 ITP 控制器 PID 20348、会话 95202（v2 已接续旧控制器编码故障）。状态文件 /mnt/c/Users/50635/Documents/Codex/2026-10-14/jin/work/incr-itp-per-execution/controller-status.json；启动后先检查和接续，禁止重复发起。工具 cell_leak_itp.py 每次只编译并核查一个执行的全部残余目标；attach_cell_leak_itp.py --group incr --allow-partial 可只导入已经完成的证书。所有完成后去掉 --allow-partial，运行 publish_group_evaluation.py 与 validate_group_evaluation.py。若有失败任务，保留模型/编译日志和成本，记录缺口后继续其他组。

03:13 检查点：incr 已审计导入 10/13 次独立 ITP，原生 90/103，最终 100/103；仍有 3 个 UNKNOWN 等待本轮控制器处理。完整进度 11/45。


incr 完整收尾：22 个变体记录、36 个语言文件、103 对合法输入。主程序 CN 验证、QCP 原始 2 个全称 VC、Coq 假设审计和独立内核检查完成；13 个 OFF 原生 UNKNOWN 分别独立 ITP 反证并核查全部残余目标，保留所有模型和修复成本。OFF 原生 90/103、含 ITP 最终 103/103；ON 原生 103/103；Fulminate 97/103，6 个 Block 未初始化读取漏检单列保留。四工具分阶段时间、RSS、实际 token 和逐次 ITP 均值已汇总。完整进度 12/45，下一组 transfer。


transfer 完整收尾：16 对输入，Fulminate、teSpec OFF/ON 均逐例匹配独立预期；主程序 CN 与 QCP 2 个原始全称 VC 已编译、假设审计并独立内核检查。gpt-6.1-sol 实际 1 次调用，75,824 token；四工具分阶段时间与 RSS 已保存。完整进度 13/45，下一组 transpose。


transpose 完整收尾：24 对输入，Fulminate、teSpec OFF/ON 均逐例匹配独立预期；主程序 CN 与 QCP 1 个原始全称 VC 已编译、假设审计并独立内核检查。gpt-6.1-sol 实际 1 次调用，54,786 token；四工具分阶段时间与 RSS 已保存。完整进度 14/45，下一组 slf_quadruple_mem。


slf_quadruple_mem 完整收尾：7 对输入，Fulminate、teSpec OFF/ON 均逐例匹配独立预期；主程序 CN 与 QCP 3 个原始全称 VC 已编译、假设审计并独立内核检查。gpt-6.1-sol 实际 1 次调用，55,340 token；四工具分阶段时间与 RSS 已保存。完整进度 15/45，下一组 init_point。


init_point 完整收尾：6 对输入，Fulminate、teSpec OFF/ON 均逐例匹配独立预期；主程序 CN 与 QCP 5 个原始全称 VC 已编译、假设审计并独立内核检查。gpt-6.1-sol 实际 3 次调用，289,725 token；四工具分阶段时间与 RSS 已保存。完整进度 16/45，下一组 swap。


swap 完整收尾：10 对输入，Fulminate、teSpec OFF/ON 均逐例匹配独立预期；主程序 CN 与 QCP 1 个原始全称 VC 已编译、假设审计并独立内核检查。gpt-6.1-sol 实际 1 次调用，53,655 token；四工具分阶段时间与 RSS 已保存。完整进度 17/45，下一组 slf3_basic_inplace_double。

slf3_basic_inplace_double 进行中：9 个变体记录、16 个语言文件、52 对输入；Fulminate 52/52、teSpec ON 52/52、OFF 原生 50/52，2 次独立 ITP 在既有串行控制器 32952 / 会话 51150 运行。主程序 CN/QCP 完整验证已保存，ITP 进行中成本为 PENDING。完整组数仍 17/45。

slf3_basic_inplace_double：2 次原始 UNKNOWN 现已分别完成全部残余 VC 反证、入口 SAT、5 定理全局封闭及独立内核检查。OFF 原生仍是 50/52，含 ITP 最终 52/52；ON 原生和 Fulminate 都是 52/52。ITP 成本按这两次执行的实际模型/编译/内核阶段和逐次峰值平均单列，原始 UNKNOWN 不改写。


slf3_basic_inplace_double 完整收尾：52 对输入，Fulminate、teSpec OFF/ON 均逐例匹配独立预期；主程序 CN 与 QCP 2 个原始全称 VC 已编译、假设审计并独立内核检查。gpt-6.1-sol 实际 1 次调用，55,440 token；四工具分阶段时间与 RSS 已保存。完整进度 18/45，下一组 incr_two。

incr_two 已覆盖全部 12 个变体记录和 40 对输入，主程序 CN 验证及 QCP 7 个原始全称 VC、审计、独立内核均完成；实际 1 次模型、110,316 token。Fulminate 40/40，teSpec OFF/ON 各 38/40。错误别名调用的 2 输入 × 2 模式均为 contract_binding_unknown，执行安全/出口 PASS，但 annotations UNKNOWN；residual_vcs=[]、raw manual_obligation_count=0。它是未导出检查目标的契约绑定缺口，不能通过仅证明现有 body VC 来补成成功。4 条原始状态、两模式、日志/源/VC 哈希与 ITP 未执行原因已存 triage.json / coverage-gap.json。整组仍不完整，主程序证明成本齐备而测试 ITP 为 PENDING；按照夜间难例策略先继续 zero。完整进度保持 18/45。

zero 原生评测已覆盖 11 个变体记录、18 个语言文件、46 对合法输入。未初始化存储的输入变化为合法区域位置，不虚构可控初始标量。ON 46/46，OFF 原生 44/46，两条 no-op 后缺少已初始化零值的 UNKNOWN；Fulminate 44/46，两条未初始化 no-op 被报 PASS（漏检）；运行时未检出初始化状态的具体原因仍待审计，预期不改。QCP 主程序 2 VC 已编译审计，独立内核会话 75366。两次 ITP 模板用原始残余 VC 和真正四字节 Noninit 堆定义，入口 undef、出口零值不成立、两原始 VC 反证、入口 SAT 共五个定理全部交由实际 CLI 模型填写；没有预填输入特定反证。通用旧堆工具仅保留首个输入特定 refutation 之前的辅助事实。新 prepare_zero_noop_itp.py 保存模型模板和源/绑定/VC 锁。串行控制器 PID 11360 / 会话 45668 已启动，等待主程序内核成功；不能再启动控制器。快照已 attach --allow-partial 冻结，下一步先检查现有会话，kernel 完成后 publish_group_partial 可展示进行中表。最终 Fulminate 的 2 个漏检必须保留，不能写成三工具全对。当前完整进度仍 18/45，incr_two 的 4 条契约绑定 UNKNOWN 暂留缺口。

zero：2 次原始 UNKNOWN 现已分别完成全部残余 VC 反证、入口 SAT、5 定理全局封闭及独立内核检查。OFF 原生仍是 44/46，含 ITP 最终 46/46；ON 原生 46/46，Fulminate 44/46，两条未初始化 no-op 漏检保留。ITP 成本按这两次执行的实际模型/编译/内核阶段和逐次峰值平均单列，原始 UNKNOWN 不改写。


zero 完整收尾：46 对输入，完整逐例预期与原始／最终分类已归档；主程序 CN 与 QCP 2 个原始全称 VC 已编译、假设审计并独立内核检查。gpt-6.1-sol 实际 1 次调用，54,264 token；四工具分阶段时间与 RSS 已保存。完整进度 19/45，下一组 swap_array。


swap_array 完整收尾：20 对输入，完整逐例预期与原始／最终分类已归档；主程序 CN 与 QCP 5 个原始全称 VC 已编译、假设审计并独立内核检查。gpt-6.1-sol 实际 2 次调用，196,860 token；四工具分阶段时间与 RSS 已保存。完整进度 20/45，下一组 ref。

swap_array 收尾审计：20 个逻辑输入每个模式均有首轮缺头文件 ERROR 和修正后 PASS，共计每模式 40 次实际 teSpec 尝试；统计已逐项核对为两轮之和及逐输入最大 RSS。Fulminate 复用 exact-source / exact-harness 原始测量一次，未重复运行/重复计费。首轮 40 条配置 ERROR 保留且分类 RESOLVED_CONFIGURATION_ERROR。QCP 5 原始 VC 已实现 VC_Correct，2 次实际模型共 196,860 token、失败编译与原始目标/库假设审计成本全部计入；总验证 237.054294732 秒、2033.03125 MiB 峰值。结论明确限定为 VERIFIED_KERNEL_CHECKED_WITH_RUNTIME_LIBRARY_ASSUMPTIONS：原目标自带 4 个 sizeof 参数，加原有 IntArray.full_split_to_missing_i 使用的标准函数外延性；没有新声明证明公理，不能写 globally closed。完整进度 20/45。ref 的 6 个现有语言变体、24 个合法标量/框架输入计划已独立准备，尚未执行。

ref 已测全部 6 个变体记录、24 对合法输入；Fulminate 24/24（返回分配在目标规约监测后由客户释放），teSpec OFF/ON 各 0/24：均入口 SAT，遇仅有声明的 mallocUnsignedInt 后 missing_function_body、execution_completed=false、residual_vcs=[]。48 条运行模式结果已逐例专项记录和 triage，原始 UNKNOWN 不改写。没有完整执行或原始残余目标，不能用主程序全称证明代替测试 ITP，也没有编造模型/内核零成本。主程序 CN 与 QCP 2 原始 VC、所有实际修复、假设审计与独立内核检查均完成；整组仍不完整、测试 ITP PENDING。按难例策略继续 ref_greater，已准备 8 个现有记录、30 对合法输入但尚未执行。完整进度仍 20/45。

ref_greater 已跑 8 现有记录、30 合法输入；Fulminate 30/30，OFF/ON 各 30 UNKNOWN（入口 SAT，mallocUnsignedInt 无函数体、执行未完成、无残余目标）。另一次原模块 CN 验证实际失败：未 trusted 的 main 没有释放返回的 RW<unsigned int>，报 Left-over unused resource；这不是目标函数的反例，QCP 翻译本来也不含该 main，不能混淆验证范围。保留 CN 失败时间/RSS/日志/源哈希，QCP 未运行和测试 ITP 缺目标均为 PENDING，不填零。60 条工具缺口逐例 triage；保持预期 PASS。先继续 init_array，完整进度仍 20/45。

init_array：全部 6 语言变体、18 合法输入已实跑。Fulminate 18/18，teSpec OFF/ON 各 6 PASS、12 UNKNOWN；24 个模式执行均入口 SAT、执行完成并存在真实残余 VC，属于正例证明自动化缺口，逐执行正向 ITP 尚待完成，不计通过。主 CN 通过；当前 QCP 在 repeat_Z 0 0 = nil 的有效初始不变量处 Partial Solve Invariant Error，原配置与 --full-auto 两次实际时间/RSS 都保留。同一源哈希的历史六 VC 完整证书与目标文件已逐一复核 SHA256，保留其历史有效性；历史阶段成本缺失和本轮未重放均不填零。反向数组的旧绝对策略路径由逐次命令记录的临时只读兼容文件解析，策略内容哈希锁定，结束后移除兼容路径，原程序不改。完整组仍 20/45，转下一组。

ref_greater 的 QCP 主程序现已独立尝试生成（不再受 CN client 失败阻断）：当前生成器不能建立传给 refUnsignedInt 的 unsigned_last_nbits(n0+1,32) 取值范围，停止于调用前置检查，没有完整 VC 模块。新增实际失败时间/RSS/命令/日志均已保存，未调用证明模型，不捏造完整证明或零成本；与前述缺少分配器函数体的逐输入测试问题分列。

slf17_get_and_free 已跑全部现有变体、12 组合法输入：Fulminate 12/12，teSpec OFF/ON 各 12 UNKNOWN（入口 SAT，外部 free 无函数体，执行未完成、无原始残余目标）。原 CN 因外部接口没有规约而拒绝，失败时间/RSS 单列。QCP 主程序独立完成 5 个原始全称 VC、编译与假设审计及完整 coqchk；所有 gpt-6.1-sol 尝试都计入成本，验证证书不替代测试执行。假设限定见 receipt；不声称全部全局闭合。该组仍不完整，完整进度保持 20/45。


slf18_two_dice 已跑全部现有变体、14 组合法输入：Fulminate 14/14，teSpec OFF/ON 各 14 UNKNOWN（入口 SAT，外部 rand 无函数体，执行未完成、无原始残余目标）。原 CN 因外部接口没有规约而拒绝，失败时间/RSS 单列。QCP 主程序独立完成 11 个原始全称 VC、编译与假设审计及完整 coqchk；所有 gpt-6.1-sol 尝试都计入成本，验证证书不替代测试执行。假设限定见 receipt；不声称全部全局闭合。该组仍不完整，完整进度保持 20/45。

init_array 的首个正向逐执行 ITP 已实际完成：未初始化前向数组 n=0、OFF 的两个原始残余 VC 全部证明、编译、原始语句参数对照审计及独立 coqchk 通过。原始 UNKNOWN 保留，最终追加 PASS；没有新增证明公理，原 VC 内的 sizeof_* 类型参数如实披露。另 23 个模式执行的独立任务已冻结，由 PID19472/session16301 串行控制器继续实际 gpt-6.1-sol、所有修复、编译审计和内核计量；首个任务的三个审计诊断调用也计入真实时间/RSS。完整组仍20/45，当前已扫描26组，不能把已有同源历史证明或未执行完的外部调用算成完整组。

init_array 空间 SMT 门控已逐例核实：12 个原生 UNKNOWN 的 ON 执行均入口 SAT、scope=execution、执行完成、返回码0、无执行器错误，但包含 loop-invariant 抽象事件；spectest/spatial_smt.py 的资格检查因此返回 original_execution_not_eligible，attempted=0。不是已经送进空间 SMT 后超时/无法编码/返回 UNKNOWN，不能宣称 ON 已尝试这些目标。门控避免把抽象路径误作具体反例，不能盲目删除；后续应先证明抽象义务并建立原始 VC ID 的完整覆盖，再决定可细化范围。本轮仅记录，没有修改执行器或空间 SMT 逻辑。已完成的正向 ITP 则证明本次全部原始残余目标后才追加 PASS。

init_array 正向 ITP 推进到8/24（前向 n=0/1/2/3，OFF/ON 各一份独立编译、假设审计与完整 coqchk）。n=2 OFF 第3次实际模型修复完成8目标；n=3 ON 第2次完成10目标，新增依赖仅为已审计原库 join_assoc 的标准函数外延性，原 sizeof_* 类型参数另列，未新增本地公理，不声称全局封闭。n=2 ON 的第3次候选虽编译通过，但额外依赖 propositional_extensionality，已拒绝且计费；第4次实际 CLI 审阅复用了 n=2 OFF 的整个同哈希原 VC 已检查证书。n=3 OFF 第3次同样显式复用同哈希 ON 证书。两次均保留源码／binds／整个原 VC／原证书／证明哈希，并在新执行中独立重跑全部目标编译、原始语句和库假设审计、完整内核检查，标注 EXACT_GOAL_CERTIFICATE_REUSE_REPAIR，不能描述成从零独立搜索。所有实际失败模型、额外 Show/Abort 诊断编译、库假设诊断和被拒绝候选均保存在逐执行记录，原 UNKNOWN 不改写。完整进度20/45未变，主程序当前生成器问题仍单列。原串行控制器继续其余队列；controller.json 中 deferred 是最初两次尝试的历史事件，当前已解决／未解决以 positive ITP index.json 和模式统计为准。

succ_using_incr 已实跑全部7个CN/QCP记录、19对输入：两个正确翻译及泄漏版本各6个合法无符号数（含回绕），原始空main仅1个真实入口。Fulminate13 PASS、6 FAIL，19/19符合预期；OFF/ON各1 PASS、18 UNKNOWN，含6个应拒绝的泄漏输入，不能计作成功检出。36个模式异常均入口SAT，在缺失allocator函数体处停止、无原始残余目标，逐例记录ITP无法执行的原因。主CN因cn_free_sized无规约而拒绝；QCP实际生成13原始全称VC但证明/审计/独立内核阶段仍PENDING，不冒称验证通过。轻量原生测量与已存在init_array队列的共享负载已披露。完整20/45，实际扫描27组。

runtime-extras__return_owned_local 已实跑全部2个语言记录、13对输入。Fulminate13/13符合预期；OFF6 PASS7 UNKNOWN，ON6 PASS6 FAIL1 UNKNOWN。6个bad悬空局部地址用例在ON实际各发起1个空间SMT查询（counterexample_query_sat、原始返回残余完整覆盖），全部正确拒绝；这是原生NOT_CHECKED结果，不冒称Coq内核证书。OFF每次均完成执行并留下2原始目标，6次ITP仍待完成；原始main两模式在cn_malloc缺函数体处停止，无目标可交ITP。原CN实际接受但bad/main均trusted，只验证get；不能误解为CN证明了错误程序。QCP实际生成10全称目标，按同源哈希保留历史main返回VC反证，未将其当作bad生命周期目标反证或补造历史成本。完整20/45，实测28组。

runtime-extras__same_func_malloc_free: all existing variants, 21 actual input pairs; Fulminate 21/21 expected matches. OFF {'PASS': 18, 'UNKNOWN': 3}, ON {'PASS': 18, 'UNKNOWN': 3}. Original CN trust scope disclosed; QCP original generation targets 10, proof/refutation and kernel stages pending. Unexpected cases individually recorded, UNKNOWN not successful. No-argument clients have one distinct entry each. Native shared-host overlap disclosed. Whole group remains incomplete.

runtime-extras__down_malloc_up_free: all existing variants, 28 actual input pairs; Fulminate 28/28 expected matches. OFF {'UNKNOWN': 28}, ON {'UNKNOWN': 28}. Original CN trust scope disclosed; QCP original generation targets 0, proof/refutation and kernel stages pending. Unexpected cases individually recorded, UNKNOWN not successful. No-argument clients have one distinct entry each. Native shared-host overlap disclosed. Whole group remains incomplete.

runtime-extras__leaky: all existing variants, 7 actual input pairs; Fulminate 7/7 expected matches. OFF {'UNKNOWN': 7}, ON {'FAIL': 6, 'UNKNOWN': 1}. Original CN trust scope disclosed; QCP original generation targets 7, proof/refutation and kernel stages pending. Unexpected cases individually recorded, UNKNOWN not successful. No-argument clients have one distinct entry each. Native shared-host overlap disclosed. Whole group remains incomplete.

runtime-extras__leaky_main: all existing variants, 7 actual input pairs; Fulminate 6/7 expected matches. OFF {'UNKNOWN': 7}, ON {'UNKNOWN': 7}. Original CN trust scope disclosed; QCP original generation targets 8, proof/refutation and kernel stages pending. Unexpected cases individually recorded, UNKNOWN not successful. No-argument clients have one distinct entry each. Native shared-host overlap disclosed. Whole group remains incomplete.

专项异常：runtime-extras__leaky_main 原始main未释放mkref返回分配，冻结无泄漏预期FAIL，但Fulminate实际PASS。生成的同一份exec.c中，mkref出口有cn_postcondition_leak_check，main出口仅free_ghost_frame_stack/return，没有出口泄漏检查。证据、源/监测代码哈希、原命令/时间/RSS和未改预期保存到该组fulminate-main-exit-gap.json；不把受信CN静态接受说成证明错误程序，也不假称teSpec检出（其两模式被缺allocator阻断）。另down_malloc_up_free所选既有asserted翻译在main断言后丢失局部权限，当前QCP生成失败；原始日志和注解frame语义待独立审阅的问题单列，不改输入预期迎合结果。

init_array 反向n=2 ON执行在两次实际失败尝试后，第3次实际gpt-6.1-sol审阅复用了OFF同一整个Goal、相同源/binds/目标清单的已检查证书。新执行已单独完成全部原始残余目标编译、原语句/库假设审计和完整coqchk，所有尝试时间/RSS/token都保留，显式标记EXACT_GOAL_CERTIFICATE_REUSE_REPAIR，不说从零独立搜索；现已核验12/24。原串行控制器继续余下队列，历史deferred不当作当前未解决清单。

runtime-extras__up_malloc_down_free: all existing variants, 14 actual input pairs; Fulminate 14/14 expected matches. OFF {'UNKNOWN': 14}, ON {'UNKNOWN': 14}. Original CN trust scope disclosed; QCP original generation targets 10, proof/refutation and kernel stages pending. Unexpected cases individually recorded, UNKNOWN not successful. No-argument clients have one distinct entry each. Native shared-host overlap disclosed. Whole group remains incomplete.

runtime-extras__double_free: all existing variants, 14 actual input pairs; Fulminate 14/14 expected matches. OFF {'PASS': 12, 'UNKNOWN': 2}, ON {'PASS': 12, 'UNKNOWN': 2}. Original CN trust scope disclosed; QCP original generation targets 0, proof/refutation and kernel stages pending. Unexpected cases individually recorded, UNKNOWN not successful. No-argument clients have one distinct entry each. Native shared-host overlap disclosed. Whole group remains incomplete.

runtime-extras__bad_free: all existing variants, 8 actual input pairs; Fulminate 8/8 expected matches. OFF {'UNKNOWN': 8}, ON {'UNKNOWN': 8}. Original CN trust scope disclosed; QCP original generation targets 0, proof/refutation and kernel stages pending. Unexpected cases individually recorded, UNKNOWN not successful. No-argument clients have one distinct entry each. Native shared-host overlap disclosed. Whole group remains incomplete.

init_array 首轮逐执行证明队列已正常结束（UTC22:44:58），没有留待接续的原控制器进程，截止watchdog也随之退出。实际24个模式任务均已尝试，50次模型调用全部计量，最终12份证书完成独立编译/假设审计/完整coqchk，另12份仍为证明脚本失败；不能把其当作反例或通过，也不重启已结束的队列。主程序生成问题仍独立保留。后续从真实pending索引挑选有界修复，先继续其他组。新增up_malloc_down_free、double_free、bad_free实测36对输入；Fulminate均符合各工具冻结预期；double_free/bad_free的QCP原负模块在free前置处拒绝符合源缺陷，原生拒绝不冒称完整VC的Coq反证。CN原模块均trusted，接受不等于目标已证明。完整20/45，实测35组。

slf_sized_stack: all existing variants, 47 actual input pairs; Fulminate 0/47 expected matches. OFF {'UNKNOWN': 46, 'PASS': 1}, ON {'UNKNOWN': 46, 'PASS': 1}. Original CN trust scope disclosed; QCP original generation targets 30, proof/refutation and kernel stages pending. Unexpected cases individually recorded, UNKNOWN not successful. No-argument clients have one distinct entry each. Native shared-host overlap disclosed. Whole group remains incomplete.

slf_sized_stack 专项：全部3个语言记录、14个函数配对、47个合法输入尝试均保存（8/6个既有译本核心函数；无参create/nil各1入口）。Fulminate47次均在IntList资源谓词解析处NOT_BUILT，CN原模块同样报Unknown resource predicate IntList；没有测试二进制，测试时间和RSS均为null，不能填零或说执行通过。OFF/ON各1 PASS、46 UNKNOWN：26次缺外部体（其中24入口UNKNOWN），18次precondition_requires_proof，2次contract_binding_unknown。入口UNKNOWN者需先证明入口可满足，再处理全部原始目标，不能只凭后置证明算测试成功。QCP本轮生成30全称目标；同源历史完整证明已复核源码/目标/证明/check哈希，但新旧整个Goal字节不同，按原历史范围保留，不冒称当前模块已认证；历史成本缺失仍null。仅历史source匹配并不替代当前30目标审计。原trusted CN main/额外驱动无QCP对应，单列范围缺口；未冒称全源函数都已成对测试。成本构表修复了未生成二进制时RSS=null的展示错误，实际47条记录验证未执行阶段仍PENDING。完整20/45，扫描36组。

array_load: all existing variants, 67 actual input pairs; Fulminate 67/67 expected matches. OFF {'PASS': 62, 'UNKNOWN': 4, 'FAIL': 1}, ON {'PASS': 62, 'UNKNOWN': 4, 'FAIL': 1}. Original CN trust scope disclosed; QCP original generation targets 2, proof/refutation and kernel stages pending. Unexpected cases individually recorded, UNKNOWN not successful. No-argument clients have one distinct entry each. Native shared-host overlap disclosed. Whole group remains incomplete.

const_example_lessgood: all existing variants, 1 actual input pairs; Fulminate 1/1 expected matches. OFF {'PASS': 1}, ON {'PASS': 1}. Original CN trust scope disclosed; QCP original generation targets 3, proof/refutation and kernel stages pending. Unexpected cases individually recorded, UNKNOWN not successful. No-argument clients have one distinct entry each. Native shared-host overlap disclosed. Whole group remains incomplete.

array_load 主程序QCP完整验证已收尾：2个原始全称目标，经实际gpt-6.1-sol一次调用（96252 token、56.953秒）、全部编译、原始目标与IntArray.full_split_to_missing_i库假设审计、完整独立coqchk。保留原sizeof_*类型参数与该原库标准函数外延性，不声称全局封闭；总验证187.989918秒，逐阶段最大进程RSS已保留，内核峰值2036.871094MiB。CN原strong模块实际在main调用处报Unknown function read_proxy而拒绝，日志与失败时间/RSS保留；这不等于read规约被反证。全部13记录/67对输入，FT67/67，两模式62 PASS4 UNKNOWN1 FAIL；客户剩余ITP及array_main_cast源/翻译预期审查仍未解决，不能把主程序证书替代它们，完整组仍20/45。另const_example_lessgood原始单入口动态测试三工具均PASS，CN trusted静态范围如实披露；其3原始QCP目标正在实际CLI/Coq计量，不冒称完成。扫描38组。

const_example_lessgood 的3个原始QCP全称目标现已独立编译、假设审计及完整coqchk通过，实际gpt-6.1-sol一次，54857 token，各阶段时间/峰值内存单列。唯一无参入口的Fulminate/OFF/ON均PASS、无需测试ITP（阶段NOT_REQUIRED）；原CN main trusted，静态接受仍是受信范围，不改称VERIFIED提增完整数。两语言记录/一原始入口的固有限制及完整QCP证书单列；完整仍20/45，覆盖38组。

runway__funcs2: all existing variants, 150 actual input pairs; Fulminate 0/150 expected matches. OFF {'ERROR': 42, 'PASS': 30, 'UNKNOWN': 78}, ON {'ERROR': 42, 'PASS': 30, 'UNKNOWN': 78}. Original CN trust scope disclosed; QCP original generation targets 215, proof/refutation and kernel stages pending. Unexpected cases individually recorded, UNKNOWN not successful. No-argument clients have one distinct entry each. Native shared-host overlap disclosed. Whole group remains incomplete.

runway__funcs2 全部6语言记录、40函数变体、150个合法结构体状态已尝试。六字段具体入口fixture逐字节审计仅加Require等式，原body/post不变；两模式各30 PASS、78 UNKNOWN、42 ERROR。原snapshot版本30个用例两模式全PASS，直接用原With绑定的一次正确消融也PASS；另一次诊断误用其他变体的空With绑定，明确标为无效诊断配置、保留成本，不计额外输入或工具错误。其余源码编码存在分支上限、调用绑定和无效executor JSON等异常，逐例区分完整执行/入口/残余目标。Fulminate150次NOT_BUILT；另外4次有界兼容探测依次暴露旧bool逻辑类型、C bool类型不匹配、未解释INACTIVE及头文件函数插桩缺失__cn_ret/epilogue；均未造出测试二进制，原规约和冻结PASS不改，154次流水线成本全计。兼容探测的不同头文件环境已分别冻结，可复现，原始命令不改。QCP生成215原始全称目标，实际预编译原Goal发现缺UndefStructPredState上下文，失败时间/RSS单列；历史仅手工tick目标加原生自动结果，不能冒称当前215全目标独立内核证书。未启动无上下文目标的无效模型任务，agent/内核仍PENDING；源/原始VC/hash/失败记录全部保留。完整20/45，扫描39组。

Dbl_Linked_List__singleton: all existing variants, 7 actual input pairs; Fulminate 0/7 expected matches. OFF {'UNKNOWN': 7}, ON {'UNKNOWN': 7}. Original CN trust scope disclosed; QCP original generation targets 4, proof/refutation and kernel stages pending. Unexpected cases individually recorded, UNKNOWN not successful. No-argument clients have one distinct entry each. Native shared-host overlap disclosed. Whole group remains incomplete.

dll_add: all existing variants, 14 actual input pairs; Fulminate 0/14 expected matches. OFF {'UNKNOWN': 14}, ON {'UNKNOWN': 14}. Original CN trust scope disclosed; QCP original generation targets 17, proof/refutation and kernel stages pending. Unexpected cases individually recorded, UNKNOWN not successful. No-argument clients have one distinct entry each. Native shared-host overlap disclosed. Whole group remains incomplete.

dll_remove: all existing variants, 18 actual input pairs; Fulminate 0/18 expected matches. OFF {'UNKNOWN': 18}, ON {'UNKNOWN': 18}. Original CN trust scope disclosed; QCP original generation targets 19, proof/refutation and kernel stages pending. Unexpected cases individually recorded, UNKNOWN not successful. No-argument clients have one distinct entry each. Native shared-host overlap disclosed. Whole group remains incomplete.

mergesort: all existing variants, 17 actual input pairs; Fulminate 0/17 expected matches. OFF {'PASS': 1, 'UNKNOWN': 9, 'ERROR': 7}, ON {'PASS': 1, 'UNKNOWN': 9, 'ERROR': 7}. Original CN trust scope disclosed; QCP original generation targets 40, proof/refutation and kernel stages pending. Unexpected cases individually recorded, UNKNOWN not successful. No-argument clients have one distinct entry each. Native shared-host overlap disclosed. Whole group remains incomplete.

list_all: all existing variants, 94 actual input pairs; Fulminate 0/94 expected matches. OFF {'PASS': 1, 'UNKNOWN': 32, 'ERROR': 61}, ON {'PASS': 1, 'UNKNOWN': 32, 'ERROR': 61}. Original CN trust scope disclosed; QCP original generation targets 0, proof/refutation and kernel stages pending. Unexpected cases individually recorded, UNKNOWN not successful. No-argument clients have one distinct entry each. Native shared-host overlap disclosed. Whole group remains incomplete.

queue_all: all existing variants, 34 actual input pairs; Fulminate 0/34 expected matches. OFF {'ERROR': 25, 'UNKNOWN': 9}, ON {'ERROR': 25, 'UNKNOWN': 9}. Original CN trust scope disclosed; QCP original generation targets 0, proof/refutation and kernel stages pending. Unexpected cases individually recorded, UNKNOWN not successful. No-argument clients have one distinct entry each. Native shared-host overlap disclosed. Whole group remains incomplete.

list_all: all existing variants, 94 actual input pairs; Fulminate 0/94 expected matches. OFF {'PASS': 2, 'UNKNOWN': 85, 'ERROR': 7}, ON {'PASS': 2, 'UNKNOWN': 85, 'ERROR': 7}. Original CN trust scope disclosed; QCP original generation targets 0, proof/refutation and kernel stages pending. Unexpected cases individually recorded, UNKNOWN not successful. No-argument clients have one distinct entry each. Native shared-host overlap disclosed. Whole group remains incomplete.

queue_all: all existing variants, 34 actual input pairs; Fulminate 0/34 expected matches. OFF {'UNKNOWN': 31, 'ERROR': 3}, ON {'UNKNOWN': 31, 'ERROR': 3}. Original CN trust scope disclosed; QCP original generation targets 0, proof/refutation and kernel stages pending. Unexpected cases individually recorded, UNKNOWN not successful. No-argument clients have one distinct entry each. Native shared-host overlap disclosed. Whole group remains incomplete.


## 07:53 核对：45 组已有实测记录，20 组完整

按各组实际评测报告（read 复用既有空间 SMT 两模式报告）汇总，共45组、1551个 CN/QCP 测试配对；该数字不是1551个不同输入状态，部分现有 CN 变体共享同一 QCP 输入。完整评测仍20/45，其余25组有明确缺口，不能把首轮扫描称作全部完成。attempt-coverage.json 为逐组报告指针与实际配对数。

本轮补测 singleton 7、dll_add 14、dll_remove 18、mergesort 17、list_all 94、queue_all 34，共184配对，均实际执行 OFF/ON。dll_add 目前只覆盖空链表分支，非空分支仍有缺口；两个 DLL orig.broken 原始版本缺少函数规约，不能把相同 C 实现误标为错误实现。list_all/queue_all 原始 CN-only 客户端和可信辅助函数也不冒充已配对覆盖。

singleton 的全部4个原始全称 VC 已通过独立 Coq 内核检查：1个全局闭合，3个仅保留原运行时 eval_addr_expr 参数，没有新增证明公理。5次 gpt-6.1-sol 调用（包括未填完、编译失败和引入额外公理而被拒绝的轮次）实际591827 tokens；原生0.016198秒、agent284.063秒、编译/假设审计及两个额外诊断11.952633秒、独立内核127.042882秒，总423.074712秒，最大单进程RSS1766.886719MiB。原 DLLSupplement.v 仅以字节相同的原始逻辑定义提供编译上下文，原始Goal没有修改。CN/Fulminate 在原始依赖 IntList 前向资源谓词处失败，teSpec缺少 malloc_node 执行体，所以本组仍未完整。

本轮 list_all/queue_all 各61/25个配对的初始内部绑定ID以数字开头，是评测适配器配置错误。172次失败的模式执行日志与成本保留，仅给内部ID加 case_ 后重新执行；源、参数、With绑定值与冻结预期不变。最终 list_all 两模式各2 PASS/85 UNKNOWN/7 ERROR，queue_all 各31 UNKNOWN/3 ERROR。成本表包含全部失败与重试，配置修复清单在 tespec-unexpected/configuration-repairs-20261016-bind-ids.json。其余 ERROR 是实际执行器的结构体初始化等错误，不算成功检出。

merge/list 原始 CN 的分离 magic comment 兼容问题、queue/DLL 前向资源谓词、外部无执行体、入口约束/残余原始VC均如实保留。queue 原始 assert_not_equal 无前提却声称任意指针不等的假设，单独记录 original-assumption-gap.md；本次实际首先发生解析失败，未把这条逻辑缺口编造成运行时反例。所有未执行的证明阶段仍为空值/PENDING；未构建的 Fulminate 独立测试时间和RSS为空值。


## 夜间截止：08:00

已按约定停止本次夜间续跑并停用心跳，没有仍在运行的 benchmark 证明或测试进程。最终45组已有实测报告，共1551个测试配对，完整20组、未完整25组。未完成原因和缺测阶段保留；不把 UNKNOWN、非预期 ERROR 或仅原生生成算作通过。单工作树 main，未修改/push sac，未混入论文。全部45组结果/成本表及异常台账已保存，收尾记录经SSH推送。


## 2026-10-18：array_load 补齐，完整 21/45

array_load 已完成全部 13 个语言版本记录、17 个入口配对、67 对有限测试（60 个 helper 输入、7 个原始 client 的各一个不同入口）。固定预期未改变。Fulminate 67/67；teSpec 空间 SMT OFF/ON 各原生 65 PASS、2 UNKNOWN，分别完成 2 次独立逐执行 ITP 后最终均 67/67。4 次 ITP 覆盖 24 个原始残余 VC，实际 gpt-6.1-sol 共 6 次调用，两个失败的初次编译及所有修复均计入。编译、假设审计和 4 次独立 coqchk 全部通过；保留原运行时参数和标准函数外延性，没有新增证明公理，不宣称全局封闭。

主 CN 使用当前锁定 CN 5.2 工具链对 strong read 与原 main 整模块无 trusted/skip/only 验证通过；兼容迁移与函数 alpha 重命名保留各原变体的区别。主 QCP 复用哈希匹配的原 2 个全称 VC 证书和原计量，作用域仍是 read；未冒称客户端全称证明。修复的 QCP 译本已按新哈希重测，旧失败/UNKNOWN 及诊断成本保留，不把新源码 PASS 倒填成旧 VC 已证明。

完整结果、生成/执行、agent 证明、Coq 编译审计、独立内核阶段时间/token/RSS 和历史修复额外成本见 [array_load 结果成本表](../benchmark/results/array_load/result-cost.md)；来源修复见 [专项记录](benchmark-array-load-repair-20261018.md)。`validate_group_evaluation.py --group array_load` 已通过所有源/日志/原始 VC/证明哈希及成本核验。当前完整 **21/45**，尚缺 24 组。2026-10-16 夜间截止记录保持原样，本次是后续补齐。


## 2026-10-18：有限数组中间断言空间 SMT 接入回归

已对上述完整 21 组的 900 对输入实际重跑 teSpec OFF/ON，共 1800 次，源、预期及历史证据哈希未变，0 退化。OFF 为 496 PASS / 350 FAIL / 31 UNKNOWN / 23 预期 ERROR；ON 为 498 PASS / 379 FAIL / 0 UNKNOWN / 23 预期 ERROR。仅新增 array_load 两个客户端 ON 的 UNKNOWN→PASS，与旧 ITP 结论一致；ON 的 array_load 现为 67 个原生 PASS，无测试 ITP 待办。旧完整四工具成本不覆盖，完整组数仍 21/45。本次新计量、通用正反例、证据边界与复现位置见 [接入说明](spatial-smt-annotation-array-integration-20261018.md)。


## 2026-10-18：检查下一待完整组 const_example_lessgood

按 21 组完成后的续做顺序检查本组。当前版本 teSpec OFF/ON 对唯一合法入口均 PASS，实际空间查询 0、无测试 ITP。QCP 原始 3 VC 的源/目标/证明/日志哈希及封闭审计匹配。原 CN main 的 trusted 跳过正文；仅移除该指令的诊断副本实际输出 main -- pass，定义、断言和 C 主体均保留。本次只检查并保存诊断，未替换正式主程序或把原 trusted 接受改写成证明，完整计数保持 21/45。细节、初次控制器配置错误与全部重测成本见 [范围复查](../benchmark/results/const_example_lessgood/20261018-scope-recheck-v2/summary.md)。


## 2026-10-18：第 23 个续做检查 Dbl_Linked_List__singleton

7 个合法输入实际重跑 teSpec OFF/ON 各 7 次，入口 SAT，但在无函数体 malloc_node 调用处 UNKNOWN；无残余 VC，空间查询 0，不能由 ITP 补完尚未完成的测试执行。CN 主程序和 7 次 Fulminate 插桩均在旧 IntList 递归依赖处前端失败。QCP 四个原始全称 VC 的源、Goal、Candidate、原定义上下文及最终编译/内核日志哈希匹配，保持原分配器契约条件下的验证范围。未改源码、预期或工具实现，仍 21/45 完整。新成本、逐输入异常及修复边界见 [本组复查](../benchmark/results/Dbl_Linked_List__singleton/20261018-current-recheck/summary.md)。

## 2026-10-18：第 23 组 singleton 的 CN/Fulminate 已修复

原 singleton 程序和后置条件不变，依赖适配至锁定 CN 5.2；IntList_nil、IntList_cons、singleton 整模块均 pass，无 trusted/skip/only。外部分配器契约仍是验证前提。Fulminate 接入已有运行库分配/释放接口后，原有 7 个合法输入全部 PASS；另一个写错节点值的诊断副本由后置条件正确拒绝，不增加正式样本数。原失败、修复失败、先导运行、负控及正式两阶段时间/RSS均已保留并单列；原生 token 为0，无新增证明 agent 调用。

teSpec 按用户要求暂缓，本轮未运行；历史两模式各7 UNKNOWN是缺 malloc_node 执行体，执行未完成且无残余VC，不能作为7个可直接填写的ITP任务。QCP旧4目标证书和成本原样复用。整组仍未完成，完整计数 **21/45**。见 [修复说明与复现](benchmark-singleton-cn-fulminate-repair-20261018.md) 和 [本组结果成本表](../benchmark/results/Dbl_Linked_List__singleton/result-cost.md)。

## 2026-10-18：第 24 组 dll_add 复查

当前工具链下原依赖仍IntList解析失败；借用singleton兼容层后CN的IntList_nil、IntList_cons、add均pass。Fulminate两个既有CN记录各7个空链表输入均实际PASS，pipeline与独立执行分别计量；其中7个无add规约的orig.broken只能计程序运行，不能当规约覆盖。原CN后置仅保证形状，QCP另保证插入值，两者不等价；不改原规约来伪造对齐。非空分支仍无覆盖。teSpec分配器按约定暂缓；QCP17原始VC完整证书仍缺，历史manual只有1个引理。保持21/45完整，正式旧入口不覆盖，本次全部30个阶段成本另列。见 [第24组复查](../benchmark/results/dll_add/20261018-scope-recheck/summary.md)。

## 2026-10-19：singleton malloc 新版本复测

当前 main aee98873a 执行器实际重跑 singleton 原 7 输入，覆盖 inline/modular、entry-exit/all-boundaries、空间 SMT OFF/ON，共56次。全部入口SAT、契约采样成功、执行完成；每次剩1个Dll返回VC，最终56 UNKNOWN，SMT ON明确不支持Dll。原来的malloc_node缺函数体阻塞已消失；不同阶段的问题没有合并为“通过”。当前执行器和上次final相同，56个Goal哈希也匹配。本次原生时间/RSS、输入/VC/日志哈希与异常台账已独立保存，未重跑CN/QCP/Fulminate或ITP，完整组仍21/45。见[复测说明](../benchmark/results/execution-strategy/20261019-singleton-malloc-retest/retest-summary.md)。


## 2026-10-19：inline VC 保存与去重回归

已发布 frozen safety 载荷精确共享、VC 报告哈希索引、空临时 entailment 副本削减和 JSON 临时字符串释放；保留每一个原始证明义务。没有修改在线条件求值、循环退出或分支剪枝。现有 105 项 Python 测试、ASan/UBSan 存储测试、14 组旧新循环差分通过。21 个完整组的 900 对输入、空间 SMT OFF/ON 共 1800 次回归为 0 退化，进一步逐例确认全部原始 Goal/auto/check 字节及原生 VC/witness 记录一致；modular 42 个正例代表也通过。

这不表示 1800 次均为程序 PASS：历史 UNKNOWN 和预期 ERROR 保留。没有新增完整组、没有重跑 CN/Fulminate/ITP，进度仍 21/45；历史成本不覆盖。测得重复快照存储减少，但长循环整体内存仍受活状态历史和其他 witness 影响，不宣称已解决全部内存增长。完整日志、时间/RSS、构建哈希和复现命令见 [存储优化审计](../benchmark/results/vc-storage-regressions/20261019-audit/summary.md)。

### 2026-10-19：实例值优先的在线分支判定

已复用 QCP 实例代入/常量化简，在分支纯可达性查询中优先直接求值；剩余符号公式回退原 SMT，空间策略检查保持。live state、原始见证和 VC 生成不变。21 组 1800 次 OFF/ON 完整回归结果一致，5262 份 Coq 文件逐字节一致；42 次 modular 对照、11 个既有循环对照和24个控制流边界对照通过。现有105项 Python 测试通过，query子集重跑含新增2项，共107项不同测试。

完整组数保持21/45；无新增 CN/Fulminate/ITP 测量。审计：[实例值优先分支判定](../benchmark/results/vc-storage-regressions/20261019-direct-branch-audit/summary.md)。


## 2026-10-19：证明型 VC 延后自动求解

正常具体测试中，原生证明型 witness 请求保留原节点后排队，目标执行完成后统一复用 QCP 策略/SMT；在线必要 SMT、实例更新、分支剪枝仍保留，没有在线 ITP。两个执行策略和 VC 范围参数独立，原始义务不删；提前 ERROR 也处理已有义务。旧日志/全自动及全称验证路径保留原时序。

已完整 21 组的 900 对输入 OFF/ON 共 1800 次零退化，5262 个原 Goal/auto/check 文件字节一致；modular 42 次代表执行、39 对专项也精确一致，113 项 Python 测试及队列/共享存储 ASan/UBSan 通过。最终所有队列 pending=0。OFF 仍 31 UNKNOWN，ON 0 UNKNOWN，两个模式各 23 预期 ERROR；没有把这些状态变造为 PASS。开发中边界抑制与源位置两项回归已修复，失败尝试和最终复测全部保存。未新增 ITP/全称证书，完整组仍 **21/45**，历史四工具成本不覆盖。见 [实现、证据与复现](../benchmark/results/vc-storage-regressions/20261019-deferred-vc-audit/summary.md)。


## 2026-10-20：21组全部输入补充modular原生评测

已实际补测21组/900对输入、modular空间SMT OFF/ON共1800次，旧源/输入/预期及证明证据在执行期间哈希不变。两模式各491 PASS、350 FAIL、36 UNKNOWN、23预期ERROR，原生预期匹配各864/900。16组两模式全部匹配；array_load/incr/read/slf3_basic_inplace_double/zero有72次UNKNOWN，其中58次残余VC待ITP、14次modular断言边界采样未完成、不能用ITP替代执行。原差分门槛如实保留43次退化，原生覆盖齐全不冒称全部判定通过。

每组独立modular结果成本MD/JSON/CSV及全局索引已保存，主组表追加链接。时间、逐次峰值RSS均值与实际token分阶段；未运行的agent/Coq/内核为PENDING/BLOCKED。全部异常逐次入专项台账。旧四工具成本与完整21/45范围不覆盖。本轮未改执行器。见[本批详情](benchmark-modular-supplement-20261020.md)。


## 2026-10-20：modular的58次残余VC ITP已全部收尾

58次逐执行实际gpt-6.1-sol调用、分别编译/假设审计及58次完整独立coqchk全部通过；116个原始残余VC被反证、58个入口SAT获证，连同堆事实242个登记定理全部全局闭合，最终均按冻结预期FAIL成功检出。复用的是相同完整Goal的历史证明材料，实际模型审阅/引用、编译和内核重新计量，不宣称从零搜索；token总计3,587,331。每次ITP平均162.293281秒、61850.534483token、单次最大进程峰值均值1848.154432MiB，三个阶段分别保留，所有实际修复计量未丢弃。

两模式最终各491 PASS、379 FAIL、7 UNKNOWN、23预期ERROR，预期匹配各893/900；modular完整20/21组。剩array_load7原始客户端×OFF/ON共14次，在实例化阶段未完成且未生成完整Goal，保留UNKNOWN/BLOCKED，不能伪造ITP目标；entry-exit诊断也同样未完成，额外28次含配置拒绝的本地诊断调用成本另列。原生UNKNOWN不改，原四工具成本及历史21/45范围不覆盖。见[完整收尾与均值](benchmark-modular-itp-20261020.md)。


## 2026-10-20 modular 取消边界选值实验

完成21组900对输入、OFF/ON共1800次原生重测，关闭采样后每模式493 PASS、350 FAIL、34 UNKNOWN、23预期ERROR；相对采样modular只有4次UNKNOWN转PASS，其余状态不变。原array_load七客户端中translation6/11已自动通过，translation5/8剩4次出口VC，translation7/12/9剩6次边界frame限制。旧58个残余目标与历史内核证书逐字节匹配，本轮未新增ITP或声称新完整证明成绩。inline另外1800次回归与旧批次原生/原始Coq目标字节全部一致，464项测试通过（15项跳过）。各组追加独立实验成本表，旧完成标志和四工具成本保留。见[记录与复现](benchmark-modular-symbolic-20261020.md)。


## 2026-10-20 modular边界修复与逐执行ITP

采样改为副本选值、失败原样符号回退；修复局部/入口地址关联、QCP所有权frame推断、资源折叠与typed sizeof策略兼容。21组900对输入，采样ON/OFF×空间OFF/ON共3600次，所有非预期ERROR输入均执行到出口；原7个array_load客户端全部解除采样/边界frame阻塞。新增8次ITP、17次实测gpt-6.1-sol调用（全部失败修复计入）；translation7四次原始整体目标证明通过，translation12四次只完成入口SAT和辅助纯子目标反证，父目标保留其他空间分支，正式结果仍UNKNOWN。不能把辅助反证当作整次FAIL；原控制器的过度分类在发布审计中拒绝，原回执保留。旧58份精确同目标证书审计后分别引用到两个采样设置，未冒充新测量。每套配置最终497 PASS、379 FAIL、1 UNKNOWN、23预期ERROR，899/900匹配；未知均为translation12，未改预期。inline1800次原始VC/Coq/状态精确一致；466项测试通过（15跳过）。原完成范围保持历史含义。见[完整报告与成本](benchmark-modular-boundary-fix-20261020.md)。

## 2026-10-21：第 21 组 array_load 完整父 VC 诊断

当前版本重跑全部67对输入、inline/modular×空间OFF/ON，共268次，未修改源/spec/输入/预期。inline最终两模式均67 PASS；modular通过精确目标哈希引用translation7证书后均66 PASS、1 UNKNOWN，仍为translation12。实际gpt-6.1-sol五次调用、972766 token，全部失败编译/修复计入同一执行任务；八个诊断引理经编译、原始假设审计和完整独立coqchk，但没有原始父VC的无条件证明或反证，所以仍不将modular第21组标为全部符合预期。根因涉及弱read合同不足和空间反模型缺少局部栈地址布局见证。见[完整诊断](benchmark-array-load-parent-vc-20261021.md)与[结果成本](../benchmark/results/array_load/20261021-parent-analysis/result-cost.md).
