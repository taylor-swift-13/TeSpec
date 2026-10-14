# 规约对应关系与变异

所有参考规约都保留资源形状与值的关系。表中 xs、A 等表示入口时的内容；输出必须
满足表述并保留／返回所要求的所有权。QCP 数据类型范围和 CN C 整数范围按同一
32 位 int/unsigned int 解释。

| 程序 | 参考后条件 | CN ↔ QCP 表示 | 错误后条件 |
|---|---|---|---|
| abs | r=abs(x)，x>INT_MIN | 条件表达式 ↔ 分支析取 | r=abs(x)-1 |
| swap | p'=q，q'=p；两单元分离 | 两个 RW ↔ 两个 data_at | 两单元保持原值 |
| transpose | x'=y，y'=x | RW struct 的字段 ↔ 字段 data_at | x'错误地等于旧 x |
| array_swap | 只交换 i、j 下标；i≠j | map 双更新 ↔ replace_Znth | 数组不变 |
| 递归／迭代 list_length | r=length(xs)，内容保持 | Nodes 返回代数列表、Length ↔ sll、Zlength | r=length(xs)+1 |
| list_reverse | 输出序列=rev(xs) | Nodes＋递归 Reverse ↔ sll＋rev | 错误要求末尾多一个 0 |
| list_append | 输出序列=xs++ys；入口两链表分离 | Nodes＋Append ↔ sll＋app | 错误要求末尾多一个 0 |
| array_sum | r=sum(A)，A不变，0<n<100且元素在[0,100) | each map、Sum ↔ IntArray、sum | r=sum(A)+1 |
| array_sum_zero | r=sum(A)，输出全0，输入范围同上 | B的每个元素为0 ↔ zeros(n) | r=sum(A)+1 |
| binary_search | 返回匹配下标；-1当且仅当不存在 | 量词 map 查询 ↔ 量词 list 查询 | 将成功下标误写为1基下标 |
| array_reverse | 输出第k项=原第n-1-k项 | each 索引关系 ↔ rev | 错误要求数组不变 |
| weak_call | 单元从v变成v+3 | 相同递归代码，helper只承诺w≥v | 顶层错误要求v+4 |
| tree_size | r为节点数，树内容保持 | Nodes、Size ↔ store_tree、tree_size | r=size(t)+1 |
| unbounded_root | y=r，r≥0，∀k≥0：(r≤k ↔ x≤k²) | 原始 each 无界量词 ↔ least_root | y=r+1 |
| simple_power | r≠0 ↔ ∃k∈nat：x=n^k | QCP 原始 Coq 关系；CN直接形式未提供 | 用1-r替代r |

CN 的 Sum 与 QCP 的 sum 都是数学整数求和，不能改为可能溢出的机器整数求和。
CN 的 Reverse、Append、Length、Size 是原数据结构逻辑值的定义，和 QCP 对应的
列表／树函数一致；它们不是另写的 C 性质检查程序。

二分查找的双下标量词在 CN 中用 k=i*n+j 展平，范围为 0≤k<n*n，借助除法与余数
恢复 i、j。n=0 时量词范围为空，不求值除法。逻辑仍是对全部有效 i≤j 要求 A[i]≤A[j]。
未找到条件写为每个有效 i 都满足 r≠-1 或 A[i]≠target，等价于原蕴含条件。

错误后条件从同一数学变异分别翻译；不能只让某一版本多一个约束。数组反转的空数组、
单元素和二分查找的未找到输入不会暴露相应变异，标签明确记录这种情况。

## 两个 case study

- `control_unbounded_root`：CN 前端接受原始 contract，但固定版 Fulminate 插桩报告
  `Cannot infer upper bound for permission`。不提供有限替代监视器。QCP 保留 forall k
  的原始 Coq 定义，由完整实例 VC 的证明检查关闭测试。
- `expressibility/cav_simple_power`：CAV 原始关系使用自然数上的自由存在量词。
  该形式没有在固定 CN 前端中直接对应的自由 exists 构造。有限指数搜索虽可在本输入
  域上推导为等价算法，但属于额外改写，不纳入主比较。记录为原形式的直接表达差距，
  不宣称不存在任何等价 CN 编码。QCP 原始定义、输入与参考证明保留在目录中。

CN/QCP 源级形式化等价证明不在本数据集证据中；本表与来源快照用于人工审阅，
函数体相同与独立 native 行为由自动检查保证。由于底层内存模型不同，比较以这些
C 程序的有效对象、形状与值为共同解释域。
