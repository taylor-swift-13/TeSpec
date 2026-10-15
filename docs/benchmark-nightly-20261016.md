# 2026-10-16 夜间逐组评测

用户要求今晚继续争取完成 45 组，并对 teSpec 不符合预期的结果专门记录。当前线程已启用夜间续跑，automation id 为 `tespec-benchmark-45`，约每 10 分钟触发一次接续；北京时间 2026-10-16 08:00 截止，到时停止本次夜间心跳并报告真实完成量。电脑与 Codex 必须保持运行。只在出现完成组、重要异常、阻塞或截止时通知。

唯一仓库 `/home/yangfp/teSpec`、唯一 main 分支、禁止新工作树。并行论文修改不混入本任务提交。SSH push main，sac 不 push。执行器和 SMT 引擎实现源码不得提交到此仓库。每次只测一组，正式计量期间避免同时跑其他组的负载。

先读 `benchmark/results/group-result-cost-index.json` 决定哪些组已经完整。查看 `benchmark/results/nightly-20261016/status.json` 当前在做哪一步；若进程仍运行，接续进程而非重复启动。续跑开始后 add 已完成全部 122 对测试、主程序两条通用 VC 的内核检查及完整成本表。add_read 和 add_two_array 均已完成；当前 7/45 组完整，下一组 array_load，实时步骤以 status.json 和组内回执为准。难例保留完整缺项与 teSpec 异常后继续其他组；不能将失败、UNKNOWN 或欠缺成本的组标为完整。

## 工具入口

- `tools/benchmark/test_group_variants.py --group <group>`：读取组内 evaluation-plan.json，保存每变体多合法输入的 Fulminate 和 teSpec OFF/ON 测量。原始目标文件不得改写；CN 原 main 不作为有限测试入口。GCC 使用 gcc-no-builtins.sh。每个输入预期独立核对，不能抄工具输出。
- `tools/benchmark/prepare_group_primary.py --group <group> --task-dir <WSL 可访问的 Windows 任务目录>`：先核对并复用 positive18 中原生 CN/QCP 测量，只有缺少匹配证据才补测；准备原始通用 VC 和 Candidate 模板。
- 模型计量器：Windows Python `C:/Users/50635/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe -X utf8 C:/Users/50635/Documents/Codex/2026-10-14/jin/work/meter_itp_model_windows.py --task-dir <Windows 任务目录> --attempt N`。模型固定 gpt-6.1-sol。只在 model-receipt.json 已完整写入、进程结束后开始外部编译。
- `tools/benchmark/measure_group_qcp_complete.py --group <group> --task-dir <WSL /mnt/c/... 任务目录> --attempt N`：保留所有历史尝试、失败编译、假设审计，再做独立 coqchk。不可重复覆盖已完成 receipt.json。修复前修改 prompt.txt 反馈实际诊断；Candidate 由已计量模型填写。运行时查询受隔离目录限制，可将所需运行时定义片段放入 prompt，但不能篡改目标或把手工证明冒充模型生成。
- `tools/benchmark/publish_group_evaluation.py --group <group>`、`build_group_cost_tables.py`、`validate_group_evaluation.py --group <group>`：发布四工具和所有阶段的时间/RSS/token，核对完整覆盖、源码/输入/日志/通用 VC/证明哈希。当前通用发布器对 UNKNOWN/ERROR 会拒绝宣告完整；需要先按真实 ITP 证据扩展，不能绕过断言。
- `tools/benchmark/collect_tespec_unexpected.py`：扫描当前组自动结果、正式结果及 read 的完整 ITP 结果，更新专门异常台账。每组跑完即调用，即使未能完成正式验证也要运行。

ITP 按一次执行的全部待处理 VC 独立调用和计量；均值只在实际需要 ITP 的执行上计算，RSS 是每次测得峰值的算术均值，不将批次峰值除以次数。无需 ITP 可记总成本 0，均值和峰值不适用。原生执行、agent 填证、Coq 编译审计、独立内核检查不能混算；共享和复用明确列出。Coq Print Assumptions 必须如实记录，原始目标含 eval_addr_expr 运行时参数时不能宣称 Closed。禁止额外 admit/公理、proof escape 或改目标。

teSpec 专项台账入口 `benchmark/results/tespec-unexpected/README.md`、index.json、index.csv。每条记录包含组/变体/输入/模式/预期/自动与最终状态/源码与 VC 哈希/日志/复现命令/ITP。人工判断写 triage.json，不覆写原始分类。UNKNOWN 与非预期 ERROR 不算成功；read 12 条旧 UNKNOWN 经逐执行内核反证后最终符合预期，单列已解决自动缺口。

