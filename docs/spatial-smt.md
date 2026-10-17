# 可选空间 SMT 后端

teSpec 的 `run`、`check` 和 `run_job` 支持显式开启有限空间 VC 编码。
默认关闭；不开启时不加载 Python Z3、不改变执行器命令、判定或 ITP VC 输出。

```sh
python3 -m pip install -e '.[spatial-smt]'
python3 -m spectest run sample.c --function read --binds binds.json --spatial-smt
python3 -m spectest check job.json --spatial-smt --spatial-smt-timeout-ms 2000
python3 -m spectest check job.json --no-spatial-smt
```

保存的 job 可在 `qcp` 中设置 `"spatial_smt": true` 和
`"spatial_smt_timeout_ms": 2000`。CLI 显式开关覆盖 job；超时参数自身不启用后端。
超时范围是 1–60000 毫秒，预算针对每个 SMT 查询，非整个进程。
`run_job(..., spatial_smt=True)` 同样可用。

## 调用与判定

`run_job → 原生执行器 → 原始 JSON / Coq VC → 可选空间 SMT → 报告与 ITP 任务`。
目前是主运行流程中的执行后判定阶段，尚未接管原生执行器内部的分支、循环和调用判定。
不尝试恢复被循环上限、调用上限、读取权限错误或其他错误中断的执行。

仅处理已完成、前条件 SAT、没有执行错误或限制的执行中尚为 UNKNOWN 的 VC。
原有 return 路径保持不变。新增路径只允许 `inline-preserve/v1`、`copy-only/v1`、
`all-boundaries` / `check-preserve` 下的具体断言检查：事件须为本函数的
`annotation-check`，或数量相符的 `inline-call` / `contract-check`。
未知事件、摘要调用、循环抽象、跨函数注解和执行中断仍保留 UNKNOWN。

编码器接收 return 的 exact-heap 语义；entailment 只有在上述协议与原始义务组
覆盖检查成立后，由适配层显式指定 exact。不会根据一个 VC 的 kind 猜测 frame 模式。
支持 `store`、`has_permission`、具体长度内置数组 `full` / `undef_full` / `seg`，
以及有限 `missing_i`。后者按库定义拆为缺失索引前后的数组段，要求完整列表长度
与范围一致且 `lo <= i < hi`；未知长度、未知索引或越界保留 UNKNOWN。

非空 LOCAL 只接受每侧无重名的 `Temp name expression`：每个目标绑定都必须在
每个前件分支中具有同名同表达式，表达式不得依赖局部存在变量。所有绑定都保留
为环境符号与逻辑表达式的纯等式；新增/变更目标绑定、影子变量歧义和符号冲突
拒绝导入，不丢弃 SEP 中的真实存储资源。64 位 PtrArray 尚未建立与当前库固定
步长一致的解释，保留 UNKNOWN；普通 64 位指针单元不受此限制。

递归谓词、自定义函数、不支持的布局、缺少依赖、异常、超时均保留 ITP 后备。

- SAT 反例对应 INVALID VC，并按原有路径 VC 合取语义使该测试 FAIL。
- 所有原始 VC 都 VALID，且执行完整、各阶段通过、原始 manual 清单和 witness 覆盖一致，才允许 PASS。
- 新断言路径仅接受单函数、无命名分支后缀且来源行无歧义的 return/entailment 义务组。
  manual 条目、UNKNOWN 记录和 witness 的 total/manual/auto 计数须严格一致。
  原始记录可能去重、manual 分支可能聚合；不一致时保留 UNKNOWN，不放宽为集合包含。
- 原始 Coq 文件的目标定义、manual 声明、模块接口和 residual 清单必须完整对应，
  同时核对不可变文件哈希、案例 ID、函数、生成源码和三方布局。不能关联的额外义务保留 ITP。
- 只证明部分 VC 不足以产生 PASS；无法关联的额外 Coq 义务仍交给 ITP。

## 产物与证据

原始 `executor.json`、`vc/*.v`、`vc/manifest.json` 和 `residual_vcs` 保留作为证书输入，
不会生成伪造的 Coq 证明或把 SMT 结果标为内核检查通过。
`annotation_artifact_binding` 记录的是原始义务组覆盖，不是猜测的逐 VC→lemma 映射。
部分生成的根目标为“原始 VC 或策略化 VC”，`split_goal_*` 是另一证明路径的辅助引理；
原始 VC 被 SMT 判 VALID 可以使本次测试无需 ITP，但不代表这些辅助引理已逐个获证。
`report.json` 中 `vc_results` 表示经过可选后端判定后的 VC 状态，附带原始状态和证据路径。
`spatial_smt.original_status` 保存进入后端前的测试分类。

每个候选测试的 `artifacts/<id>/spatial-smt/` 保存原始 VC、规范化编码、SMT-LIB、
反例堆、判定、查询哈希和耗时。`certificate` 保持 `NOT_CHECKED`。
报告顶层 `itp_vcs` 是待处理列表；已判定且覆盖完整的组无需 ITP，
未判定或无法关联的组继续使用原始 manifest。
旧 `vc.residual_goals` 是执行器原始记录，不等同于开启后端后的待办列表。

## 测试位置

- 主流程集成回归：`tests/test_spatial_smt.py`。
- 编码模块单元测试：`tools/finite_spatial_smt/test_*.py`，包括通用 missing_i 和 LOCAL 的正反例。
- 已完成组实际回归：`tools/finite_spatial_smt/regress_completed_groups.py`，读取发布的基线并
  在全新目录实际执行 OFF/ON，不覆盖旧源、预期或证据。旧 UNKNOWN 的新判定对照既有 ITP，
  不把旧 Coq 证书搬给新执行；空间 SMT 结果仍为 `NOT_CHECKED`。
- 2026-10-18 接入结果：见 `benchmark/results/spatial-smt-regressions/`；首轮 array_load
  两客户端先导实验另存 `benchmark/results/spatial-smt-integration/20261018-array-load-pilot/`。
- 2026-10-18 接入与验证说明：[中间断言与有限数组接入](spatial-smt-annotation-array-integration-20261018.md)。
- 初次 return 接入测试：`tools/finite_spatial_smt/results/20261015-integration/`。

这些组件测试不计入程序 benchmark，也不覆盖历史 benchmark 测试分类。
