# Fulminate → QCP：首批迁移与验证

> 队列 QCP 修正规约版本已验证：22 个自动 VC 消解、2 个 manual VC 通过内核检查。原 CN 合同反例保留，见 [专门文档](simple/advanced/queue-corrected/queue-spec-finding.md)。修正后的 QCP 版本单列，早期批次状态为历史记录。

> 当前状态（2026-10-15）：init_array2 的 3 个残留 VC 已证完，完整 6-VC 模块通过内核检查；init_array_rev 已修复并完成 7-VC 模块及资源策略证明。累计 37 个完整模块、345 个 VC 通过 Coq 8.20.1 和 coqchk。mergesort、完整 list_all、sized stack 与剩余 7 个标量程序均有回执。队列 helper/caller 已翻译、QCP 已运行，但原 helper 合同存在具体反例，不能标为成功。以下批次记录保留当时状态；最新清单见 [simple/README.md](simple/README.md)、[证明回执](simple/proofs/report.json)。CN/teSpec 同输入配对仍未完成。


先迁移规约，再分别验证原生 QCP 与 teSpec。当前覆盖锁定 CN 源码中的 **12 个文件、25 个目标函数**，重点是此前有疑问的分配、释放、链表、队列和栈。它们是函数级迁移；完整 CN 清单仍是 54 个主程序及 22 个补充 C 输入。

## 实测结果

[完整报告](evidence/20261014/report.json) 保存二进制版本与哈希、逐函数结果、逐输入结果和证据哈希。

| 组别 | 目标数 | QCP 自动消解 | 剩余义务 | 执行拒绝 |
|---|---:|---:|---:|---:|
| 引用创建、frame、递增、读取释放 | 6 | 5 | 1 | 0 |
| 链表构造、复制、释放、长度、反转、拼接 | 7 | 1 | 6 | 0 |
| 队列 empty / pop / push | 3 | 3 | 0 | 0 |
| 栈 create / sizeOf / push / top / pop | 5 | 2 | 3 | 0 |
| rand 包装与 two_dice | 2 | 1 | 1 | 0 |
| 单次释放与重复释放驱动 | 2 | 1 | 0 | 1 |
| **合计** | **25** | **13** | **11** | **1** |

重复释放驱动在第二次 `cn_free_sized` 处被拒绝：第一次调用已经消耗对应单元的所有权，第二次调用无法满足 Require。原始对照 `same_func_malloc_free.c` 自动消解。另有 24 个后条件负控：在每个正常目标的后条件中加入 `0 == 1`，全部在返回义务处被拒绝。

“自动消解”是目标函数的自动阶段结果，**尚未独立通过 Coq 内核检查**。例如 `succ_using_incr` 和 `two_dice` 的目标义务已消解，但其辅助函数 `incr`、`val_rand` 仍有剩余义务；报告保留整个翻译单元的结果。一个工具调用如果整体失败，报错前的局部 witness 计数不代表验证成功。

teSpec 对同一份源文件运行 96 个绑定输入，分别使用 `entry-exit` 和 `all-boundaries`，共 **192 次**。当前全部为 UNKNOWN：

- 148 次 `missing_function_body`：执行到分配、释放或随机数外部接口。
- 36 次 `precondition_requires_proof`：执行完成，入口满足性等义务尚需证明。
- 8 次 `contract_binding_unknown`：当前调用规约绑定过程未完成。

因此，分配、释放和队列更新不能再列为“QCP 无法支持”。这批实验明确暴露了 teSpec 的外部调用接口与证明完成问题；QCP 自动阶段成功尚不能直接转换为 teSpec 的执行 PASS。

## 迁移对应关系

[manifest.json](manifest.json) 固定每个原始文件、生成文件、目标与输入，并记录函数体哈希。[prepare.py](prepare.py) 可重新生成并检查对应关系。