每完成一组，更新 manifest、四工具结果、result-cost.md/json/csv、统一索引、docs/benchmark-evaluation-progress.md 和 nightly 状态。审计后仅暂存本任务明确路径，用 git commit --only 避免混入其他线程暂存内容，再 SSH push main。正式证据留在 benchmark/results，工作临时文件放 Windows work/ 或 /tmp。不要清理其他线程文件。

数组组若出现策略解析错误，先确认已传变体 manifest 的 include_dirs；通用主程序准备器现会把显式 include strategies 所需的同字节策略依赖放到组内源码旁，并记录 dependencies.json，适配旧通用验证解析器。有限输入重试不能覆盖旧 run：新建同组新的 run_id，保留每轮实际计划快照。publish_group_evaluation 现支持 prior_tespec_attempt_reports 的实际失败成本，以及完全同源码/harness 的 Fulminate 单次复用。异常台账会把同程序/spec/binds 的后续修正结果关联到原始 ERROR，原始分类不改写。

对于确实依赖运行时数组提取引理的证明，可以按模板第 14 节显式设置 assumption_audit_policy，运行 finalize_group_qcp_runtime_audit.py 复核原始目标类型、既有库引理的假设来源并独立内核检查，输出带依赖限定的证书。只允许已审计 Coq 标准库 functional_extensionality_dep，不能接受任意公理。此脚本适配 IntArray/UIntArray.full_split_to_missing_i。


## array_load 覆盖缺口（01:55）

本组 13 个语言记录包含 read、verify_main 和无参数 main 三类目标。现通用驱动会剥离 CN main，只按全组函数执行；直接套用会漏测客户端。先暂缓，不计完整组；后续需逐配对指定函数、保留客户端断言的 CN 适配器，并明确无参数 main 只有一种语义输入，不能将重复执行冒充多个输入。


## const_example 完整（01:59）

2 个语言记录、7 个合法输入，Fulminate 与 teSpec OFF/ON 全部 7/7 符合预期。QCP 2 个原始全称 VC 全部证明、严格假设审计、独立 coqchk 成功；gpt-6.1-sol 实际调用 1 次、53,629 token。首轮缺少 required values:{} 的 14 次配置 ERROR 和全部重跑成本均保留。只允许将缺少 values 与显式空对象作精确 JSON 规范化比较，不能忽略任何实参、ghost 值或其他字段的变化。

const_example_lessgood 暂缓：原 CN 只有 trusted main，直接 CN verify 不能证明其函数体；且无参数 main 不能伪造多个不同输入。需要明确派生的未信任驱动验证范围，未计为完整。下一组 example_let，逐配对函数名显式记录。


## example_let 有限测试（02:03）

18 个变体记录（32 个 CN/QCP 源文件）、16 个配对配置、136 对变体/输入。逐输入预期 46 PASS、90 FAIL，Fulminate、teSpec OFF、teSpec ON 均 136/136 符合预期。signed 与 unsigned 分别以 doubled/example_let 为入口。主程序 QCP 3 VC，模型 4 次实际调用（第 2 次控制器未成功注入诊断，重复尝试也计入），前 3 次编译失败和一次独立诊断编译全部保留。当前最终证明已编译并通过严格假设审计，正在独立内核检查，尚不提前计完整。


## example_let 完整（2026-10-16 02:06）

当前完整 9/45；累计 413 对变体/合法输入。example_let 的 16 个配对、18 个变体记录（32 个 CN/QCP 文件）、136 对输入，预期 46 PASS、90 FAIL，Fulminate、teSpec OFF/ON 均逐例 136/136。主程序 CN 验证通过；QCP 3 个原始全称 VC 全部编译并独立内核检查成功，1 个全局封闭、2 个仅原运行时地址参数 eval_addr_expr，无新公理。实际 gpt-6.1-sol 4 次调用、264,704 token，包含控制器诊断注入失败造成的重复模型尝试；全部失败编译及诊断成本已计入。QCP 总时间 308.840423 秒、最大单进程 RSS 1767.289063 MiB；四阶段分别保存。当前 teSpec 最终未解决偏差 0，read 自动阶段 12 条经 ITP 解决，另有 30 条配置错误保留并正确关联重跑（16+14）。下一组 Dbl_Linked_List__singleton；array_load 和 const_example_lessgood 的覆盖/可信入口范围缺口不算完成。


## Dbl_Linked_List__singleton 来源兼容性缺口（02:10）

实际运行原 CN 主程序并传入 manifest 的 include_dirs，CN 拒绝原始依赖 list_cn_types.h 中的递归 IntList 引用（Unknown resource predicate IntList）。日志、失败时间/RSS 与 coverage-gap.json 已保存；不改原始快照，不把未跑的有限测试算成功。其余双链表组也使用该头文件，但未以此宣称它们已实测失败。先继续 incr_first；incr 仍在待测队列，未跳过计完成。


