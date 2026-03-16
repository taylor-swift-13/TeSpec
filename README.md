# TestSpec

这个项目做两件事：

1. 根据 HumanEval 风格题目的自然语言描述，生成 Python 的 `precondition` / `postcondition`
2. 把生成出的规约和参考实现包装在一起，用数据集自带测试集做验证

## 目录说明

- `generate_specs.py`：生成规约与包装代码
- `run_tests.py`：对某个生成结果目录跑测试
- `run_negative_tests.py`：把 `_impl` 替换成 `humaneval_mutations/` 里的变异实现，做反例测试
- `HumanEvalPlus.jsonl`：数据集
- `input/<模型>_<时间戳>/`：原始参考实现
- `output/<模型>_<时间戳>/`：带规约的包装实现
- `test_reports/<模型>_<时间戳>/`：测试报告与 `_summary.json`
- `negative_report/<模型>_<时间戳>/`：反例测试报告与 `_summary.json`

## 如何生成

全量生成某个模型：

```bash
python3 generate_specs.py --api-model gpt-5-nano
python3 generate_specs.py --api-model gpt-5-mini
python3 generate_specs.py --api-model gpt-5
python3 generate_specs.py --api-model deepseek-v3.2
```

按区间生成：

```bash
python3 generate_specs.py --api-model gpt-5 --range 0:10
```

按指定题号生成：

```bash
python3 generate_specs.py --api-model gpt-5 --idx 1 2 3 163
```

每次生成都会创建新的目录，例如：

```text
output/gpt-5_20260316_013133/
input/gpt-5_20260316_013133/
```

## 如何测试

对某个输出目录跑测试：

```bash
python3 run_tests.py --output-dir output/gpt-5_20260316_013133
```

测试报告会写到：

```text
test_reports/gpt-5_20260316_013133/
```

支持参数：

- `--range a:b`
- `--idx ...`
- `--task-timeout 30`

`--task-timeout` 是单题超时。它主要用来处理这种情况：实现本身是快的，但 `postcondition` 写得太慢，导致整题测试卡住。

## 如何做反例测试

对某个输出目录跑负向测试：

```bash
python3 run_negative_tests.py --output-dir output/gpt-5_20260316_013133
```

报告会写到：

```text
negative_report/gpt-5_20260316_013133/
```

负向测试规则是：

1. 用 `humaneval_mutations/<题号>/original.py` 和 `mutation_*.py` 比较输出
2. 只统计“变异实现输出与原实现不同”的样例
3. 只有 `precondition=True` 且 `postcondition=False` 才算成功杀死变异体
4. `precondition=False` 且 `postcondition=False` 会单独记为失败类型
5. 每个变异体单独记分，分母是它自己的 `different_output_cases`

## 报告格式

每道题一个 JSON 文件，例如：

```text
test_reports/<模型>_<时间戳>/HumanEval_8.json
```

单题报告里的关键字段：

- `syntax_correct`：文件能否正常 import
- `spec_correct`：包装后的完整函数是否通过整题测试
- `postcondition_correct_without_precondition`：忽略 `precondition`，直接运行 `_impl` 后，`postcondition` 是否仍对整题测试成立
- `accuracy`：该题通过的 case 比例
- `unrestricted_accuracy`：忽略 `precondition` 时的 case 比例
- `failure_type`：首个失败类别
- `first_failure`：首个失败样例

整体汇总在：

```text
test_reports/<模型>_<时间戳>/_summary.json
```

汇总里的关键字段：

- `syntax_correct_tasks`
- `spec_correct_tasks`
- `postcondition_correct_without_precondition_tasks`
- `case_accuracy`
- `unrestricted_case_accuracy`

负向测试的单题报告还会额外包含：

- `different_output_cases`
- `same_output_cases`
- `mutations`
- `failure_examples`

其中 `mutations` 是一个列表，每个变异体都会单独记录：

- `passed_cases`
- `failed_cases`
- `total_cases`
- `different_output_cases`
- `same_output_cases`
- `accuracy`
- `failure_examples`

