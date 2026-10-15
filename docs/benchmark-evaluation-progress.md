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