## incr_first 完整（2026-10-16 02:14）

完整 10/45，累计 429 对变体/合法输入。incr_first 两个 CN/QCP 配对、4 个来源版本、16 对输入，含无符号回绕和被框架保留的第二个单元边界，Fulminate 与 teSpec OFF/ON 均 16/16。CN 指定主程序整文件验证通过；QCP 原始 8 个全称 VC 一次模型填写全部编译、假设审计并独立内核检查成功，3 个全局封闭、5 个仅原运行时地址参数，未引入新公理。gpt-6.1-sol 实际 1 次、84,524 token，QCP 分阶段总时间 196.071603 秒，最大单进程 RSS 1767.371094 MiB。


## quadruple 完整（2026-10-16 02:18）

完整 11/45，累计 549 对变体/合法输入。quadruple 的 16 个配对、18 个变体记录（32 个 CN/QCP 文件）、120 对输入，预期 46 PASS、74 FAIL；Fulminate、teSpec OFF/ON 均 120/120。包含三个非零 unsigned 2^30 倍数，return-zero 变体在这些掩蔽输入正确 PASS，未把全局错误变体的每个输入都机械标 FAIL。CN 原始整文件（含未标 trusted 的 main）验证通过；QCP 原始 1 个全称 VC 一次模型填写、Coq 编译假设审计全局封闭、独立内核检查成功。实际 gpt-6.1-sol 1 次、54,643 token；QCP 总时间 172.423548 秒、最大单进程 RSS 1998.078125 MiB；分阶段保存。下一组 incr。Dbl_Linked_List__singleton 的来源/工具兼容性拒绝已经保存失败成本、日志和关键依赖哈希，不计完整，也不虚构尚未执行的 teSpec 结果。


## incr 进行中（2026-10-16 02:35）

22 个变体记录、18 个 CN/QCP 配对、103 对测试。独立预期为 28 PASS、63 FAIL、12 明确的执行阶段权限/未初始化读取 ERROR；Fulminate 对这 12 个预期拒绝的原生状态应为 FAIL，工具状态映射在执行前计划中已明确。12 个 teSpec ERROR 还必须匹配 qcp_execution_error、SAT 入口和 cannot read memory 诊断，不能把任意解析/配置错误算检出。Fulminate 实际 97/103：6 个原始 Block 未初始化读取返回 PASS，为漏检；原始状态及未初始化 C 局部变量输入保留，不改预期。

teSpec ON 原生 103/103；OFF 原生 90/103，13 个遗漏出口 ownership 的测试 UNKNOWN。首个执行已完成 2 次实际模型调用（含首轮 entry_sat 编译失败），其入口/出口具体堆辅助事实、两个原始残余 VC 反证、入口 SAT 共 5 个定理全局封闭并独立内核通过，OFF 当前最终 91/103，余下 12 个待独立 ITP。不能复用一次模型成本或一个批次峰值给 13 个执行。

CN 主程序原文件已验证；QCP 原始 2 VC 全称证明、假设审计和独立内核通过，实际 gpt-6.1-sol 1 次、75,692 token。证明阶段成本已保存。整组仍未完整，四工具进行中表和不完整 ITP 成本保持 PENDING，完整进度仍 11/45。

当前 Windows 串行 ITP 控制器 PID 17680、会话 78718。状态文件 /mnt/c/Users/50635/Documents/Codex/2026-10-14/jin/work/incr-itp-per-execution/controller-status.json；启动后先检查和接续，禁止重复发起。工具 cell_leak_itp.py 每次只编译并核查一个执行的全部残余目标；attach_cell_leak_itp.py --group incr --allow-partial 可只导入已经完成的证书。所有完成后去掉 --allow-partial，运行 publish_group_evaluation.py 与 validate_group_evaluation.py。若有失败任务，保留模型/编译日志和成本，记录缺口后继续其他组。


## 串行 ITP 续接检查（02:43）

已核查原控制器 PID 17680 / 会话 78718 正常运行，未重复启动。独立内核通过并审计导入 3/13 次，incr OFF 当前最终 93/103；原生仍是 13 UNKNOWN，专门台账尚有 10 条未解决。新导入执行 01、02 的各次失败模型/编译记录全部保留。整组仍不计完整，ITP 均值/总成本继续 PENDING。等待当前串行任务完成；此期间只准备了 transfer（16 对）和 transpose（24 对）的独立预期计划，没有对其他组启动计量或填造结果。


## 控制器 IO 故障已恢复（02:53）

