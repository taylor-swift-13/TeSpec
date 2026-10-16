# 以 Fulminate 为起点的文献调研与 teSpec 定位

调研日期：2026-10-17。对应当前论文提交 b93183b4b。

本轮回读了 20 份核心原文或作者技术报告的相关机制、语义、定理、评估与限制章节，并补查 Delfy 和 COINS。范围从 Fulminate 的直接前驱扩展到其 2026 年后续，以及证明辅助规约测试。各来源的实际阅读版本、章节、页码和 artifact 链接记录在[来源索引](fulminate-sources.json)。这里的“已读”不代表已复现其工具或逐页核验全部证明。

本轮先形成研究判断和修订依据，尚未把这些新判断写成论文中的已完成实验结果。

## 1. 最重要的研究判断

此前的文献组织过于按工具分类，没有充分识别与本方法争夺同一贡献的工作。优先级应调整：

- **Perry 2006 和 IronSpec 2024 是必须正面讨论的先例。**前者直接以证明搜索检查堆规约；后者提出针对具体值或值域的 Spec-Testing Proofs。“把测试和证明结合”不足以单独说明 teSpec 的贡献。[R1], [P4]
- **StaDy 和 Gillian 是方法与形式化的直接对照。**应围绕选定输入域、执行与摘要、抽象失败与可达错误展开比较。[P1], [P5]
- **主张应落在执行与空间观察之间的接口。**具体要解释怎样保留堆、live values、调用上下文和入口绑定，怎样让未决断言不变成后续执行的假设，以及怎样把原 VC 的证据连接到执行结论。这是本文需要建立的研究判断，不是已有实验已经证明的优势。
- **Fulminate 的版本必须分层。**后续工作已经改变了若干早期支持边界；输入生成进展与断言判定进展则应分开讨论。[F4], [F5]
- **形式化应有对应的实现证据。**仅给观察规则加一条“状态不变”的公理，尚不能证明具体执行器满足它。应把关键接口、已有机械化和待落实的实现对应关系逐一写明。

## 2. Fulminate 系列：按职责理解，而不是增加基线数量

| 工作 | 负责的主要任务 | 对本研究的意义 |
| --- | --- | --- |
| CN 2023 [F2] | 原始契约上的完整验证 | 区分规约语言、求解支持与验证结论 |
| Fulminate 2025 [F1] | 对实际执行进行规约与所有权检查 | 首要外部 oracle 对照 |
| Bennet 2025 [F3] | 从前条件生成输入 | 将输入质量与 oracle 能力分离 |
| PLDI 2026 workflow / Darcy [F4] | 扩展动态检查；另提供约束式输入生成 | 重新审视旧版本的能力边界 |
| Lucas 2026 [F5] | 用运行时抽象解释改进生成器 | 自动生成实验的近期对照 |

### F1. Fulminate，POPL 2025

核心机制是把 CN 规约编译成 C 检查，以 ghost state 记录每个地址的所有者调用深度，并在调用、返回和访问处处理所有权。§3.4 的双模拟及失败一致性连接显式资源传递与插桩语义；这不是对整个 C 工具链的端到端机械化证明。§7 明确指出其插桩层未直接获得全部 C 未定义行为检查信息。[F1]

对论文的决策：INT_MIN 保留为配置敏感的安全对照；中心案例应展示空间观察或原始逻辑命题的处理。形式化组织可借鉴“抽象检查语义—具体实现表示—对应性质”的层次。

### F2. CN，POPL 2023

CN 将分离逻辑资源与 refinement types 结合，经 Cerberus 转换后交给 SMT。原设计已经包含受限的全称约束和实例化；不能写成“CN 不支持量词”。资源输入/输出纪律与非线性算术限制是不同问题。§5 的验证案例及工具比较讨论的是验证成本与注释，而非测试 oracle 的检出能力。[F2]

