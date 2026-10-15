# 2026-10-16 夜间逐组评测

用户要求今晚继续争取完成 45 组，并对 teSpec 不符合预期的结果专门记录。当前线程已启用夜间续跑，automation id 为 `tespec-benchmark-45`，约每 10 分钟触发一次接续；北京时间 2026-10-16 08:00 截止，到时停止本次夜间心跳并报告真实完成量。电脑与 Codex 必须保持运行。只在出现完成组、重要异常、阻塞或截止时通知。

唯一仓库 `/home/yangfp/teSpec`、唯一 main 分支、禁止新工作树。并行论文修改不混入本任务提交。SSH push main，sac 不 push。执行器和 SMT 引擎实现源码不得提交到此仓库。每次只测一组，正式计量期间避免同时跑其他组的负载。

先读 `benchmark/results/group-result-cost-index.json` 决定哪些组已经完整。查看 `benchmark/results/nightly-20261016/status.json` 当前在做哪一步；若进程仍运行，接续进程而非重复启动。当前 add 的 122 对测试已运行，主程序两条通用 VC 已编译并正在独立内核复查。下一组 add_read。难例保留完整缺项与 teSpec 异常后继续其他组；不能将失败、UNKNOWN 或欠缺成本的组标为完整。

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