原 PID 17680 / 会话 78718 在 execution-04 因 WSL 非 UTF-8 输出解码异常退出，3 个已导入和第 4 个已内核通过的证书均保留。已有 execution-04 模型 attempt-1 的实际 88.891 秒、211,444 token 与日志完整，恢复时没有重新请求模型。修复为原始字节日志保存/独立诊断解码，使用 WSL 文件系统读取回执，并在每个新阶段检查 08:00 截止。新 PID 20348 / 会话 95202 接续；execution-04 的 5 个定理已经编译并全局封闭，独立内核检查正在继续。原始故障的 WSL stdout 字节因旧 text reader 解码失败未保留，明确记 UNAVAILABLE，不能编造故障时长；它属于未计入工具进程时间的控制器传输，不宣称含传输开销的端到端总时间。详见组内 controller-failures/20261016-0245-decoding.json。继续时务必检查新 PID / 会话，旧 RUNNING 快照已经失效。

恢复后的 execution-04 原候选已独立内核通过，证明 5 个定理均全局封闭，没有新增模型调用。当前已审计导入 5/13，OFF 最终 95/103，余下 8 条 UNKNOWN。execution-04 的新外层调用原始字节日志已保存；外层 wall 时间包含内层 Coq 过程，与分阶段时间重叠，不能再次相加。整组仍不计完整。


## ITP 串行批次检查点（03:10）

原 v2 控制器继续运行，未启动第二批。已审计导入 8/13 次原始残余 VC 反证及入口 SAT 的独立证书，OFF 最终 98/103；原生仍为 13 UNKNOWN，余下 5 条在专门异常台账中保持未解决。原生与最终状态/匹配数现明确分列，避免把原生 UNKNOWN 写成自动 FAIL。主程序 CN/QCP 与 Fulminate 数据不重跑。slf_quadruple_mem（7 对）和 slf3_basic_inplace_double（52 对）的独立预期计划已准备但未执行，当前组完结前不对它们计量。完整进度仍为 11/45。


## ITP 串行批次检查点（03:13）

原 v2 控制器继续运行，未启动第二批。已审计导入 10/13 次原始残余 VC 反证及入口 SAT 的独立证书，OFF 最终 100/103；原生仍为 13 UNKNOWN，余下 3 条在专门异常台账中保持未解决。原生与最终状态/匹配数现明确分列，避免把原生 UNKNOWN 写成自动 FAIL。主程序 CN/QCP 与 Fulminate 数据不重跑。slf_quadruple_mem（7 对）和 slf3_basic_inplace_double（52 对）的独立预期计划已准备但未执行，当前组完结前不对它们计量。完整进度仍为 11/45。


incr 完整收尾：22 个变体记录、36 个语言文件、103 对合法输入。主程序 CN 验证、QCP 原始 2 个全称 VC、Coq 假设审计和独立内核检查完成；13 个 OFF 原生 UNKNOWN 分别独立 ITP 反证并核查全部残余目标，保留所有模型和修复成本。OFF 原生 90/103、含 ITP 最终 103/103；ON 原生 103/103；Fulminate 97/103，6 个 Block 未初始化读取漏检单列保留。四工具分阶段时间、RSS、实际 token 和逐次 ITP 均值已汇总。完整进度 12/45，下一组 transfer。


transfer 完整收尾：16 对输入，Fulminate、teSpec OFF/ON 均逐例匹配独立预期；主程序 CN 与 QCP 2 个原始全称 VC 已编译、假设审计并独立内核检查。gpt-6.1-sol 实际 1 次调用，75,824 token；四工具分阶段时间与 RSS 已保存。完整进度 13/45，下一组 transpose。


transpose 完整收尾：24 对输入，Fulminate、teSpec OFF/ON 均逐例匹配独立预期；主程序 CN 与 QCP 1 个原始全称 VC 已编译、假设审计并独立内核检查。gpt-6.1-sol 实际 1 次调用，54,786 token；四工具分阶段时间与 RSS 已保存。完整进度 14/45，下一组 slf_quadruple_mem。

slf_quadruple_mem 当前进程会话 93520：原生 7 对有限输入三工具全部匹配，CN 主程序原文件已验证，QCP 原始 3 VC 已冻结。Windows 实际 gpt-6.1-sol 填写任务 /mnt/c/Users/50635/Documents/Codex/2026-10-14/jin/work/slf_quadruple_mem-qcp-metered 正在运行；先检查该会话/attempt-1/model-receipt.json，完成后调用 measure_group_qcp_complete.py --group slf_quadruple_mem --task-dir 同目录 --attempt 1，勿重复模型调用。init_point 六个合法未初始化区域位置输入计划已经准备但未执行。