对论文的决策：语言表达能力、自动判定能力、实际完成的完整验证，分别列证据。

### F3. Bennet，OOPSLA 2025

Bennet 把前条件翻译成带采样、回溯的生成 DSL，再编译到 C；约束提升、重排、特化减少无效生成。Fulminate 提供执行检查。§5.2 的 AFL++ 比较也使用 Fulminate，因此主要隔离生成策略。递归约束传播、受限指针布局和 shrinking 等是该版本的限制。[F3]

对论文的决策：固定输入实验不应将 Bennet 记成独立 oracle；端到端找错实验则必须控制生成差异。

### F4. Code-Specify-Test-Debug-Prove / Darcy，PLDI 2026

§§5–6 新增混合已注释与未注释函数的 fragmentary specifications，并扩展循环不变式、lemma、wildcard ownership、ghost arguments 和所有权表示。循环 leak check 默认关闭。Ghost arguments 使用显式实例；该论文版本支持 CN proof 和 runtime checking，尚不支持 property-based testing。运行时检查一次 lemma 使用不等于证明其普遍有效性。Darcy 另以路径选择、约束求解和堆物化生成输入，存在特定连续数组表示的边界。[F4]

对论文的决策：撤掉按旧版本概括的“不支持循环不变式/lemma/ghost 参数”等说法；比较时固定开关，并分清数学全称命题与某个 ghost 实例。

### F5. Lucas，OOPSLA 2026

Lucas 的抽象解释发生在生成器内部：采样前细化、从失败约束纠正、沿复合表达式传播要求。候选仍按原约束检查，Fulminate 仍负责程序执行的 oracle。主要消融是同一实现中启用/关闭细化；关闭版是使用更新 Fulminate 的 Bennet-style 重实现，不是原版 Bennet 二进制。细化有收益也有开销，保持 opt-in。[F5]

对论文的决策：补入近期文献；只有研究输入发现时才扩展端到端比较。

## 3. 沿 Fulminate 引文回溯的直接前驱

| 来源与阅读位置 | 机制、保证与边界 | teSpec 的定位含义 |
| --- | --- | --- |
| Perry/Jia/Walker 2006，§§2–4 [R1] | MiniC 当前堆成为线性假设，规约定义成为可复用假设，由修改的 LolliMon 搜索证明；有 assertion soundness。它并非完整的逐访问权限 enforcement。 | 证明搜索式运行时堆 oracle 已有先例；需要解释我们产生及保留的执行信息有何不同。 |
| SLICK 2008，§§3–7 [R2] | 对 Java 对象和调用着色，在读写与契约边界检查、转移 footprint；递归谓词与 mode analysis 推导输出/存在变量，失败析取需撤销着色。部分 witness 选择 sound but incomplete。 | 所有权检查不能简化成普通布尔后置条件；后置条件漏归还资源与本项目 read 案例直接相关，但结果还取决于资源丢弃、隐式 frame 和 leak-check 语义。 |
| Agten/Jacobs/Piessens 2015，扩展版 §§4.2–4.4、6.2–6.6 [R3] | 用契约与完整性检查保护已验证 C 模块免受未验证上下文破坏；在模块边界保存、核验保留资源。证明 safety/precision；不要求上下文每次读取都满足完整 footprint 限制。 | 它依赖模块内部的静态保证，目标不是对任意待验证程序做完整动态规约测试。 |
| Brotherston 等 2016，§§2–3、5、6.5 [R4] | 判断一个给定 stack/heap 是否满足带归纳谓词的 symbolic-heap 断言，采用子模型不动点。一般 EXPTIME-complete；MEM+CV+DET 的组合给出高效片段。 | 区分具体堆满足关系和对符号状态集合的 entailment；precision 单独不是多项式保证。 |
| Dryad 2012，§§2–4 [R5] | 结构化展开有限 footprint，将剩余递归项抽象后交给 SMT；证明过程 sound、incomplete、terminating。 | “执行/结构指导逻辑简化”有先例；过程终止不等于被测程序终止。 |
| DITTO 2007，§§2–3 [R6] | 缓存无副作用检查函数的计算图，依写屏障重新计算受影响部分；检查函数存在依赖限制。 | 优化已存在的可执行 checker，不解决残余命题如何获得 oracle。 |
| Gyori 等 2017，§§III–V、Theorem 1 [R7] | 维护链表区域与线性度量摘要，以组合/收缩操作支持增量检查；给出与具体配置求值的一致性。 | 是特定断言域的性能路线，适合在讨论重复检查成本时引用。 |
| Implicit Dynamic Frames，2009 技术报告 §§2、4–5、8 [R8] | 用 acc 和访问集合表达权限；heap-dependent pure methods、self-framing 与一阶 VC 连接。 | 是权限与语义基础，不能写成该报告交付了成熟的 runtime testing 工具。 |
| Wise 等 2020，§§4–5、7–8 [R9] | 渐进验证结合静态 iso-recursive 与动态 equi-recursive 谓词；运行时 footprint 处理不精确契约，给出 progress/preservation 与 gradual guarantees。 | 区分规约中的未知部分和求解器留下的 UNKNOWN。此篇是补充近邻，并非 Fulminate §6 显式列出的前驱。 |

