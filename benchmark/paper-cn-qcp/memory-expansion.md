# 原始内存程序扩展（2026-10-14）

新增 **20 个程序、256 个固定输入**，每个都有 reference、spec mutation、implementation mutation。
它们来自项目自带 QCP examples 与 CN/Fulminate 原始练习，不是新增的人造机制对照。
CN 来源固定到 `rems-project/cn-tutorial@5d858ae39ef3da80c66a09f723f64c01a28b4c17`；
源文件及下载归档哈希见 `sources/cn-tutorial/provenance.json`，QCP 逐文件哈希见各 `case.json`。

## 组成及实测

| 分组 | 程序 | 固定输入 | 已完成的检查 |
|---|---:|---:|---|
| `upstream-memory` | 6 | 200 | 同一 C 实现 CN/QCP 配对；两边各 600 次结果全部一致；native32/native64 原程序全通过 |
| `qcp-memory-v2` | 11 | 44 | 132 次原规约回放：20 PASS、12 FAIL、100 UNKNOWN；尚无 CN 配对 |
| `fulminate-memory` | 3 | 12 | Fulminate 36 次：15 PASS、21 FAIL，均符合输入级预期；native32/64 同时验证原程序及实现变异；QCP 翻译待完成 |

配对套件总数由 82 增为 **88**（原 79 + 3 个已有机制对照 + 新 6 个）。
连同以前的 7 个 QCP 原生例子和本次单边例子，目前有 **109 个已准备的目标函数条目**。
这些数量不代表 109 个都已完成 CN/QCP 对照；原 80 项的工业 allocator 仍未完成配对。

### 新增 CN/QCP 配对程序

- `cn_abs_mem`：拥有单个整数单元，读取并分支。
- `cn_abs_struct_field`：结构体内部字段取址，跨函数读取。
- `cn_init_point`：两个结构体字段分别交给函数初始化。
- `cn_transpose_via_call`：同一结构体的两个分离字段交给 swap。
- `cn_transfer_disjoint`：两个独立存储单元间的数据转移。
- `cn_incr_first_frame`：修改第一个单元，保留第二个单元。

CN 原始规约不改；QCP 是对应翻译。参考 C 实现与原文件一致，唯一的文件组织调整是
`incr_first` 将一个本地 include 展开，依赖哈希另有记录。新配对规约已通过本地输入审查
和执行比较，尚不声称有形式化的 CN/QCP 等价证明。

### 新增 QCP 原始程序

| 原函数 | 内存结构 |
|---|---|
| `array_copy1`、`array_concat`、`array_swap`、`array_vector_sum` | 多个分离数组、只规定形状的内容、未初始化输出区 |
| `dll_auto.c:iter`、`reverse` | 双向链接，原规约只规定形状 |
| `sll_queue.c:dequeue` | 带哨兵及 head/tail 的单链队列 |
| `sll_insert_sort.c:insertion` | 二级指针游标、独立新节点、未初始化 next 字段 |
| `sll_insert_sort.c:insertion_sort` | 嵌套链表遍历、函数调用、节点重排 |
| `poly_sll.c:reverse` | 多态链表，节点另指向独立拥有的 payload |
| `LiteOS/LOS_ListEmpty.c:LOS_ListEmpty` | 带哨兵的侵入式环形双链表；逻辑值含节点地址 |

所有 `reference.qcp.c` 与原文件逐字节相同。多态与 LiteOS 例子的 execution 文件只在
原源码前添加类型正确的 fixture 声明，原 Require 和程序体不改。
`BenchMemoryPayload.v` 已用项目 Coq 8.20 环境编译通过：
`int_payload` 为原始 `store_int`，`empty_payload` 为 `data == 0 && emp`。
后者实例化纯链接 `LOS_DL_LIST` 节点的 `storeA`；不会假造原节点不存在的数据字段。

LiteOS 例如绑定：

```json
{
  "types": {"A": "Z"},
  "args": {"node": 4096},
  "values": {
    "storeA": {"type": "Z -> Z -> Assertion", "qcp": "empty_payload"},
    "l": {"type": "list (DL_Node Z)", "qcp": "cons(Build_DL_Node(0,8192),cons(Build_DL_Node(0,12288),nil))"}
  }
}
```

地址 8192/12288 来自 `l` 的 `ptr` 字段，next/prev 关系仍由原始 `store_dll` 定义。
当前执行器接受这些绑定，但读哨兵 `pstNext` 时无法展开 `store_dll`，报告 UNKNOWN。
这不是绑定缺少节点地址。多态链表在 3 秒预算下仍有前条件证明/超时，未宣称算法已支持。
其他 UNKNOWN 包含越界访问的执行错误；原始诊断保留，不能记作已证明的 FAIL。

### 新增 Fulminate 原始复杂程序

- `queue/pop.test.c:pop_queue`：读出并释放队首，覆盖单节点和多节点。
- `dllist/remove.test.c:remove_current`：删除头、中间、尾节点，更新双向链接，分配返回记录并释放原节点。
- `list/mergesort.test.c:merge_sort`：递归拆分/合并，以结构体传递两个子链表。

`pre_instance` 是 CN 原始 requires 的逻辑模型记录，不冒充可直接传给 QCP 的绑定格式。
原生 fixture 仅实现该模型，分配地址通过节点对应关系归一化，不要求 malloc 返回指定数字。
双链表 `Before.curr` 的 prev/next 地址随原始逻辑记录一起固定。

## 输入规则及复现

**只实例化原始 Pre 出现的自由输入变量。** 新条目的允许名字在 `pre_free_variables`
中明确记录并审查。后条件的存在变量、谓词内部节点地址不另加绑定；若地址本就在
自由逻辑记录里，则随完整记录固定。实验阶段读冻结文件，不调用 LLM、不重新采样。

形状规约 `dlistrep_shape(root,0)` 没有长度/序列自由变量，固定 root 后仍代表多个有限堆，
不能冒称固定长度的具体执行。这里明确作为部分实例能力测试保留。
旧 `expansion80`、`memory-controls`、`qcp-native-examples` 的历史绑定不静默重写；它们
不是在本次 Pre-only 规则下重新审查过的集合。新旧输入策略在后续正式比较前需统一。

```sh
python3 benchmark/paper-cn-qcp/validate-memory-expansion.py
python3 benchmark/paper-cn-qcp/replay-frozen.py \
  --suites benchmark/paper-cn-qcp/upstream-memory/suites \
  --output .spectest/upstream-memory --sample-count 0 --jobs 3 --timeout 3
python3 benchmark/paper-cn-qcp/qcp-memory-v2/run.py \
  --output .spectest/qcp-memory-v2 --timeout 3
python3 benchmark/paper-cn-qcp/fulminate-memory/run.py \
  --output .spectest/fulminate-memory
```

汇总及固定驱动快照：`review-20261014/memory-expansion/`。
回放是有界正确性检查，三秒预算和并发运行不构成性能排名。