slf_quadruple_mem actual attempt-1 已完成：28.891 秒，55,340 token。3 个全称 VC 已编译且假设审计完成；独立 coqchk 正在会话 36999 运行。先接续该会话，成功后可用已审阅的 /mnt/c/Users/50635/Documents/Codex/2026-10-14/jin/work/finish-simple-nightly-group.py --group slf_quadruple_mem --next init_point 汇总/验证/提交，再 SSH push。不要再调用模型或启动重复内核检查。


slf_quadruple_mem 完整收尾：7 对输入，Fulminate、teSpec OFF/ON 均逐例匹配独立预期；主程序 CN 与 QCP 3 个原始全称 VC 已编译、假设审计并独立内核检查。gpt-6.1-sol 实际 1 次调用，55,340 token；四工具分阶段时间与 RSS 已保存。完整进度 15/45，下一组 init_point。

03:42 WSL 无需重启即恢复。init_point attempt-1 Candidate 编译退出 137，GNU time 为 326.24 秒、10,949,176 KiB RSS；控制器 wall 326.259906905 秒。未取得 guest OOM 日志，不把 SIGKILL/OOM 具体原因当作已证事实。原模型 117,282 token 和失败编译均保留，后续证明改为交换堆见证的逐点 join 构造。attempt-2 仅有未限定 ConAssertion 命名空间编译错误，实际模型/编译成本同样保留。新的 Coq 超时与地址空间限制已用真实子进程检查，编译失败/超时/RSS 均可正确留存，检查成本单列不混入程序成本。


init_point 完整收尾：6 对输入，Fulminate、teSpec OFF/ON 均逐例匹配独立预期；主程序 CN 与 QCP 5 个原始全称 VC 已编译、假设审计并独立内核检查。gpt-6.1-sol 实际 3 次调用，289,725 token；四工具分阶段时间与 RSS 已保存。完整进度 16/45，下一组 swap。

03:48 补充：只读取得内核日志，03:39:54 的 coqc OOM kill 已确认并保存 SHA，详见 init_point/20261016-qcp-verify-complete/kernel-coqc-oom.raw.log。最终 QCP 的 592.255846108 秒、10,692.5546875 MiB 峰值包含全部失败尝试，不用成功重试的较小成本覆盖它。新的 proof prompt 加入实际 ConAssertion 命名空间及逐点 join 定义，避免再次因缺上下文而搜索具体堆。


swap 完整收尾：10 对输入，Fulminate、teSpec OFF/ON 均逐例匹配独立预期；主程序 CN 与 QCP 1 个原始全称 VC 已编译、假设审计并独立内核检查。gpt-6.1-sol 实际 1 次调用，53,655 token；四工具分阶段时间与 RSS 已保存。完整进度 17/45，下一组 slf3_basic_inplace_double。

slf3_basic_inplace_double 原生全部 52 对输入已执行：Fulminate 52/52、teSpec ON 52/52、OFF 50/52，2 个缺失出口 ownership 的 UNKNOWN 已保留原始状态并写入异常台账；所有已有 9 个变体记录、16 个语言文件均覆盖。主程序 CN 通过，QCP 2 原始 VC 已编译审计，独立内核检查会话 36556。实际模型 1 次、55,440 token。两次独立 ITP 已准备，串行控制器 PID 32952 / 会话 51150 已启动并等待主程序内核成功，不能重复启动；状态 work/slf3_basic_inplace_double-itp-per-execution/controller-status.json。后续先接续这两个现有会话，controller DONE 后 attach_cell_leak_itp.py --group slf3_basic_inplace_double，再 publish_group_evaluation.py / validate_group_evaluation.py 并归档 controller-invocations。全部修复成本和各执行峰值均单独保留。该组尚未完整，当前 17/45。

slf3_basic_inplace_double 主程序 QCP 已独立内核通过，完整全称证明 162.712244425 秒、55,440 token、1979.03125 MiB 单进程峰值。串行 ITP 控制器已解除等待，实际开始 execution-00 的模型调用。原生报告已冻结为 results.native-before-itp.json 并锁定 SHA 后再更新汇总；2 个 UNKNOWN 仍为待处理，不能算成功。当前活跃会话为 51150，PID 32952；不要接续已结束的 primary 会话 36556 或重复启动模型。

slf3_basic_inplace_double：2 次原始 UNKNOWN 现已分别完成全部残余 VC 反证、入口 SAT、5 定理全局封闭及独立内核检查。OFF 原生仍是 50/52，含 ITP 最终 52/52；ON 原生和 Fulminate 都是 52/52。ITP 成本按这两次执行的实际模型/编译/内核阶段和逐次峰值平均单列，原始 UNKNOWN 不改写。


slf3_basic_inplace_double 完整收尾：52 对输入，Fulminate、teSpec OFF/ON 均逐例匹配独立预期；主程序 CN 与 QCP 2 个原始全称 VC 已编译、假设审计并独立内核检查。gpt-6.1-sol 实际 1 次调用，55,440 token；四工具分阶段时间与 RSS 已保存。完整进度 18/45，下一组 incr_two。

