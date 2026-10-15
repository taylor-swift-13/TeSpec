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

仅处理已完成、前条件 SAT、无抽象事件的执行中尚为 UNKNOWN 的 VC。
编码器只接收已明确 exact-heap 语义的有限空间 return VC；其他 VC 类型、
递归谓词、自定义函数、不支持的布局、缺少依赖、异常、超时均保持 UNKNOWN，保留 ITP 后备。

- SAT 反例对应 INVALID VC，并按原有路径 VC 合取语义使该测试 FAIL。
- 所有 VC 都 VALID，且执行完整、各阶段通过、原始 manual 清单和 return witness 覆盖一致，才允许 PASS。
- 只证明部分 VC 不足以产生 PASS；无法关联的额外 Coq 义务仍交给 ITP。

## 产物与证据

原始 `executor.json`、`vc/*.v`、`vc/manifest.json` 和 `residual_vcs` 保留作为证书输入，
不会生成伪造的 Coq 证明或把 SMT 结果标为内核检查通过。
`report.json` 中 `vc_results` 表示经过可选后端判定后的 VC 状态，附带原始状态和证据路径。
`spatial_smt.original_status` 保存进入后端前的测试分类。

每个候选测试的 `artifacts/<id>/spatial-smt/` 保存原始 VC、规范化编码、SMT-LIB、
反例堆、判定、查询哈希和耗时。`certificate` 保持 `NOT_CHECKED`。
报告顶层 `itp_vcs` 是待处理列表；已判定且覆盖完整的组无需 ITP，
未判定或无法关联的组继续使用原始 manifest。
旧 `vc.residual_goals` 是执行器原始记录，不等同于开启后端后的待办列表。

## 测试位置

- 主流程集成回归：`tests/test_spatial_smt.py`。
- 编码模块单元测试：`tools/finite_spatial_smt/test_*.py`。
- 本轮测试记录：`tools/finite_spatial_smt/results/20261015-integration/`。

这些组件测试不计入程序 benchmark，也不覆盖历史 benchmark 测试分类。