R8 的 2012 TOPLAS 版本全文本轮未取得。报告依据的是已读 CW542 技术报告；不能把其页码冒充为期刊版页码。

## 4. 测试与证明交界：比一般证明代理更关键的近邻

### P1. StaDy，Formal Aspects of Computing 2018

StaDy 通过 ACSL instrumentation 与动态符号执行区分 noncompliance、subcontract weakness 和 prover incapacity。实际执行与用契约替换调用/循环的探索承担不同任务；候选回放用于确认。§6.1 的 typically 只缩小测试域，不改变原验证目标；不完整探索留下 UNKNOWN。确认 prover incapacity 需要完整域和相应完整探索条件。[P1]

对论文的决策：直接比较其域限制和回放机制，不应只以“测试帮助解释证明失败”一语带过。

### P2. E-ACSL，RV-CuBES 2017

E-ACSL 将可执行 ACSL 断言编译成 C monitor，结合运行时内存信息和静态分析。包含数学整数、内存谓词和有界区间量词。其边界是规定片段中的可执行解释及运行时定义性，不能写成“不支持量词”。满足检查时的行为保持也是既有研究主题。[P2]

对论文的决策：在能忠实翻译的纯值/内存公共片段评估；单独衡量原断言变换成 monitor 的成本。

### P3. HOL-TestGen，ENTCS 2008

它从逻辑测试规约得到受约束的符号测试和显式 test hypotheses，再选具体数据执行。Uniformity/regularity 假设解释有限测试如何关联更大范围；文中以插入排序证明这些假设。[P3]

对论文的决策：把 teSpec 限于选定域的结论写清，不把有限实例 PASS 外推为原始全域正确性。

### P4. IronSpec，OSDI 2024

Spec-Testing Proofs 针对给定值、值域和独立表达的意图，能在没有实现或完整证明时检查规约。§4.2.2 建议在补充证明之前否定 STP 的结论，寻求 counterexample STP。它还结合 sanity checking 和规约变异；证明失败本身不被当作规约错误。[P4]

需要保留的逻辑区别是：

\[
\forall x\, (T(x)\Rightarrow\neg A(x))
\quad\not\equiv\quad
\neg[\forall x\, (T(x)\Rightarrow A(x))]
\equiv_{\mathrm{classical}} \exists x\, (T(x)\land\neg A(x)).
\]

前式对应保持前提、否定结论的操作；后式是整个全称义务的反证。非空单点域可使两者重合，一般范围域不能等同。最后一步依赖经典逻辑；在 Rocq 中，证明全称命题的否定也不自动提供可提取的存在见证，仍需说明逻辑假设与可达性证据。