incr_two 已覆盖全部 12 个变体记录和 40 对输入，主程序 CN 验证及 QCP 7 个原始全称 VC、审计、独立内核均完成；实际 1 次模型、110,316 token。Fulminate 40/40，teSpec OFF/ON 各 38/40。错误别名调用的 2 输入 × 2 模式均为 contract_binding_unknown，执行安全/出口 PASS，但 annotations UNKNOWN；residual_vcs=[]、raw manual_obligation_count=0。它是未导出检查目标的契约绑定缺口，不能通过仅证明现有 body VC 来补成成功。4 条原始状态、两模式、日志/源/VC 哈希与 ITP 未执行原因已存 triage.json / coverage-gap.json。整组仍不完整，主程序证明成本齐备而测试 ITP 为 PENDING；按照夜间难例策略先继续 zero。完整进度保持 18/45。

zero 原生评测已覆盖 11 个变体记录、18 个语言文件、46 对合法输入。未初始化存储的输入变化为合法区域位置，不虚构可控初始标量。ON 46/46，OFF 原生 44/46，两条 no-op 后缺少已初始化零值的 UNKNOWN；Fulminate 44/46，两条未初始化 no-op 被报 PASS（漏检）；运行时未检出初始化状态的具体原因仍待审计，预期不改。QCP 主程序 2 VC 已编译审计，独立内核会话 75366。两次 ITP 模板用原始残余 VC 和真正四字节 Noninit 堆定义，入口 undef、出口零值不成立、两原始 VC 反证、入口 SAT 共五个定理全部交由实际 CLI 模型填写；没有预填输入特定反证。通用旧堆工具仅保留首个输入特定 refutation 之前的辅助事实。新 prepare_zero_noop_itp.py 保存模型模板和源/绑定/VC 锁。串行控制器 PID 11360 / 会话 45668 已启动，等待主程序内核成功；不能再启动控制器。快照已 attach --allow-partial 冻结，下一步先检查现有会话，kernel 完成后 publish_group_partial 可展示进行中表。最终 Fulminate 的 2 个漏检必须保留，不能写成三工具全对。当前完整进度仍 18/45，incr_two 的 4 条契约绑定 UNKNOWN 暂留缺口。

zero 主程序 QCP 已独立内核通过：2 原始 VC，1 次实际模型，54,264 token，完整 154.613088575 秒，1767.86328125 MiB 峰值；主程序 CN 同样通过。现仅串行 ITP 会话 45668 / PID 11360 继续执行，primary 会话 75366 已结束。attach 的原生快照已锁定，模板五定理不变；最终需证明两个原始残余目标并核查入口 SAT。完成后先 attach_cell_leak_itp.py --group zero，再 publish_group_evaluation.py 和 validate_group_evaluation.py，保存 controller-invocations，并保留 Fulminate 44/46 的两条漏检。通用 scratch finish-simple-nightly-group.py 已去掉“三工具全部匹配”固定表述，可使用但下一组需先选好；current_controller 完成后移到 previous_controller。

zero：2 次原始 UNKNOWN 现已分别完成全部残余 VC 反证、入口 SAT、5 定理全局封闭及独立内核检查。OFF 原生仍是 44/46，含 ITP 最终 46/46；ON 原生 46/46，Fulminate 44/46，两条未初始化 no-op 漏检保留。ITP 成本按这两次执行的实际模型/编译/内核阶段和逐次峰值平均单列，原始 UNKNOWN 不改写。


zero 完整收尾：46 对输入，完整逐例预期与原始／最终分类已归档；主程序 CN 与 QCP 2 个原始全称 VC 已编译、假设审计并独立内核检查。gpt-6.1-sol 实际 1 次调用，54,264 token；四工具分阶段时间与 RSS 已保存。完整进度 19/45，下一组 swap_array。


swap_array 完整收尾：20 对输入，完整逐例预期与原始／最终分类已归档；主程序 CN 与 QCP 5 个原始全称 VC 已编译、假设审计并独立内核检查。gpt-6.1-sol 实际 2 次调用，196,860 token；四工具分阶段时间与 RSS 已保存。完整进度 20/45，下一组 ref。

