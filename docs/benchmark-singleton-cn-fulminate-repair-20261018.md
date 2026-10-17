# singleton：CN 与 Fulminate 修复（2026-10-18）

本轮仅处理 Dbl_Linked_List__singleton 的 CN/Fulminate。CN 主模块验证通过，Fulminate 原有 7 个合法输入全部 PASS。teSpec 缺分配器执行体，按用户要求暂缓，本轮没有启动 teSpec 或 ITP；整组仍未完成，完整组数保持 **21/45**。

## 改了什么

原 singleton.c 与归档源逐字相同（SHA-256 31d11a4545cd075da4308cb8d32282105f18bbb307b00cbe569d22d105714772）。QCP 源、原始 4 VC 证书及统计未改，原归档头文件也未改。7 个输入仍为 INT_MIN、-100、-1、0、1、5、INT_MAX，预期均为 PASS。

在组内 compat/cn-5.2/ 保存独立的依赖适配层：

- IntList、Own_Forwards、Own_Backwards 标记 [rec]，后两者在使用它们的 Dll_at 之前声明；谓词正文保持原意。
- 当前锁定 CN 5.2 用逻辑 integer 表示 C int，旧库的 seq.head、hd 和 snoc 的 i32 标注迁为 integer，0i32 改为 0。C 类型、程序和 singleton 后置条件不变；测试 main 的返回零标注作同样适配。
- C 整数参数、已初始化堆字段及写入仍受 CN 的可表示范围检查。这里只声明合法 C int 堆与 singleton 的语义保持；任意超出 C int 范围的独立 ghost 序列不与旧 i32 域等价。以后复用该层验证带 ghost 算术的程序，须另审溢出/范围，不能无条件推广。
- allocator-runtime.c 使用已安装 Fulminate 运行库的 cn_malloc、cn_free_sized，保留分配/释放的运行时权限跟踪；分配失败则 abort，以对应原先非空 allocator 契约。节点和 int_list 的四个接口用于完整链接。未复制验证器或运行库实现。
- gcc-with-runtime.sh 仅在链接时加入包装器，保留 -fno-builtin；标准评测入口支持计划中显式声明并校验 SHA-256 的 wrapper，其他组沿用原默认值。变体 manifest 的当前 include 路径指向兼容层，旧路径作为来源记录保留。

完整依赖变化、原/新哈希及运行支持哈希见 [兼容层清单](../benchmark/programs/Dbl_Linked_List__singleton/compat/cn-5.2/manifest.json)。

## 结果与证据边界

CN 命令没有 trusted、--skip 或 --only；完整日志显示 IntList_nil、IntList_cons、singleton 三项 pass。发布状态为 VERIFIED_WITH_COMPAT_HEADERS。它仍假设原外部 malloc_node/free_node 契约，**没有形式证明 allocator-runtime.c**。QCP 旧证书也保留同样的分配器契约前提。

Fulminate 对 7 个原输入均完成插桩、编译和实际运行，随后各单独运行一次，全部 PASS。额外负控仅将赋值改为 n->data = element + 1，输入 5、后置条件不改，pipeline 与单独运行均退出 2。生成 C 中 cn_assert(struct_Dll_equality(Ret_cn, a_800), POST) 检出数据 6 不等于预期 5。日志 511 行是前面保存的错误上下文位置，真正断言在生成 C 的 525 行；不是分配失败。负控属于诊断，不增加正式变体/输入数量。

teSpec 历史 OFF/ON 各 7 UNKNOWN 保留，执行在 malloc_node 无函数体处中止，尚无可交给 ITP 的残余 VC。旧统计中“需 ITP 7 次”是通用 UNKNOWN 计数，本例应解释为执行能力阻塞，不能将无残余目标当作无需证明而完成。修复本轮 teSpec 新执行数为 0；没有改测试预期来配合结果。

## 成本

主成功 CN：0.265700 秒，最大进程 RSS 45.980469 MiB。
Fulminate 正式 7 次 pipeline 合计 2.258146 秒、最大进程 RSS 45.687500 MiB；7 次单独测试合计 0.025194 秒、最大进程 RSS 1.113281 MiB。

instrument --run 的 pipeline 包含插桩、编译和首次执行；单独 test 是另一次执行，不能把 pipeline 称作纯生成时间。原生阶段无模型调用，tokens 为 0。本轮没有证明 agent 调用；开发会话成本不冒充 gpt-6.1-sol CLI 证明计量。

初次 CN 整数类型失败、初次链接包装器失败、成功先导输入和负控都单列；同时保留旧 CN/Fulminate 失败和前轮原生复查成本。不会用成功样本覆盖失败记录，也不把诊断算成第 8 个正式测试。见 [完整结果成本表](../benchmark/results/Dbl_Linked_List__singleton/result-cost.md) 和 [补充成本](../benchmark/results/Dbl_Linked_List__singleton/supplementary-costs.json)。

## 复现

在 /home/yangfp/teSpec 中使用锁定工具链，tools/benchmark/cn_toolchain.py 的 installed_identity() 会校验二进制及运行库。下面的 Python 只复跑 CN/Fulminate，输出目录必须全新；每个阶段仍保存实际计量。

    from pathlib import Path
    import sys, json
    sys.path.insert(0, "tools/benchmark")
    from cn_toolchain import CN, installed_identity
    from test_read_variants import measure, save
    from test_group_variants import compiler_wrapper

    R = Path.cwd()
    G = R / "benchmark/programs/Dbl_Linked_List__singleton"
    O = R / "benchmark/results/Dbl_Linked_List__singleton/NEW-RUN-ID"
    O.mkdir(exist_ok=False)
    save(O / "toolchain.json", installed_identity())
    plan = json.loads((G / "evaluation-plan.json").read_text())
    wrapper = compiler_wrapper(plan)
    inc = "-I" + str(G / "compat/cn-5.2/Dbl_Linked_List")
    source = G / "variants/cn_original_Dbl_Linked_List__singleton/cn/singleton.c"
    save(O / "cn.json", measure([CN, "verify", inc, source], O / "cn", timeout=90))
    for i in range(7):
        harness = G / f"variants/cn_original_Dbl_Linked_List__singleton/tests/20261018-cn52/element_{i}/fulminate.cn.c"
        dest = O / f"element_{i}"
        generated = dest / "generated"
        generated.mkdir(parents=True)
        pipeline = measure([CN, "instrument", "--run", "--cc=" + str(wrapper),
                            "--output-dir=" + str(generated), inc, harness],
                           dest / "pipeline", timeout=90)
        save(dest / "pipeline.json", pipeline)
        binaries = list(generated.glob("*.exec.out"))
        if len(binaries) == 1:
            save(dest / "test.json", measure([binaries[0]], dest / "test", timeout=30))

正式新记录在 [finite-results.json](../benchmark/results/Dbl_Linked_List__singleton/20261018-cn-fulminate-repair/finite-results.json)，含精确命令、工具链、源/生成 C/二进制哈希。原生成 C 和日志保留；可重建 .exec.o/.exec.out 清理后不提交，记录清理前哈希。前两次失败时使用的旧适配头文件/链接包装器另有快照，回放失败须选对应快照，不能用最终兼容层解释早期失败命令。