## 当前结果

当前已经测试过的结果：

- `gpt-5-nano`：[test_reports/gpt-5-nano_20260315_031120/_summary.json](/home/yangfp/TestSpec/test_reports/gpt-5-nano_20260315_031120/_summary.json)
- `gpt-5-mini`：[test_reports/gpt-5-mini_20260316_012906/_summary.json](/home/yangfp/TestSpec/test_reports/gpt-5-mini_20260316_012906/_summary.json)
- `gpt-5`：[test_reports/gpt-5_20260316_013133/_summary.json](/home/yangfp/TestSpec/test_reports/gpt-5_20260316_013133/_summary.json)
- `deepseek-v3.2`：[test_reports/deepseek-v3.2_20260316_013133/_summary.json](/home/yangfp/TestSpec/test_reports/deepseek-v3.2_20260316_013133/_summary.json)

任务级指标对比：

| 模型 | 语法正确率 | 规约正确率 | 不限制前条件的后条件正确率 |
|---|---:|---:|---:|
| `gpt-5-nano` | `157/164` | `130/164` | `153/164` |
| `gpt-5-mini` | `157/164` | `117/164` | `152/164` |
| `gpt-5` | `156/164` | `129/164` | `152/164` |
| `deepseek-v3.2` | `157/164` | `113/164` | `151/164` |

这里三列分别表示：

- 语法正确率：生成文件能否正常导入
- 规约正确率：包装后的完整函数是否通过整题测试
- 不限制前条件的后条件正确率：忽略 `precondition` 后，只看 `_impl` 输出是否满足 `postcondition`

## 反例测试结果

当前已经完成的反例测试结果：

- `gpt-5-nano`：[negative_report/gpt-5-nano_20260315_031120/_summary.json](/home/yangfp/TestSpec/negative_report/gpt-5-nano_20260315_031120/_summary.json)
- `gpt-5-mini`：[negative_report/gpt-5-mini_20260316_012906/_summary.json](/home/yangfp/TestSpec/negative_report/gpt-5-mini_20260316_012906/_summary.json)
- `gpt-5`：[negative_report/gpt-5_20260316_013133/_summary.json](/home/yangfp/TestSpec/negative_report/gpt-5_20260316_013133/_summary.json)
- `deepseek-v3.2`：[negative_report/deepseek-v3.2_20260316_013133/_summary.json](/home/yangfp/TestSpec/negative_report/deepseek-v3.2_20260316_013133/_summary.json)

任务级与变异体级指标对比：

| 模型 | 负向任务通过率 | 负样例正确率 | 变异体通过率 |
|---|---:|---:|---:|
| `gpt-5-nano` | `77/164` | `224930/270236 = 0.8323` | `527/654 = 0.8058` |
| `gpt-5-mini` | `70/164` | `219730/269747 = 0.8146` | `497/649 = 0.7658` |
| `gpt-5` | `72/164` | `219692/270235 = 0.8130` | `498/654 = 0.7615` |
| `deepseek-v3.2` | `54/164` | `178240/264330 = 0.6743` | `391/650 = 0.6015` |

这里三列分别表示：

- 负向任务通过率：一整题里的所有变异体都必须被规约正确处理，题目才算通过
- 负样例正确率：在所有 `different_output_cases` 里，有多少比例满足 `precondition=True` 且 `postcondition=False`
- 变异体通过率：有多少个 `mutation_*.py` 在自己的全部 `different_output_cases` 上都被成功杀死

正向与负向对照：

| 模型 | 正向规约正确率 | 负向任务通过率 | 负向变异体通过率 |
|---|---:|---:|---:|
| `gpt-5-nano` | `130/164` | `77/164` | `527/654` |
| `gpt-5-mini` | `117/164` | `70/164` | `497/649` |
| `gpt-5` | `129/164` | `72/164` | `498/654` |
| `deepseek-v3.2` | `113/164` | `54/164` | `391/650` |

