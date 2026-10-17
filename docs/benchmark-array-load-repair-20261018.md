# array_load 修订与完整评测（2026-10-18）

保留13条语言版本记录、17个入口配对和67对输入（60个helper输入、7个原客户端入口）；没有新增负例或改变逐输入PASS预期。原始来源、旧状态及修订后的状态按源码哈希分开记录。

## 修复与结论边界

- translation5：显式与隐式局部槽重复。移除重复项后，本轮重测该文件全部7个输入。
- translation6：字节偏移误写成有类型指针加法&a+4/8，改为((int*)&a+1/2)。原值检查和数组内容保留；旧FAIL正确拒绝了错误翻译制品。
- translation7/12：CN观察式assert译成QCP精确堆Assert时漏了数组其余资源。保留三个标量和三个单元值要求，分别补full或missing_i；强/弱helper规约保持不同。它是翻译修复，不称与旧精确堆断言等价。
- translation7/12调用：只显式填写逻辑列表仍不能绑定契约；再使用等价的显式数组基址cast后，调用检查恢复，完整执行，reason变为residual_vc_requires_proof。原始绑定缺口保留，不把证明现有残余VC当作弥补被跳过的调用检查。
- translation9：a==a0未被资源匹配利用。入口full(a0,...)正规化为full(a,...)，保留等式和原后置；属于等价编码规避工具限制。

没有修改sac、teSpec执行器或SMT算法。客户端有限执行通过不等于弱helper规约足以支持一般模块化客户端验证。

## CN及主QCP证书

CN/Fulminate仍使用固定锁b4a2f0092。CN量词迁移为数学整数，Owned/extract迁移为RW/focus；统一read→array_load_read以避开系统read_proxy冲突。强主程序只补focus/instantiate证明提示；六条断言、前后置和去注释C（除alpha改名）不变，没有trusted、skip或only。

强CN整文件（目标函数及main）已验证。主QCP继续复用原read函数两项全称VC的完整证书与实际成本；源码、原始VC和证明哈希核对，不冒称客户端全称证明。旧回执不改写，新增复用回执把假设政策绑定到字节相同的旧计划快照。

## 正式评测与成本

正式批次为benchmark/results/array_load/20261018-evaluation-v3。Fulminate原生67PASS；teSpec OFF/ON原生各65PASS、2UNKNOWN。两个模式的四次执行分别做实际gpt-6.1-sol ITP，每次包含全部6个原始残余目标。原生UNKNOWN不覆盖；独立编译、假设审计及coqchk通过后才追加最终PASS。最终完成状态以组result-cost.json、证明index.json及全局索引为准。

证明保留原始C类型/地址解释参数和既有库使用的标准函数外延性，没有新证明公理，不能写Closed under the global context。模型、编译审计、内核阶段分别计量；ITP显示逐执行均值及逐执行峰值RSS的均值，原始峰值保留。

首轮驱动main仍含旧0i32规约，第二轮复制的客户端断言仍含旧数字后缀；修正后的第三轮Fulminate为67/67。前两轮构建失败不是成功检出，所有日志和真实费用保留。源修订/驱动诊断费用与最终成功批次单列，未执行阶段记null；每份测量只计一次。详细逐次费用见20261018-source-repairs/diagnostic-costs.json和20261018-cn-compatibility/diagnostic-costs.json。

复现原生测试须使用新run-id：python3 tools/benchmark/test_group_variants.py --group array_load --run-id <fresh-run-id>。不得覆盖本轮结果。主QCP历史复用与新版本原生评测分别披露，阶段工作量之和不称连续端到端墙钟时间。

## 历史10项异常与修订后证据

[来源修复专项记录](../benchmark/results/tespec-unexpected/source-repairs-20261018-array-load.json)逐条保存5个客户端、OFF/ON共10项历史问题的新旧源码、输入、报告、VC及日志哈希，原始与最终状态、两模式对照、独立ITP回执，以及使用冻结源码且另设输出目录的复现命令。translation5同时链接[2026-10-17单例修复回执](../benchmark/results/array_load/20261017-client-region-annotation-fix/results.json)。

| 客户端 | 历史OFF/ON原始状态 | 修订后OFF/ON原始状态 | 修订后最终状态 | 结论 |
| --- | --- | --- | --- | --- |
| translation5 | UNKNOWN / UNKNOWN | PASS / PASS | PASS / PASS | 修复重复局部槽注解；没有证明旧VC |
| translation6 | FAIL / FAIL | PASS / PASS | PASS / PASS | 修复错误指针算术翻译；旧FAIL正确拒绝旧制品 |
| translation7 | UNKNOWN / UNKNOWN | UNKNOWN / UNKNOWN | PASS / PASS | 修复资源框架和调用绑定后，各自证明新执行的6个残余目标 |
| translation9 | UNKNOWN / UNKNOWN | PASS / PASS | PASS / PASS | 等价别名正规化规避资源匹配缺口；旧执行未完成且没有生成VC |
| translation12 | UNKNOWN / UNKNOWN | UNKNOWN / UNKNOWN | PASS / PASS | 保留弱helper规约；各自证明新执行的6个残余目标 |

历史8个UNKNOWN和2个FAIL保留原分类。源码哈希已改变，修订后10次PASS仅作为来源修订后的复测结论，不把历史10项自动改为已证明，也不把所有旧UNKNOWN统称为工具错误。7/12包含翻译修复及调用编码调整；只能依照各阶段证据说明已观察到的绑定缺口，不能由最终通过反推出每个旧残余VC成立。9的别名匹配限制和7/12仍需ITP的自动求解缺口继续保留。

[逐执行ITP索引](../benchmark/results/array_load/20261018-positive-itp-per-execution/index.json)已完成4项任务，共6次实际模型调用（含两次失败后的修复），每项均完成编译、假设审计和独立内核检查。证书只覆盖各自新报告的全部残余目标；保留原类型/地址解释参数和库函数外延性，不能称全局无假设。原生自动判定的VC没有被这些ITP证书重新认证。

[正式批次](../benchmark/results/array_load/20261018-evaluation-v3/results.json)为Fulminate 67/67原生PASS、teSpec两模式各65/67原生PASS，加各2次独立ITP后各67/67最终PASS。保持原始与最终两列。[附加费用](../benchmark/results/array_load/supplementary-costs.json)单列来源修订及历史诊断，不能并入主成功执行均值，也不能遗漏失败尝试。最终费用表见[组结果与成本](../benchmark/results/array_load/result-cost.md)。