- CN `Owned<T>` 对应 QCP `data_at`，`Block<T>` 对应 `undef_data_at`；结构体按字段保留所有权。
- CN `u32` 运算按模 `2^32` 翻译，不排除最大值来隐藏溢出。绑定输入包含 0、1、一般值及无符号边界。
- CN `IntList` 对应现有 QCP `sll`，序列对应 `list Z`。仅重命名结构体标签及成员访问：`int_list/head/tail` → `list/data/next`；局部变量不重命名。谓词定义与策略的哈希随清单保存。
- 队列的空/非空表示直接展开为字段与 `sllseg`。pop 再展开首节点，保留任意长度尾部；没有把整个队列限制为固定长度。原版 trusted `push_lemma` 保留为显式声明的可信接口。
- 栈的大小、数据指针和序列关系全部保留。原版 pop 没有约束返回值，这里也没有添加原规约不存在的要求。
- 类型化分配、释放包装器用声明及契约表示，保留实际客户函数的调用。`rand` 用非负 int 返回值范围表示。没有为这些函数编造执行体。
- 两个生命周期驱动将 C99 隐含的 `main` 返回 0 写成显式语句，其余执行语句保留。原版 trusted 驱动在这里主动接受 QCP 检查。

这些分配/释放契约沿用 QCP 的类型化内存单元模型；它们不构成 malloc 分配块身份、释放后对象失效或任意 libc 调用的完整运行模型。当前也未完成该历史 CN 版本的双工具同输入重放。

## 复现

在仓库根目录执行，`--qcp-repo` 指向仓库外已构建的干净原生 QCP checkout：

```sh
python3 benchmark/selection/qcp-migration/prepare.py
python3 benchmark/selection/qcp-migration/validate.py
python3 benchmark/selection/qcp-migration/run.py \
  --qcp-repo /path/to/qcp-upstream \
  --output /tmp/fulminate-qcp-new-run
```

输出目录必须为空。完整执行器 JSON、生成的目标源文件和残留 VC 保存在证据中；teSpec 临时目录删除后仍可从各结果文件的 `embedded_artifacts` 读取。native 子目录保留原生 QCP 日志与 VC，negative 子目录保留后条件负控及日志。

下一步以这批实测为依据：先打通有明确 QCP 支持的类型化分配/释放接口，并保持缺失普通函数体的检查；补齐列表入口和调用绑定证明；继续迁移尚未覆盖的函数、归并排序、双链表、其余 CN 原例与工业例。未完成项继续留在总清单中。

## 简单函数批次

[simple/manifest.json](simple/manifest.json) 收录 `zero`、`abs`、`add_0`、`add_1`、`add_2`、`read`、`swap` 七个原始目标函数。保持原函数体，原始 trusted main 未迁移。七个目标均由原生 QCP 自动消解；[报告](simple/evidence-upstream/report.json) 保留命令、源码哈希和义务计数，子目录保留日志及 VC。尚无 Coq 内核重放、teSpec 绑定输入或同输入 CN 配对结果。

`add_0` 只保留溢出前提，出口为 `emp`；`read` 只保留出口单元所有权，不添加原规约未要求的返回值关系。`zero` 将未初始化单元更新为 0；`swap` 保留 unsigned int 类型和两个单元的分离所有权。

### 第二批简单迁移

`simple/` 当前累计 21 个原始源文件、27 个函数出现项（辅助函数按所在翻译单元重复计数）。原生 QCP 自动阶段为 21 个自动消解、6 个残留，21 个翻译单元均完成运行。无符号运算保留模 2^32 的原始语义；未用排除边界的前提隐藏回绕。`incr_two`、`incr_first` 的目标可自动消解，但辅助 `incr` 的残留单列，不能视为整个调用依赖已证明。

第二批包括 `read2`、`add_read`、`abs_mem`、`abs_mem_struct`、`init_point`、`transpose`、`transpose2`、无符号/有符号 `incr`、`quadruple`、`inplace_double`、`incr_two`、`incr_first` 和 `transfer`。结构体版本使用按字段的 QCP 资源；完整 CN 对象所有权与布局对应尚待独立核对。

[simple/verification-index.json](simple/verification-index.json) 汇总两批冻结原始报告，并记录二进制和清单哈希。已在 `simple/inputs/` 准备 108 个入口绑定及 job，包含有符号边界和无符号回绕输入，全部标记为 `prepared_not_replayed`；没有原始 CN main 的同输入对照，不能计为配对测试成功。

### 六组残留 VC 已完成内核检查

