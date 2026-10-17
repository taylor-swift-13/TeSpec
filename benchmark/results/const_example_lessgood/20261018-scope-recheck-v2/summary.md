# 第 22 个待续做组检查：const_example_lessgood

这里的第 22 指已完成 21 组后，按保留的续做队列选择下一个未完整组；不是字母排序索引。只检查这一组。

当前程序无参数，只有 1 个独立入口。逻辑函数 `cn_CONST()` 定义为 `1`，正文只断言它等于 `1`。原 C 宏 `CONST` 未参与该断言，不宣称验证了宏与逻辑定义之间的关系。

| 对象 | 本轮／复用结论 |
|---|---|
| teSpec 空间 SMT OFF | 实际 PASS，入口 SAT、执行完整、无需 ITP |
| teSpec 空间 SMT ON | 实际 PASS，空间 SMT 查询 0，无需 ITP |
| CN 原始主程序 | 实际接受，原 main 带 trusted，正文未被检验 |
| CN 仅移除 trusted 的诊断副本 | 实际输出 `[1/1]: main -- pass`，定义、断言和 C 主体不变 |
| QCP 主程序 | 复用哈希匹配的 3 个原始 VC 完整证据；3 项全局封闭，编译和独立内核检查成功 |

**本组没有空间 SMT 通用性缺口；原有未完整原因是 CN 的信任范围。** 仅移除 trusted 已有可行的正文验证证据，但本次检查没有替换正式主程序配置，仍保留 21/45 完整组。后续若将该派生视图正式登记为主验证视图，应显式记录与原始来源差异，不能把原来的 trusted 接受改写成正文证明。

## 本轮检查成本

| 尝试 | 工具／模式 | 退出码 | 时间（秒） | 最大进程 RSS（KiB） | 模型 token |
|---|---|---:|---:|---:|---:|
| configuration-failed | tespec / off | 1 | 0.165015 | 27620 | 0 |
| configuration-failed | tespec / on | 1 | 0.114654 | 27888 | 0 |
| configuration-failed | cn / original | 2 | 0.032454 | 37448 | 0 |
| configuration-failed | cn / untrusted-diagnostic | 2 | 0.032575 | 36948 | 0 |
| corrected | tespec / off | 0 | 0.616346 | 23708 | 0 |
| corrected | tespec / on | 0 | 0.164721 | 23724 | 0 |
| corrected | cn / original | 0 | 0.114684 | 43248 | 0 |
| corrected | cn / untrusted-diagnostic | 0 | 0.114589 | 43676 | 0 |

首轮复查脚本将空间阶段计量放在封装不允许的目录，且未设置 CN 所需的 OPAM_SWITCH_PREFIX，四次调用均在真正检查之前失败。这是本次控制器配置错误，不是程序、规约或 teSpec 的错误；原始日志和成本保留。修正后使用同一源码、同一输入、同一预期完成检查。失败尝试与成功尝试均计入本检查汇总，未覆盖旧完整评测成本。

时间、RSS、实际命令和输出见 [summary.json](summary.json) 与 [results.json](results.json)。空间阶段采样见 `benchmark/results/spatial-smt-regressions/20261018-const-example-lessgood-scope-v2/`；采样 RSS 不是阶段精确高水位。新模型和测试 ITP 调用均为 0；没有重做 QCP 或 Fulminate。

所有原始源、输入、预期和旧证据保持不变。本轮没有修改 teSpec/sac 实现，也没有新增程序变体或虚构多个输入。
