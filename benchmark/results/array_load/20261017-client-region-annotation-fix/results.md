# array_client_region 单例注解修订与重测

仅修改 `qcp_existing:3f5666557099c82f3a7f` 的 `verify_main` 六条 Assert：删除六个重复的 `data_at(&a,int*,a)`，并删除对应值断言中的 `&zero`、`&one`、`&two` 三项。其余显式局部槽、六条值/数组断言、C 实现、Require/Ensure、输入和预期 PASS 均保留。

QCP 的 addressable 注解转换会为裸变量读取加入局部槽；本例随后显式写同址槽，导致重复所有权要求。原始执行状态并未丢失这些资源。此修订不修改执行器、空间 SMT 或 sac。

测试输入仍为 `a=4096`，完整数组 `[0,1,2]`；只运行 `original_client_translation5_only_entry`，没有运行其他配对或变体。

| 空间 SMT | 旧源码结果 | 修订源码结果 | VC | 原生执行时间（秒） | 最大进程 RSS（MiB） | 原生执行 token |
|---|---|---|---|---:|---:|---:|
| OFF | UNKNOWN | PASS | 19 VALID，0 残余 | 0.617361 | 19.519531 | 0 |
| ON | UNKNOWN | PASS | 19 VALID，0 残余 | 0.164579 | 19.527344 | 0 |

两模式均自动完成，不需要测试 ITP。上述 PASS 为原生自动判定，证据仍是 NOT_CHECKED，不能描述为新增的独立 Coq 内核证书。OFF 已能自动通过；ON 不代表空间 SMT 实际处理了原先那些错误目标。时间包含原生 CLI 运行，每模式仅一次、共享主机，不能据此比较模式速度。

旧评测、原始 VC 和日志保持不变。本次按新源码哈希单独保存；旧 67 对整组结果仍代表旧批次，不能充当新源码完整重测。本次没有进行 CN/Fulminate 重测或主程序全称验证，也没有将整个 array_load 家族标记为完成。

旧源码 SHA256：`3f5666557099c82f3a7f7ec49dea941cafe683e1303a842282d546976a730157`

新源码 SHA256：`690f5f3abab59ad1fbbdda2794fd9470003b662c44f987ff32de28297f8c2d66`

执行器 SHA256：`f50c532f32192803ab6bbdf8620c883579debfb75c291b1ed8a3f1e0fdf2691e`

机器回执见 `results.json`，逐模式成本见 `results.csv`，原始报告与 stdout/stderr 保存在 `tespec-off/`、`tespec-on/`，修改前后源码分别保存在 `source-before.qcp.c`、`source-after.qcp.c`。`replay.py` 保存实际调用过程，并拒绝覆盖已存在的测量。
