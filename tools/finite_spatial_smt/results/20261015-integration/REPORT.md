# teSpec 空间 SMT 接入验收

已在主入口 `spectest.core.run_job` 接入可选空间 SMT 判定阶段，支持 CLI `run`、`check` 和 Python 调用。

```sh
python3 -m pip install -e '.[spatial-smt]'
python3 -m spectest run sample.c --function read --binds binds.json --spatial-smt
python3 -m spectest check job.json --no-spatial-smt
```

默认关闭，保留原执行器调用、分类和 ITP VC。开启后对已完成执行中的有限空间 return VC 尝试自动判定。
不支持的 VC、后端异常和超时保留 ITP 路径。原始执行器 JSON 和 Coq 文件始终保留。

| 实际执行器用例 | 关闭 | 开启 |
|---|---|---|
| read 遗漏出口所有权 | UNKNOWN，1 个 ITP 组 | FAIL，无待办 ITP 组 |
| 正确 read | PASS | PASS |
| 缺少读取权限 | ERROR | ERROR |
| 自定义不透明谓词 | UNKNOWN | UNKNOWN，保留 ITP 组 |

`--no-spatial-smt` 能覆盖 job 中的开启配置，且不修改保存的 job。
关闭状态下四份 Coq 输出文件与默认状态逐字节一致；开启后的原始 Coq 文件也保持不变。
不透明谓词的后备任务已通过原有 `prepare_run_certificates` 流程生成。

验证结果：

- 编码模块 3,282 项测试全部通过，原始记录为 `unit-tests.json`。
- 集成回归 38 项全部通过，包含真实原生执行器调用、开关、配置校验、错误与超时后备、未完成执行保护。
- 扩展回归 152 项：138 项通过，14 项按环境条件跳过。包含早期 34 项集成测试，不与上述数量相加。
- 单独保存 9 次实际调用的产物和开关对照记录：`smoke-summary.json`。
- wheel 构建、隔离安装、无 Z3 时默认 CLI 导入、Ruff 与 diff 检查通过。

源码哈希与验证命令见 `validation-summary.json`。本目录属于组件集成验收，不计入程序 benchmark。

当前接入点在原生执行器完成之后，尚未接管执行过程中的分支或循环判定，也不恢复已中断的执行。
SMT 判定的证书状态仍为 `NOT_CHECKED`，不是 Coq 内核证明。