这说明正向测试通过并不代表规约足够强。很多题在官方测试上是对的，但一旦换成错误实现，`postcondition` 仍可能放行。

## Mutation 数据修正

`humaneval_mutations/` 原始数据里有 10 个文件存在明显的结构错误：函数名和题目真实 `entry_point` 不一致，导致负向测试直接报 `missing_mutation_entry_point`。这些文件已经修成了同题签名下的轻微错误实现。

修复后：

- `humaneval_mutations/**/*.py` 的 Python 语法错误数：`0`
- 缺失 `entry_point` 的 mutation 文件数：`0`

这些修复不会让 mutation 变成正确实现，只是去掉了机械性坏数据，使负向测试真正测的是规约本身，而不是数据集文件名或函数名写错。

## 为什么自然语言里经常看不出前条件

是的，很多题目只看自然语言描述，实际上看不出严格的前条件边界。

原因有几个：

1. 题目通常只描述“目标行为”，不描述“非法输入怎么处理”
2. 数据集测试往往默认 Python 的动态类型行为，而不是一个严格静态类型系统
3. 很多题目没有明确说输入必须是 `list[int]`、不能是 `bool`、不能是空字符串、不能是其他可迭代对象
4. 题面经常只给正例，不给反例，所以模型容易把“常见输入”误当成“唯一合法输入”

因此如果只依据自然语言，模型很容易把 `precondition` 写得过强。例如：

- 题面说“给定一个整数列表”，模型就可能强行要求一定是 `list[int]`
- 但官方测试可能会传入更宽松、仍然可工作的输入

所以这个项目里经常会出现：

- `spec_correct = false`
- 但 `postcondition_correct_without_precondition = true`

这通常说明：

- 问题主要不在 `postcondition`
- 而在 `precondition` 把输入卡得太死

换句话说，仅凭自然语言，确实很难恢复出一个“既安全又不过强”的前条件。

## 典型错误分析

### 1. `precondition` 过强

例子：
[HumanEval_8.json](/home/yangfp/TestSpec/test_reports/gpt-5-nano_20260315_031120/HumanEval_8.json)
[HumanEval_8.py](/home/yangfp/TestSpec/output/gpt-5-nano_20260315_031120/HumanEval_8.py)

任务是 `sum_product(numbers)`。

自然语言描述：

- 输入：一个整数列表 `numbers`
- 输出：一个二元组 `(sum, product)`，分别表示列表元素之和与元素之积
- 题面示例：空列表应返回 `(0, 1)`

生成出的 `precondition` 要求：

```python
if not isinstance(numbers, list):
    return False
for x in numbers:
    if not isinstance(x, int):
        return False
```

首个失败样例是：

```json
"input": [""]
```

这里的问题不是实现错了，而是 `precondition` 过强。  
从报告可以看到：

- `spec_correct = false`
- `postcondition_correct_without_precondition = true`

这说明：

- `_impl` 在官方测试上其实是对的
- 失败来自前条件过度约束

### 2. `postcondition` 和实现语义不一致

例子：
[HumanEval_30.json](/home/yangfp/TestSpec/test_reports/gpt-5_20260316_013133/HumanEval_30.json)
[HumanEval_30.py](/home/yangfp/TestSpec/output/gpt-5_20260316_013133/HumanEval_30.py)

任务是 `get_positive(l)`。

自然语言描述：

- 输入：一个列表 `l`
- 输出：只保留其中正数后的新列表
- 题面示例：`[-1, 2, -4, 5, 6] -> [2, 5, 6]`

生成出的 `postcondition` 里把 `bool` 排除掉：

```python
def is_positive(x):
    if isinstance(x, bool):
        return False
```

但实现是：

```python
return list(filter(lambda x: x > 0, l))
```

在 Python 里：

- `True > 0` 为真
- 所以实现会保留 `True`
- 但 `postcondition` 却认定 `True` 不是合法正数

首个失败样例：

```json
"input": [[false, true, false, false, true]]
```

这是典型的：