### P5. Gillian 的 correctness/incorrectness 语义，ECOOP 2024

论文明确区分行为覆盖与错误可达性，并为 consume/produce、函数规约和谓词操作给出接口条件。其 exact core 支撑两种方向；under-approximate folding 另需 strictly exact predicates。Gillian-C whole-program symbolic testing 用符号输入、假设和断言检查执行。[P5]

对论文的决策：形式化应比较具体接口；在实现能覆盖的公共片段，Gillian-C 是最有信息量的独立符号执行基线。

### P6. Testing Theorems, Fully Automatically，OOPSLA 2026

该工作自动选择 Rocq 归纳关系的生成 modes 与调度，使用密度和依赖信息。形式目标是一阶、简单类型索引及 prenex 定理；生成与检查受 size/fuel 限制，可能 discard。作者把非归纳谓词作为后续方向。它改进反例搜索，不将随机测试成功提升为定理证明。[P6]

对论文的决策：不能把“逻辑关系必须先手写成 checker”当作一般事实；需明确本方法检查的是 C 执行派生的哪些原始义务。

补充读物：

- **Delfy / Integrated Environment for Diagnosing Verification Errors，TACAS 2016**：结合 Dafny、动态符号执行、验证调试器与 timeout 诊断；已核查其目标和架构，未在本轮做 artifact 复现。[Delfy](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/07/ide-1.pdf)
- **COINS，ICML 2026**：给定 input/output relation 的 admission proof 是直接 oracle 对照；未证明的 rejection 不能计为 checked violation。[COINS §3.2](https://arxiv.org/html/2608.13077v1)

## 5. teSpec 应集中建立的贡献

下面是基于文献与当前论文的分析，尚不是新实验结论。

| 候选贡献 | 已有先例 | 本文应建立的具体性质 |
| --- | --- | --- |
| 用证明测试规约 | R1、P3、P4 | 原始执行派生义务的构造及其有效性，而非“证明+测试”这一组合本身 |
| 对选定输入域进行测试 | P1、P3、P4、P5 | 部分绑定域跨调用、展开、规范化和观察保持；结论不超出该域 |
| Copied observation | 动态监测早已有之；P5 明确资源接口 | 观察不消耗继续执行所需资源、不引入待检断言作假设，且冻结 VC 保持正确解释 |
| 正反两种证明结果 | P4 有正反结论尝试的先例；并非相同的整式否定协议 | 证明整式 phi/非 phi、记录真实依赖；不能错误否定量词或只反驳一个存在 witness |
| INVALID 到 FAIL | P1 的回放、P5 的可达性保证 | 逻辑违反对应到测试域内、匹配观察点的真实执行 |
| PASS | P3/P5 已强调假设与覆盖 | 非空入口、覆盖选定域全部执行及规定观察点、无未完成分支、全部相应义务有效 |

建议的中心表述：

> TeSpec preserves execution-derived states while checking spatial observations as original logical obligations over selected symbolic domains, and relates proofs and refutations to explicit coverage and reachability conditions.

这应由执行器行为、具体观察/规范化接口与对应定理共同支撑。形式化的优先顺序：

1. 给出独立于求解器的原始检查含义与观察事件。
2. 建立具体状态和符号堆/live-value 表示关系。
3. 展开调用/循环、观察、规范化分别证明保持关系。
4. 定义 obligation inventory 与实际选定边界的对应。
5. 接入 SMT/ITP 的证据条件，再推出 PASS/FAIL 性质。

现有 formalization-map.md 已指出参考模型与实现接口的区别；下一轮应沿上述顺序增强论证，尤其关注 copy、witness-dependent frame 和 joint normalization 的具体实现对应。

### 一项必须澄清的评测对象

代码符合规约，与规约符合独立意图，是两个问题。例如正确实现满足后置条件 true，并不说明 true 是好的功能规约。仅用该实现对该规约做 conformance test，无法必然检出这种过弱规约。

因此，错误规约评测应标明独立参照：期望性质、已知错误实现，或指定的应被拒绝行为。不能把“变异了规约”自动等同于“这个具体输入应 FAIL”。IronSpec/COINS 的意图与 admission 视角适合解释这一区别；teSpec 的执行视角则负责建立被观察行为。[P4]

## 6. 基线：按要回答的问题选择

| 对照 | 建议级别 | 公平比较所需条件 |
| --- | --- | --- |
| 更新版本的 Fulminate | 核心外部运行时 oracle | 同一 C 行为、等价 CN/QCP 语义、相同输入；固定版本、编译器、检查开关；安全案例加单独标注的 sanitizer 配置 |
| 原生 QCP 完整验证 | 核心验证参照 | 主程序原始契约，不加固定输入等式；生成、证明填写、检查分开计费 |
| CN 完整验证 | 保留的独立验证参照 | 匹配主契约，注明已证明的属性与域 |
| Gillian-C whole-program testing | 优先新增 | 先评审公共特性与 ownership adapter；普通值 ASSERT 不能冒充完整空间规约检查 |
| COINS / 直接实例证明控制 | 重要的 oracle 分解实验 | 相同关系、输入/输出和证明预算；分别记录已证 admission、已证 refutation 与无证预测；自建适配器需单独命名 |
| E-ACSL / StaDy | 公共片段上的针对性实验 | 忠实 ACSL 转译；比较 executable oracle 或 proof-failure diagnosis，不虚构原生 SL 支持 |
| Bennet / Darcy / Lucas | 研究自动生成时才加入 | 分开统计合法输入生成率、覆盖、oracle 检出、总时间；它们不构成三个独立的固定输入 oracle |
| IronSpec / HOL-TestGen | 必须深入讨论；不强行放入 C 端到端成本表 | 如复现其思想为控制实验，明确工具、任务、逻辑和人工参与差异 |

当前 research-protocol.md 中“baseline selection is complete”应在下次整体修订时撤回。重点不是继续扩大工具清单，而是先确定能忠实匹配的比较单位。

## 7. 实验规模的分母不能混用

| 原文 | 报告单位 | 原文位置与注意事项 |
| --- | --- | --- |
| Fulminate 2025 | 75 个 tutorial 示例整理为 54 个 whole programs | §5.2；不是本仓库的来源文件数 [F1] |
| Bennet 2025 | 6 workloads、76 mutant–property tasks | §5.2 Table 1；另有 tutorial 实验；76 不是独立程序数 [F3] |
| PLDI 2026 Darcy | 24 个历史 allocator spec-bug tasks | §A.4.2：18 solved、4 partial；对照 Bennet 为 3 solved。该页一处旧文字与表不一致，采用表格并注明 [F4] |
| Lucas 2026 | 16 workloads、245 mutants、88 functions、355 tasks | §5.2、Table 1、p. 19；对照是关闭 refinement 的同一实现 [F5] |

本仓库的 76 来源文件、程序组、变体数和测试次数应由自身 manifest 定义。这些单位不能直接与上表相加、替换或作为规模相同的证据。

## 8. 对当前论文的具体修订决策

| 当前部分 | 下一轮应做的修改 | 完成标准 |
| --- | --- | --- |
| Introduction | 从“固定输入不必令规约可执行”收紧为“固定输入不自动提供原文规约的 executable monitor”；将具体空间观察问题提前 | 给出明确的执行状态、原命题、缺失信息和处理机制 |
| Contributions | 把创新点集中于执行保持、空间观察、义务解释与 verdict 连接 | 每项有对应接口、定理或实验，而不是概念名称 |
| Related Work | 以运行时空间检查、证明式规约测试、符号语义、生成与验证四条线组织 | 重点展开 Perry、Agten、StaDy、IronSpec、Gillian；压缩一般 LLM 证明工具枚举 |
| Formalization | 借鉴 F1/P5 的语义层次，突出实现表示与抽象语义之间的关系 | 明确哪些是已证明性质、哪些是接口前提、哪些由实现证据支持 |
| Case studies | 把算术安全、原始逻辑命题、空间所有权、观察状态保持分成有不同目的的对照 | 每个案例回答一个机制问题，含正确控制与等价改写控制 |
| Evaluation | 将当前支持、历史版本观察、生成难度和 oracle 决策分开 | 再跑实验前先固定匹配语义、版本和结果分类；本轮不新增实验 |
| Figures | 下一轮图应承载状态表示和证据接口，而不只是工具模块名称 | 图中的箭头能对应到规则、数据或检查，而非装饰流程 |

优先准备的机制证据是：同一程序轨迹上替换中间断言，后续值与资源仍保持；规范化同时保留堆和活值的关联；对存在 witness/局部 frame 的负证据不会被错误提升。它们比仅展示若干 UNKNOWN 最终被人工解掉更能说明方法价值。

## 9. 本轮覆盖和仍需单独核验的事项

- 共 20 份核心来源，具体阅读范围见 fulminate-sources.json；没有声称做完领域穷尽式系统综述。
- 直接阅读原论文、作者报告和官方出版记录；未把搜索摘要作为核心机制的唯一证据。
- 未执行第三方 artifact，也未重跑现有 benchmark。论文中的旧结果仍是其固定版本的证据。
- IDF 2012 版本未取得；使用的 2009 报告已显式标注。
- PLDI 2026 补充材料存在同页计数不一致；上文记录了选择表格数据的依据。
- 下一轮实验应核验当前 Fulminate 配置下原案例的实际结果；文献能力描述不能替代一次运行。
- 当前 .tex 和 PDF 本轮保持原稿；本报告用于下一轮整体重写，避免只逐句补引用。

[F1]: https://www.cl.cam.ac.uk/~pes20/cn-testing-popl2025.pdf
[F2]: https://www.cs.ox.ac.uk/people/christopher.pulte/popl23.pdf
[F3]: https://zain-k-aamer.com/papers/bennet.pdf
[F4]: https://www.cl.cam.ac.uk/~pes20/pldi2026-paper155-supplementary.pdf
[F5]: https://zain-k-aamer.com/papers/lucas.pdf
[R1]: https://www.cs.princeton.edu/~dpw/papers/gpce06.pdf
[R2]: https://lara.epfl.ch/~kuncak/papers/NguyenETAL08RuntimeCheckingSeparationLogic.pdf
[R3]: https://www.cs.kuleuven.be/publicaties/rapporten/cw/CW676.pdf
[R4]: https://discovery.ucl.ac.uk/1476369/1/p84-brotherston.pdf
[R5]: https://madhu.cs.illinois.edu/dryad/popl12.pdf
[R6]: https://homes.cs.washington.edu/~bodik/ucb/research/pldi07-ditto.pdf
[R7]: https://mir.cs.illinois.edu/gyori/pubs/icst17.pdf
[R8]: https://www.cs.kuleuven.be/publicaties/rapporten/cw/CW542.pdf
[R9]: https://www.cs.cmu.edu/~jssunshi/assets/pdf/gradVerRecursiveHeapDataStructures.pdf
[P1]: https://guillaumepetiot.com/papers/FAC_18.pdf
[P2]: https://easychair.org/publications/open/t6tV
[P3]: https://logicalhacking.com/publications/brucker.ea-verifying-2008/brucker.ea-verifying-2008.pdf
[P4]: https://www.usenix.org/system/files/osdi24-goldweber.pdf
[P5]: https://arxiv.org/pdf/2407.10838
[P6]: https://lemonidas.github.io/pdf/TestingTheorems.pdf
