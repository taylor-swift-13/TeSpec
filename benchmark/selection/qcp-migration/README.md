# Fulminate → QCP：首批迁移与验证

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