- 题意没有说清 bool 是否应该算数值
- 规约与 Python 实际行为不一致

### 3. 生成结果存在语法错误

例子：
[HumanEval_49.json](/home/yangfp/TestSpec/test_reports/gpt-5_20260316_013133/HumanEval_49.json)
[HumanEval_49.py](/home/yangfp/TestSpec/output/gpt-5_20260316_013133/HumanEval_49.py)

自然语言描述：

- 输入：两个整数 `n, p`
- 输出：`2^n mod p`
- 题面示例：返回 `2` 的 `n` 次幂对 `p` 取模后的结果

坏掉的代码是：

```python
def postcondition(input, output) -> bool:
    try
        :
```

这类错误的特点是：

- 文件根本 import 不进来
- 直接记为 `syntax_error`
- 后续行为测试不会再进行

### 4. `postcondition` 太慢，不是逻辑死循环

例子：
[HumanEval_163.json](/home/yangfp/TestSpec/test_reports/gpt-5-mini_20260316_012906/HumanEval_163.json)
[HumanEval_163.py](/home/yangfp/TestSpec/output/gpt-5-mini_20260316_012906/HumanEval_163.py)

自然语言描述：

- 输入：两个正整数 `a, b`
- 输出：`a` 和 `b` 之间的偶数字，按升序返回
- 题面示例：
  - `generate_integers(2, 8) -> [2, 4, 6, 8]`
  - `generate_integers(8, 2) -> [2, 4, 6, 8]`
  - `generate_integers(10, 14) -> []`

它的 `postcondition` 里有：

```python
expected = [d for d in range(lo, hi + 1) if 0 <= d <= 9 and d % 2 == 0]
```

对这种输入：

- `(1, 100000)`
- `(987654321, 123456789)`

这段代码会遍历超大区间。

所以这里不是传统意义上的死循环，而是：

- 实现 `_impl` 很快
- `postcondition` 因为线性扫描大区间而极慢
- 最终被 `--task-timeout 30` 记为 `task_timeout`

这里还可以抽象出一条更强的工程规则：

- `postcondition` 不能比 `_impl` 慢太多
- 最好与 `_impl` 保持同一时间复杂度
- 至少不能把一个近似 `O(1)` 或 `O(n)` 的实现，验证成 `O(range)`、`O(n^2)` 甚至更差

`HumanEval_163` 就是一个非常典型的反例。

在这个例子里，`_impl` 实际上是近似常数级的，因为它最多只会扫描到 `10`：

```python
return [i for i in range(a, min(b + 1, 10)) if i % 2 == 0]
```

但 `postcondition` 却写成了对整个区间 `[lo, hi]` 做遍历：

```python
expected = [d for d in range(lo, hi + 1) if 0 <= d <= 9 and d % 2 == 0]
```

这就把复杂度从近似常数级，放大成了 `O(|a-b|)`。

对一些大输入，`_impl` 的实际运行时间只有微秒级，例如：

- `(1, 100000)`：约 `0.60 us`
- `(987654321, 123456789)`：约 `0.32 us`
- `(123456792, 123456791)`：约 `0.27 us`

也就是说：

- 实现本身非常快
- 真正慢的是规约检查

所以在这个项目里，一个好的 `postcondition` 不仅要逻辑上正确，还要满足：

- 不要比 `_impl` 高一个数量级以上
- 不要为了验证输出，再做一次明显更重的全量求解

### 5. `postcondition` 几乎就是另一份实现

这类问题也很重要。

它和“前条件过强”不同。  
这里的问题不是拒绝了输入，而是：

- `postcondition` 没有描述结果应满足的性质
- 而是在里面又写了一遍求解过程

这种写法的风险是：

1. 它不是独立规约，而是“第二份实现”
2. 如果实现和 `postcondition` 刚好共享同一类错误，测试不一定能发现

好的 `postcondition` 更应该描述：

- 输出类型
- 排序性、去重性、范围约束
- 输出和输入之间的不变量

而不是：