`add_read`、`slf0_basic_incr`、`slf2_basic_quadruple`、`slf4_basic_incr_two`、`slf7_basic_incr_first`、`slf8_basic_transfer` 的完整 VC_Correct 模块已补证明，合计 21 个原始义务；Coq 8.20.1 编译及独立 coqchk 均通过。手工证明未导入含 Admitted 的自动模板，未增加公理。假设审计记录了 QCP 运行库的函数外延性和地址解释假设。

证明中发现原 `%` 是 Coq 余数，而 unsigned_last_nbits 是非负取模。六份翻译补上了原 C unsigned 类型的 0..UINT_MAX 值域，并重新生成 VC；未排除回绕输入。旧源码哈希及生成 VC 保留在历史报告中，当前回执绑定修正后的源码哈希。

见 [proofs/report.json](simple/proofs/report.json)。激活 Coq 8.20 环境后运行 `python3 benchmark/selection/qcp-migration/simple/proofs/replay.py --runtime runtime/qcip/SeparationLogic` 可重放。这是原生 QCP 全部 VC 的证明，不是 CN/QCP 所有权对应证明或 teSpec 108 组输入的执行结果。

### 第三批：别名与调用

新增八份原始源文件：`slf6_basic_incr_two_aliased_call`、`slf9_basic_transfer_aliased`、unsigned/signed `slf1_basic_example_let`、signed `slf2_basic_quadruple`、`slf_incr2_alias`、`slf_incr2_noalias`、`slf_quadruple_mem`。保留原函数体、辅助函数、原始别名关系和 C 类型范围；不迁移原始 main。一般化 BothOwned 版本 `slf_incr2.c` 仍待迁移。

本批八组完整 VC_Correct 模块的 45 个原始 VC 已全部证明并通过 Coq 8.20.1 编译、coqchk 和假设审计。累积 14 个翻译单元、66 个 VC 有完整内核回执；没有新增公理或导入含 Admitted 的自动模板。原生自动阶段的残留标签继续保留，ITP 结果单独记录。

`simple/` 当前包含 29 个原始源文件、39 个函数出现项和 153 个待重放入口绑定。自动阶段 26 个函数出现项消解、13 个残留；这 13 项对应的完整模块均已补证明。所有 29 份文件的函数签名和函数体与锁定原始版本逐项核对一致。尚未完成 CN 同输入对照和 teSpec 输入重放，结构体所有权对应仍独立列为待办。

### 第四批：基础弱规约和数组访问

新增 `3.c`、`const_example.c`、`array_load.c`、`array_load2.c`、`swap_array.c` 五个原始目标。`3.c` 只保证写后拥有某个 int 值，不额外要求零值；`array_load.c` 只保证出口数组所有权，不额外要求返回元素或内容不变。加强版读取和交换则保留原始索引关系与不同下标前提。原 `cn_CONST` 逻辑定义直接展开为 1，不新增 C 辅助函数。

五组完整 VC 模块的 13 个 VC 均已证明并通过独立内核检查；手工证明使用既有数组拆分和单元所有权遗忘定理，不导入 Admitted 模板。完整来源与 Coq 目标哈希、假设审计见 `simple/proofs/report.json`。数组 CN 索引映射与 QCP list 资源的完整对应仍待审查，不能从 QCP 验证成功推出跨模型等价。

当前 `simple/` 累计 34 个原始源文件、44 个函数出现项、179 个待重放输入；19 个翻译单元、79 个原始 VC 已独立内核检查。自动阶段 31 个函数出现项消解、13 个残留，13 个残留均另有完整证明回执。一般 BothOwned 条件所有权、数组初始化循环与剩余复杂数据结构继续列为待迁移；原 CN trusted main 与双工具同输入执行尚未覆盖。

### 第五批：数组初始化循环

新增 `init_array`、`init_array2`、`init_array_rev` 三份保持原函数体的迁移，并准备 14 个绑定；累计 37 份源文件、193 个待重放输入。出口只要求初始化数组的所有权，不增加原版没有的全零要求；内部证明不变式可以记录已写入的零值。

`init_array` 原生自动阶段消解；`init_array2` 完成运行，但留下 3 个人工义务，尚未证明。`init_array_rev` 的两种资源表示均在循环入口匹配失败，保留 TOOL_ERROR 原始日志和未完成状态。后两项不能标为验证通过；本批没有新增内核回执。逆序版本需要补数组尾部拆分/合并策略或独立运行库证明，而不是改 C 循环或限制输入隐藏失败。
