# 已完整组补充 modular 评测（2026-10-20）

本批为21个既有完整程序组补测全部900对变体/输入，空间SMT OFF/ON共1800次，不限于之前每组一个代表正例。使用执行器4e551edce5c3733671b6118dd689cd0e30d12e04416a2046a29bfd9361f55ace，execution_strategy=modular；VC范围沿用逐例冻结命令（已记录execution_mode），没有改程序/spec/输入/预期。

| 原生结果 | OFF | ON |
| --- | ---: | ---: |
| PASS | 491 | 491 |
| FAIL | 350 | 350 |
| UNKNOWN | 36 | 36 |
| 预期 ERROR | 23 | 23 |
| 原生预期匹配 | 864/900 | 864/900 |

原生运行覆盖全部完成；16组两模式全部符合既有预期，5组有未解决缺口。72次UNKNOWN均不算成功：58次已经完成执行、留下原始残余VC，ITP阶段为PENDING；14次在modular边界状态采样时执行未完成，没有可供整次执行ITP补齐的目标，单列BLOCKED。本轮没有模型/ITP调用，不把旧证书直接写入新目标，不宣称已补齐完整ITP。

## 差异和原因

| 组 | OFF UNKNOWN | ON UNKNOWN | 当前原因 |
| --- | ---: | ---: | --- |
| array_load | 7 | 7 | 7个原始客户端的断言边界状态采样UNKNOWN，执行未完成 |
| incr | 13 | 13 | 出口资源VC；ON拒绝当前modular执行事件，未进入空间查询 |
| read | 12 | 12 | 出口资源VC；ON同上 |
| slf3_basic_inplace_double | 2 | 2 | 出口资源VC；ON同上 |
| zero | 2 | 2 | 出口资源VC；ON同上 |

array_load原始日志有modular-assertion事件，contract-prestate含局部has_permission和IntArray.full资源，采样selected_state为空、status=UNKNOWN；入口SAT，但execution_completed=false。不能解释成该正确客户端被反证，也不能用出口证明代替未完成执行。其余四组58次执行完成，残余VC仍在；空间SMT ON的reason为unsupported_execution_events，attempted=0，当前后端主动拒绝这些抽象事件，不能称为SMT求解超时或反例。

原比较器报告43次相对旧基线的退化：14次执行未完成及29次原ON的FAIL变UNKNOWN；另29次OFF沿用旧原生UNKNOWN。比较器run_complete=true、passed=false原样保留，未修改门槛来接受缺口。旧ITP反证只是逐输入预期的比较证据，不代表新modular原始VC已获证书。

## 结果与成本位置

[全组modular结果成本索引](../benchmark/results/modular-result-cost-index.md)提供21组独立结果表。每组benchmark/results/<group>/modular/20261020/result-cost.md/json/csv保存两个模式的全部逐次证据、原生分类、预期匹配和成本；原组表追加链接，JSON/index追加execution_strategy_supplements。原主程序CN/QCP验证及Fulminate和inline的结果、成本不覆盖。既有完整21/45仍只描述原正式范围，新增modular有缺口者单列。

成本展示每次执行时间的算术均值、逐次最大进程RSS的算术均值和实际token。CLI、执行器、空间SMT分别记录且为嵌套阶段，不能相加；空间RSS为1ms采样观察峰值，native_cli/executor为各自原计量口径。本批worker=1串行，仍不将它当作与不同日期/版本的受控性能对照。无需ITP为NOT_REQUIRED，待证明为PENDING，执行未完成为BLOCKED；没有伪造证明阶段时间/RSS或token为0。

本批原生模型/token为0。主CN/QCP证据按历史哈希和范围引用，未重跑。第一次启动被旧驱动的输出根目录检查拒绝，尚未执行任何benchmark；日志保留在audit，作为配置诊断，不增加测试输入或模型数。随后在驱动允许的spatial-smt-regressions新目录完成全部运行。没有修改执行器或sac源码。

[异常专项台账](../benchmark/results/tespec-unexpected/recheck-20261020-completed-modular.json)保存全部72次未匹配的组、变体、输入/绑定、预期、原生/最终状态、OFF/ON对照、复现命令、源与VC哈希、日志、采样事件和ITP状态。[审计](../benchmark/results/spatial-smt-regressions/20261020-complete-groups-modular/audit/summary.json)核对运行结束前所有原有证据不变；发布后只有总索引新增补充字段，原索引逐字节快照保留且按原哈希核验。各组旧结果成本字段逐项保持相同。

## 复现

```sh
python3 -B tools/benchmark/regress_execution_strategies.py \
  --execution-strategy modular --workers 1 \
  --output benchmark/results/spatial-smt-regressions/<fresh-run>
python3 -B tools/benchmark/publish_modular_group_supplement.py \
  --results benchmark/results/spatial-smt-regressions/<fresh-run>/results.json \
  --run-id <YYYYMMDD>
```

现有构表器读取各组modular/index.json，在重建主表时保留补充入口。此次只增加评测数据和发布支持，不把采样或空间SMT的能力缺口改写为新的测试预期。