- 先重新算一个 `expected`
- 再直接 `return output == expected`

下面是几个典型例子。

#### 例子 5.1：`HumanEval_8`，`postcondition` 重新算和与积

文件：
[HumanEval_8.py](/home/yangfp/TestSpec/output/gpt-5-nano_20260315_031120/HumanEval_8.py)

自然语言描述：

- 输入：整数列表 `numbers`
- 输出：`(sum(numbers), product(numbers))`

它的 `postcondition` 直接做：

```python
s = sum(numbers)
p = 1
for x in numbers:
    p *= x
return output[0] == s and output[1] == p
```

而 `_impl` 本身也是：

```python
for number in numbers:
    s += number
    p *= number
```

两边只是表面写法略有不同，本质上是在重复实现同一个算法。

#### 例子 5.2：`HumanEval_0`，`postcondition` 重新求解“是否存在接近元素”

文件：
[HumanEval_0.py](/home/yangfp/TestSpec/output/gpt-5-nano_20260315_031120/HumanEval_0.py)

自然语言描述：

- 输入：浮点数列表 `numbers`，以及阈值 `threshold`
- 输出：是否存在两个元素，它们之间的差值小于 `threshold`
- 题面示例：
  - `has_close_elements([1.0, 2.0, 3.0], 0.5) -> False`
  - `has_close_elements([1.0, 2.8, 3.0, 4.0, 5.0, 2.0], 0.3) -> True`

`_impl` 的核心方法是先排序，再检查相邻元素：

```python
sorted_numbers = sorted(numbers)
for i in range(len(sorted_numbers) - 1):
    if sorted_numbers[i + 1] - sorted_numbers[i] < threshold:
        return True
```

而 `postcondition` 则写成：

```python
expected = False
for i in range(n):
    for j in range(i + 1, n):
        if abs(numbers[i] - numbers[j]) < threshold:
            expected = True
            break
return bool(output) == expected
```

虽然两边算法形式不同：

- 一个是排序后看相邻元素
- 一个是双重循环枚举所有数对

但本质上它们都在“重新做一遍求解”，而不是只检查高层性质。

#### 例子 5.3：`HumanEval_97`，`postcondition` 直接重算公式

文件：
[HumanEval_97.py](/home/yangfp/TestSpec/output/gpt-5-mini_20260316_012906/HumanEval_97.py)

自然语言描述：

- 输入：两个整数 `a, b`
- 输出：它们个位数字的乘积
- 题面示例：
  - `multiply(148, 412) -> 16`
  - `multiply(19, 28) -> 72`
  - `multiply(2020, 1851) -> 0`

它的 `postcondition` 直接写成：

```python
return isinstance(output, int) and output == (a % 10) * (b % 10)
```

这种题看起来很自然，但从规约角度说，它依然是：

- 直接把求值公式搬进 `postcondition`
- 而不是从更抽象的性质上去约束输出

### 这类问题为什么危险

如果 `postcondition` 只是另一份实现，那么：

- 规约失去独立性
- 实现和规约可能共享同一个 bug
- 测试更像是在比对两份实现，而不是拿规约约束实现

所以更理想的写法通常是：

- 排序题：检查输出是否有序、元素是否守恒
- 过滤题：检查输出是否只包含满足条件的元素，且不漏不重
- 数值题：检查方程、范围、单调性、不变量，而不是完整重算答案

## 如何理解这些指标

最有参考价值的通常是：

- `spec_correct_tasks`

`spec_correct_tasks` 和 `postcondition_correct_without_precondition_tasks` 之间的差值，通常反映：

- `precondition` 过强带来的损失

`syntax_correct_tasks` 和 `postcondition_correct_without_precondition_tasks` 之间的差值，通常反映：

- `postcondition` 写错
- 语法错误
- 超时问题

如果一个模型：

- `spec_correct_tasks` 不高
- 但 `postcondition_correct_without_precondition_tasks` 很高

那通常说明它的问题更多在 `precondition`，不是在核心行为刻画本身。
