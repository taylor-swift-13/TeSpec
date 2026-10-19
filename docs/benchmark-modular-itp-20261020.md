# Modular逐执行ITP收尾与成本（2026-10-20）

已完成全部58次可运行的残余VC ITP。每次均由实际gpt-6.1-sol CLI审阅并填写证明引用，分别编译原目标、证明和假设审计，再独立运行完整coqchk。58次均得到KERNEL_CHECKED和最终FAIL，符合这些错误变体的冻结预期，属于成功检出。116个原始残余VC被反证，并证明58个原入口可满足；连同必要堆事实，共242个登记定理的Print Assumptions均为Closed under the global context。

这58次覆盖incr 26、read 24、slf3_basic_inplace_double 4、zero 4。OFF/ON分别实际运行ITP，未把一次批量证明除以执行数。58个新模型回执与58个独立内核回执一一对应，没有重用同一个回执充作两次实测。全部源、绑定、原始报告和完整Goal哈希已核对。

## 最终判定

| 模式 | PASS | FAIL | UNKNOWN | 预期ERROR | 最终预期匹配 |
| --- | ---: | ---: | ---: | ---: | ---: |
| OFF | 491 | 379 | 7 | 23 | 893/900 |
| ON | 491 | 379 | 7 | 23 | 893/900 |

Modular在21组中的20组完成了全部既有输入的最终判定。原生分类仍为两模式各491 PASS、350 FAIL、36 UNKNOWN、23预期ERROR；附加ITP只补最终分类，不改原始输出。原自动阶段43次退化记录仍保留，不能说空间SMT已经自动解决了这些目标。既有CN/QCP/Fulminate和inline成本、原21/45完整范围均保持，新增modular范围另列。

## ITP平均成本

以下只对实际需要并完成ITP的58次执行取算术均值；每次包括全部原始残余VC以及所有实际尝试。模型总token为3,587,331，实际CLI调用58次；表内token是实际input_tokens+output_tokens，缓存输入属于input_tokens，不重复相加。

| 阶段 | 每次平均秒 | 平均单次阶段峰值MiB | 每次平均token |
| --- | ---: | ---: | ---: |
| 模型审阅／证明填写 | 25.094000 | 200.392982 | 61850.534483 |
| Coq编译与假设审计 | 5.714930 | 572.769599 | 0 |
| 完整独立内核检查 | 131.484351 | 1848.154432 | 0 |
| ITP合计 | 162.293281 | 1848.154432 | 61850.534483 |

ITP合计与三个分项重叠，不再次相加。总峰值先在每次执行内取各阶段最大值，再对58次取平均；不是把批次最大RSS除以58。模型内存为Windows客户端单进程PeakWorkingSet，Coq为GNU time记录的单进程最大RSS，均不包含远程模型/GPU内存。另保留各次采样进程树峰值原记录，不与单进程峰值混用。三个控制器任务并发，初始先导任务短暂重叠；这是该负载下的实测成本，不主张通用加速。

本批完整原始Goal与历史已检查证书逐字节相同，因此明确复用历史证明代码。新模型实际审阅并填写ReferenceProof引用，每次仍重新编译、审计和完整独立内核检查；这是EXACT_ORIGINAL_GOAL_CERTIFICATE_REVIEW_WITH_FRESH_PER_EXECUTION_COQ_KERNEL_CHECK，不是从零证明搜索。历史搜索成本不重复计费，当前CLI、编译和内核成本全部为新实测。

第一次准备阶段正则转义错误发生于任何模型调用前；首个任务随后在四次成功Coq编译后遇到控制器残余目标元数据缺失，已从冻结报告补齐并接续同一次尝试，保留原四次编译。没有再次请求该模型，也没有抹掉原计量。控制器诊断/修复日志另存audit；这些控制器事件未被冒称证明失败或新输入。现有证明编译/内核均未失败。

## ITP后仍未成功的14次

只剩array_load的7个原始客户端：translation5、6、7、8、9、11、12，各空间模式一次。它们入口SAT，但在modular边界采样时停止，execution_completed=false；vc.status=not_generated，residual_vcs为空，未生成原始Goal文件。此前已有的少量原生VC全部为VALID，不能拿它们代替尚未完成执行的出口目标。

因此这14次保留UNKNOWN/BLOCKED_NO_COMPLETE_EXECUTION_TARGET，没有可填写的全执行ITP目标，ITP调用数为0，证明成本保留null。它们没有被计为“证明脚本失败”，也没有用全称函数证明冒充测试完成。采样前态含局部权限和IntArray.full数组资源，当前采样入口不能产生合法的显式后继；这是执行阶段的能力缺口。

还对同样14次输入做了entry-exit参数诊断，均仍在同一实例化阶段UNKNOWN；改变VC范围参数没有补出目标。这些诊断不替换原all-boundaries测试。第一次诊断输出目录触发既有驱动根目录检查，14次配置拒绝和随后14次实际诊断均保存并计量；额外本地成本单列additional_entry_exit_diagnostic，包含每个诊断的两次调用，不计作新输入或ITP成本。

## 证据和审计

- [全组最终结果成本索引](../benchmark/results/modular-result-cost-index.md)
- [逐执行ITP索引与均值](../benchmark/results/modular-itp/20261020/index.json)
- [ITP后异常专项台账](../benchmark/results/tespec-unexpected/recheck-20261020-completed-modular.json)
- [14次无目标证据审计](../benchmark/results/modular-itp/20261020/blocked-execution-target-audit.json)
- [额外诊断及配置重试成本](../benchmark/results/modular-itp/20261020/additional-native-diagnostic-costs.json)

每组modular/20261020/result-cost.md/json/csv保存原生／最终分类、每阶段平均时间/token/峰值、各次原始VC与正式内核回执。主组表指向该补充，原四工具字段不改。native-before-itp保留本批原始未补证明表；初次原生发布的证据清单另存历史快照，原生执行日志、输入、Goal及原始报告始终不改。

可直接在仓库内重审证据，无需原Windows临时工作目录：
```sh
python3 -B tools/benchmark/collect_modular_itp.py --artifact-only
```
准备／接续同一批次可用modular_execution_itp.py prepare和run_modular_itp_windows.py；已成功回执会复用，不重复请求模型。collect_modular_itp.py核对完整目标／模型usage／全部尝试，attach_modular_itp.py只接受完整覆盖后发布；构表器重建时保留补充入口。独立新批次应使用新的输出命名空间，不覆盖本批计量。