swap_array 收尾审计：20 个逻辑输入每个模式均有首轮缺头文件 ERROR 和修正后 PASS，共计每模式 40 次实际 teSpec 尝试；统计已逐项核对为两轮之和及逐输入最大 RSS。Fulminate 复用 exact-source / exact-harness 原始测量一次，未重复运行/重复计费。首轮 40 条配置 ERROR 保留且分类 RESOLVED_CONFIGURATION_ERROR。QCP 5 原始 VC 已实现 VC_Correct，2 次实际模型共 196,860 token、失败编译与原始目标/库假设审计成本全部计入；总验证 237.054294732 秒、2033.03125 MiB 峰值。结论明确限定为 VERIFIED_KERNEL_CHECKED_WITH_RUNTIME_LIBRARY_ASSUMPTIONS：原目标自带 4 个 sizeof 参数，加原有 IntArray.full_split_to_missing_i 使用的标准函数外延性；没有新声明证明公理，不能写 globally closed。完整进度 20/45。ref 的 6 个现有语言变体、24 个合法标量/框架输入计划已独立准备，尚未执行。

ref 已测全部 6 个变体记录、24 对合法输入；Fulminate 24/24（返回分配在目标规约监测后由客户释放），teSpec OFF/ON 各 0/24：均入口 SAT，遇仅有声明的 mallocUnsignedInt 后 missing_function_body、execution_completed=false、residual_vcs=[]。48 条运行模式结果已逐例专项记录和 triage，原始 UNKNOWN 不改写。没有完整执行或原始残余目标，不能用主程序全称证明代替测试 ITP，也没有编造模型/内核零成本。主程序 CN 与 QCP 2 原始 VC、所有实际修复、假设审计与独立内核检查均完成；整组仍不完整、测试 ITP PENDING。按难例策略继续 ref_greater，已准备 8 个现有记录、30 对合法输入但尚未执行。完整进度仍 20/45。

ref_greater 已跑 8 现有记录、30 合法输入；Fulminate 30/30，OFF/ON 各 30 UNKNOWN（入口 SAT，mallocUnsignedInt 无函数体、执行未完成、无残余目标）。另一次原模块 CN 验证实际失败：未 trusted 的 main 没有释放返回的 RW<unsigned int>，报 Left-over unused resource；这不是目标函数的反例，QCP 翻译本来也不含该 main，不能混淆验证范围。保留 CN 失败时间/RSS/日志/源哈希，QCP 未运行和测试 ITP 缺目标均为 PENDING，不填零。60 条工具缺口逐例 triage；保持预期 PASS。先继续 init_array，完整进度仍 20/45。

init_array 计划已准备 6 记录/18 合法长度输入（前向允许 0，反向 n>0），原规约只保证初始化 ownership，不把实际零化的参考值冒称为已验证的更强后置条件。反向原 QCP 含旧 benchmark/selection 的绝对策略定位；新增 with_legacy_strategy_locator.py 保留源/策略字节与哈希，临时创建旧定位文件，子进程退出后清理，仅组下 dependencies 留存规范副本。成功与失败子进程的清理均已实际检查，benchmark/selection 不残留；每条测量命令包含该 wrapper，重现不依赖未记录的常驻别名。wrapper/策略哈希随结果保存并在发布、审计时核对。

init_array：全部 6 语言变体、18 合法输入已实跑。Fulminate 18/18，teSpec OFF/ON 各 6 PASS、12 UNKNOWN；24 个模式执行均入口 SAT、执行完成并存在真实残余 VC，属于正例证明自动化缺口，逐执行正向 ITP 尚待完成，不计通过。主 CN 通过；当前 QCP 在 repeat_Z 0 0 = nil 的有效初始不变量处 Partial Solve Invariant Error，原配置与 --full-auto 两次实际时间/RSS 都保留。同一源哈希的历史六 VC 完整证书与目标文件已逐一复核 SHA256，保留其历史有效性；历史阶段成本缺失和本轮未重放均不填零。反向数组的旧绝对策略路径由逐次命令记录的临时只读兼容文件解析，策略内容哈希锁定，结束后移除兼容路径，原程序不改。完整组仍 20/45，转下一组。

ref_greater 的 QCP 主程序现已独立尝试生成（不再受 CN client 失败阻断）：当前生成器不能建立传给 refUnsignedInt 的 unsigned_last_nbits(n0+1,32) 取值范围，停止于调用前置检查，没有完整 VC 模块。新增实际失败时间/RSS/命令/日志均已保存，未调用证明模型，不捏造完整证明或零成本；与前述缺少分配器函数体的逐输入测试问题分列。

slf17_get_and_free 已跑全部现有变体、12 组合法输入：Fulminate 12/12，teSpec OFF/ON 各 12 UNKNOWN（入口 SAT，外部 free 无函数体，执行未完成、无原始残余目标）。原 CN 因外部接口没有规约而拒绝，失败时间/RSS 单列。QCP 主程序独立完成 5 个原始全称 VC、编译与假设审计及完整 coqchk；所有 gpt-6.1-sol 尝试都计入成本，验证证书不替代测试执行。假设限定见 receipt；不声称全部全局闭合。该组仍不完整，完整进度保持 20/45。


slf18_two_dice 已跑全部现有变体、14 组合法输入：Fulminate 14/14，teSpec OFF/ON 各 14 UNKNOWN（入口 SAT，外部 rand 无函数体，执行未完成、无原始残余目标）。原 CN 因外部接口没有规约而拒绝，失败时间/RSS 单列。QCP 主程序独立完成 11 个原始全称 VC、编译与假设审计及完整 coqchk；所有 gpt-6.1-sol 尝试都计入成本，验证证书不替代测试执行。假设限定见 receipt；不声称全部全局闭合。该组仍不完整，完整进度保持 20/45。

init_array 的首个正向逐执行 ITP 已实际完成：未初始化前向数组 n=0、OFF 的两个原始残余 VC 全部证明、编译、原始语句参数对照审计及独立 coqchk 通过。原始 UNKNOWN 保留，最终追加 PASS；没有新增证明公理，原 VC 内的 sizeof_* 类型参数如实披露。另 23 个模式执行的独立任务已冻结，由 PID19472/session16301 串行控制器继续实际 gpt-6.1-sol、所有修复、编译审计和内核计量；首个任务的三个审计诊断调用也计入真实时间/RSS。完整组仍20/45，当前已扫描26组，不能把已有同源历史证明或未执行完的外部调用算成完整组。

init_array 空间 SMT 门控已逐例核实：12 个原生 UNKNOWN 的 ON 执行均入口 SAT、scope=execution、执行完成、返回码0、无执行器错误，但包含 loop-invariant 抽象事件；spectest/spatial_smt.py 的资格检查因此返回 original_execution_not_eligible，attempted=0。不是已经送进空间 SMT 后超时/无法编码/返回 UNKNOWN，不能宣称 ON 已尝试这些目标。门控避免把抽象路径误作具体反例，不能盲目删除；后续应先证明抽象义务并建立原始 VC ID 的完整覆盖，再决定可细化范围。本轮仅记录，没有修改执行器或空间 SMT 逻辑。已完成的正向 ITP 则证明本次全部原始残余目标后才追加 PASS。

init_array 正向 ITP 推进到8/24（前向 n=0/1/2/3，OFF/ON 各一份独立编译、假设审计与完整 coqchk）。n=2 OFF 第3次实际模型修复完成8目标；n=3 ON 第2次完成10目标，新增依赖仅为已审计原库 join_assoc 的标准函数外延性，原 sizeof_* 类型参数另列，未新增本地公理，不声称全局封闭。n=2 ON 的第3次候选虽编译通过，但额外依赖 propositional_extensionality，已拒绝且计费；第4次实际 CLI 审阅复用了 n=2 OFF 的整个同哈希原 VC 已检查证书。n=3 OFF 第3次同样显式复用同哈希 ON 证书。两次均保留源码／binds／整个原 VC／原证书／证明哈希，并在新执行中独立重跑全部目标编译、原始语句和库假设审计、完整内核检查，标注 EXACT_GOAL_CERTIFICATE_REUSE_REPAIR，不能描述成从零独立搜索。所有实际失败模型、额外 Show/Abort 诊断编译、库假设诊断和被拒绝候选均保存在逐执行记录，原 UNKNOWN 不改写。完整进度20/45未变，主程序当前生成器问题仍单列。原串行控制器继续其余队列；controller.json 中 deferred 是最初两次尝试的历史事件，当前已解决／未解决以 positive ITP index.json 和模式统计为准。

init_array 反向数组 n=1、OFF 的正向逐执行证书已完成：两次实际模型尝试后，全部原始残余 VC 经编译、原始语句/库假设审计和完整独立 coqchk 通过。现有已核验逐执行证书9/24，原始 UNKNOWN 保留；其余失败或执行中任务不计成功。模式对照 comparison.md 现由实际索引和统计刷新，避免继续显示全部未证明的旧文字。整体完整20/45未变，原串行进程继续。

succ_using_incr 已实跑全部7个CN/QCP记录、19对输入：两个正确翻译及泄漏版本各6个合法无符号数（含回绕），原始空main仅1个真实入口。Fulminate13 PASS、6 FAIL，19/19符合预期；OFF/ON各1 PASS、18 UNKNOWN，含6个应拒绝的泄漏输入，不能计作成功检出。36个模式异常均入口SAT，在缺失allocator函数体处停止、无原始残余目标，逐例记录ITP无法执行的原因。主CN因cn_free_sized无规约而拒绝；QCP实际生成13原始全称VC但证明/审计/独立内核阶段仍PENDING，不冒称验证通过。轻量原生测量与已存在init_array队列的共享负载已披露。完整20/45，实际扫描27组。
