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
python3 generate_specs.py --api-model claude-sonnet-4-6
python3 generate_specs.py --api-model claude-opus-4-6
python3 generate_specs.py --api-model gpt-5-nano
python3 generate_specs.py --api-model gpt-5-mini
python3 generate_specs.py --api-model gpt-5
python3 generate_specs.py --api-model deepseek-v3.2
```

当前默认模型已经是 `claude-sonnet-4-6`，所以也可以直接运行：

```bash
python3 generate_specs.py
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
5. 如果变异实现本身运行时报错，会记为 `mutation_runtime_error`，并按“该变异体已被杀死”处理，不再算规约错误
6. 每个变异体单独记分，分母是它自己的 `different_output_cases`

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

- `gpt-5-nano`：[test_reports/gpt-5-nano_20260318_151556/_summary.json](/home/yangfp/TeSpec/test_reports/gpt-5-nano_20260318_151556/_summary.json)
- `gpt-5-mini`：[test_reports/gpt-5-mini_20260316_012906/_summary.json](/home/yangfp/TeSpec/test_reports/gpt-5-mini_20260316_012906/_summary.json)
- `gpt-5`：[test_reports/gpt-5_20260316_013133/_summary.json](/home/yangfp/TeSpec/test_reports/gpt-5_20260316_013133/_summary.json)
- `deepseek-v3.2`：[test_reports/deepseek-v3.2_20260316_013133/_summary.json](/home/yangfp/TeSpec/test_reports/deepseek-v3.2_20260316_013133/_summary.json)
- `claude-opus-4-5-20251101`：[test_reports/claude-opus-4-5-20251101_20260316_143850/_summary.json](/home/yangfp/TeSpec/test_reports/claude-opus-4-5-20251101_20260316_143850/_summary.json)
- `claude-sonnet-4-6`：[test_reports/claude-sonnet-4-6_20260316_143850/_summary.json](/home/yangfp/TeSpec/test_reports/claude-sonnet-4-6_20260316_143850/_summary.json)
- `claude-opus-4-6`：[test_reports/claude-opus-4-6_20260316_143850/_summary.json](/home/yangfp/TeSpec/test_reports/claude-opus-4-6_20260316_143850/_summary.json)
- `gemini-3-pro-preview`：[test_reports/gemini-3-pro-preview_20260317_120447/_summary.json](/home/yangfp/TeSpec/test_reports/gemini-3-pro-preview_20260317_120447/_summary.json)
- `gemini-3.1-pro-preview`：[test_reports/gemini-3.1-pro-preview_20260317_120447/_summary.json](/home/yangfp/TeSpec/test_reports/gemini-3.1-pro-preview_20260317_120447/_summary.json)
- `gemini-3.1-flash-lite-preview`：[test_reports/gemini-3.1-flash-lite-preview_20260317_120447/_summary.json](/home/yangfp/TeSpec/test_reports/gemini-3.1-flash-lite-preview_20260317_120447/_summary.json)

当前统计已经排除了后处理引入的三类机械性错误：

- docstring 重建导致的 `""""`
- 只取第一个 `def` 导致的 `missing_entry_point`
- prompt 顶层辅助定义未被一起打包，导致 `_impl` 运行时报 `NameError`

下面的结果都是修复这些问题后重新生成并重跑得到的。

任务级指标对比：

| 模型 | 语法正确率 | 规约正确率 | 不限制前条件的后条件正确率 |
|---|---:|---:|---:|
| `gpt-5-nano` | `164/164` | `137/164` | `162/164` |
| `gpt-5-mini` | `164/164` | `126/164` | `162/164` |
| `gpt-5` | `163/164` | `139/164` | `162/164` |
| `deepseek-v3.2` | `164/164` | `120/164` | `161/164` |
| `claude-opus-4-5-20251101` | `164/164` | `135/164` | `162/164` |
| `claude-sonnet-4-6` | `164/164` | `135/164` | `162/164` |
| `claude-opus-4-6` | `164/164` | `134/164` | `162/164` |
| `gemini-3-pro-preview` | `164/164` | `143/164` | `162/164` |
| `gemini-3.1-pro-preview` | `164/164` | `148/164` | `162/164` |
| `gemini-3.1-flash-lite-preview` | `164/164` | `133/164` | `161/164` |

这里三列分别表示：

- 语法正确率：生成文件能否正常导入
- 规约正确率：包装后的完整函数是否通过整题测试
- 不限制前条件的后条件正确率：忽略 `precondition` 后，只看 `_impl` 输出是否满足 `postcondition`

逐层收缩表 1：严格要求前条件和后条件

这里三列是逐层收缩的集合，后一列一定是前一列的子集：

1. 语法正确
2. 正例上 `precondition` 和 `postcondition` 都正确
3. 正例上 `precondition` 和 `postcondition` 都正确，且负例上也满足“`precondition=True` 且 `postcondition=False`”

| 模型 | 语法正确 | 正例前后条件都正确 | 正例前后条件都正确且负例也正确 |
|---|---:|---:|---:|
| `gpt-5-nano` | `164/164` | `137/164` | `113/164` |
| `gpt-5-mini` | `164/164` | `126/164` | `107/164` |
| `gpt-5` | `163/164` | `139/164` | `108/164` |
| `deepseek-v3.2` | `164/164` | `120/164` | `73/164` |
| `claude-opus-4-5-20251101` | `164/164` | `135/164` | `114/164` |
| `claude-sonnet-4-6` | `164/164` | `135/164` | `101/164` |
| `claude-opus-4-6` | `164/164` | `134/164` | `113/164` |
| `gemini-3-pro-preview` | `164/164` | `143/164` | `114/164` |
| `gemini-3.1-pro-preview` | `164/164` | `148/164` | `91/164` |
| `gemini-3.1-flash-lite-preview` | `164/164` | `133/164` | `86/164` |

逐层收缩表 2：忽略前条件，其他保持不变

这里仍然是逐层收缩的集合，后一列一定是前一列的子集：

1. 语法正确
2. 正例上忽略 `precondition` 后，`postcondition` 仍正确
3. 正例上忽略 `precondition` 后 `postcondition` 正确，且负例上也满足“忽略 `precondition` 时，错误输出都会让 `postcondition=False`”

| 模型 | 语法正确 | 正例忽略前条件后后条件正确 | 正例忽略前条件后正确且负例也正确 |
|---|---:|---:|---:|
| `gpt-5-nano` | `164/164` | `162/164` | `131/164` |
| `gpt-5-mini` | `164/164` | `162/164` | `125/164` |
| `gpt-5` | `163/164` | `162/164` | `121/164` |
| `deepseek-v3.2` | `164/164` | `161/164` | `95/164` |
| `claude-opus-4-5-20251101` | `164/164` | `162/164` | `132/164` |
| `claude-sonnet-4-6` | `164/164` | `162/164` | `117/164` |
| `claude-opus-4-6` | `164/164` | `162/164` | `130/164` |
| `gemini-3-pro-preview` | `164/164` | `162/164` | `126/164` |
| `gemini-3.1-pro-preview` | `164/164` | `162/164` | `99/164` |
| `gemini-3.1-flash-lite-preview` | `164/164` | `161/164` | `104/164` |

## 反例测试结果

当前已经完成的反例测试结果：

- `gpt-5-nano`：[negative_report/gpt-5-nano_20260318_151556/_summary.json](/home/yangfp/TeSpec/negative_report/gpt-5-nano_20260318_151556/_summary.json)
- `gpt-5-mini`：[negative_report/gpt-5-mini_20260316_012906/_summary.json](/home/yangfp/TeSpec/negative_report/gpt-5-mini_20260316_012906/_summary.json)
- `gpt-5`：[negative_report/gpt-5_20260316_013133/_summary.json](/home/yangfp/TeSpec/negative_report/gpt-5_20260316_013133/_summary.json)
- `deepseek-v3.2`：[negative_report/deepseek-v3.2_20260316_013133/_summary.json](/home/yangfp/TeSpec/negative_report/deepseek-v3.2_20260316_013133/_summary.json)
- `claude-opus-4-5-20251101`：[negative_report/claude-opus-4-5-20251101_20260316_143850/_summary.json](/home/yangfp/TeSpec/negative_report/claude-opus-4-5-20251101_20260316_143850/_summary.json)
- `claude-sonnet-4-6`：[negative_report/claude-sonnet-4-6_20260316_143850/_summary.json](/home/yangfp/TeSpec/negative_report/claude-sonnet-4-6_20260316_143850/_summary.json)
- `claude-opus-4-6`：[negative_report/claude-opus-4-6_20260316_143850/_summary.json](/home/yangfp/TeSpec/negative_report/claude-opus-4-6_20260316_143850/_summary.json)
- `gemini-3-pro-preview`：[negative_report/gemini-3-pro-preview_20260317_120447/_summary.json](/home/yangfp/TeSpec/negative_report/gemini-3-pro-preview_20260317_120447/_summary.json)
- `gemini-3.1-pro-preview`：[negative_report/gemini-3.1-pro-preview_20260317_120447/_summary.json](/home/yangfp/TeSpec/negative_report/gemini-3.1-pro-preview_20260317_120447/_summary.json)
- `gemini-3.1-flash-lite-preview`：[negative_report/gemini-3.1-flash-lite-preview_20260317_120447/_summary.json](/home/yangfp/TeSpec/negative_report/gemini-3.1-flash-lite-preview_20260317_120447/_summary.json)

尚未完成反例测试的模型：

- `claude-3-7-sonnet-20250219`
- `gemini-3-flash-preview`

任务级与变异体级指标对比：

| 模型 | 负向任务通过率 | 负样例正确率 | 变异体通过率 |
|---|---:|---:|---:|
| `gpt-5-nano` | `124/164` | `272195/281036 = 0.9685` | `619/673 = 0.9198` |
| `gpt-5-mini` | `120/164` | `269329/281037 = 0.9583` | `607/673 = 0.9019` |
| `gpt-5` | `120/164` | `268276/281528 = 0.9529` | `605/678 = 0.8923` |
| `deepseek-v3.2` | `86/164` | `228300/282163 = 0.8091` | `491/683 = 0.7189` |
| `claude-opus-4-5-20251101` | `123/164` | `264683/282160 = 0.9381` | `614/683 = 0.8990` |
| `claude-sonnet-4-6` | `109/164` | `257608/281673 = 0.9146` | `577/678 = 0.8510` |
| `claude-opus-4-6` | `122/164` | `275413/281669 = 0.9778` | `618/678 = 0.9115` |
| `gemini-3-pro-preview` | `121/164` | `270423/282165 = 0.9584` | `614/683 = 0.8990` |
| `gemini-3.1-pro-preview` | `95/164` | `222723/281673 = 0.7907` | `514/678 = 0.7581` |
| `gemini-3.1-flash-lite-preview` | `94/164` | `229906/281036 = 0.8181` | `505/673 = 0.7504` |

这里三列分别表示：

- 负向任务通过率：一整题里的所有变异体都必须被正确处理，题目才算通过
- 负样例正确率：在所有 `different_output_cases` 里，有多少比例被判成“已杀死变异体”；当前这既包括 `precondition=True` 且 `postcondition=False`，也包括变异实现自身运行报错的 `mutation_runtime_error`
- 变异体通过率：有多少个 `mutation_*.py` 在自己的全部 `different_output_cases` 上都被成功处理

正向与负向对照：

| 模型 | 正向规约正确率 | 负向任务通过率 | 负向变异体通过率 |
|---|---:|---:|---:|
| `gpt-5-nano` | `137/164` | `124/164` | `619/673` |
| `gpt-5-mini` | `126/164` | `120/164` | `607/673` |
| `gpt-5` | `139/164` | `120/164` | `605/678` |
| `deepseek-v3.2` | `120/164` | `86/164` | `491/683` |
| `claude-opus-4-5-20251101` | `135/164` | `123/164` | `614/683` |
| `claude-sonnet-4-6` | `135/164` | `109/164` | `577/678` |
| `claude-opus-4-6` | `134/164` | `122/164` | `618/678` |
| `gemini-3-pro-preview` | `143/164` | `121/164` | `614/683` |
| `gemini-3.1-pro-preview` | `148/164` | `95/164` | `514/678` |
| `gemini-3.1-flash-lite-preview` | `133/164` | `94/164` | `505/673` |

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

## 典型案例分析

这些例子大致可以分成两类。

### 第一类：模型确实把规约写坏了

这类问题可以明确归因到模型输出质量本身。即使不讨论自然语言边界，也能看出规约写错了。

#### 0. 跨模型共同错误：所有模型都会反复踩到的坑

有些题几乎所有模型都会在同一个地方失败，这更像是“系统性错误模式”。

例子 A：
[HumanEval_8.json](/home/yangfp/TeSpec/test_reports/gpt-5-nano_20260318_151556/HumanEval_8.json)
[HumanEval_8.json](/home/yangfp/TeSpec/test_reports/gpt-5-mini_20260316_012906/HumanEval_8.json)
[HumanEval_8.json](/home/yangfp/TeSpec/test_reports/gpt-5_20260316_013133/HumanEval_8.json)
[HumanEval_8.json](/home/yangfp/TeSpec/test_reports/deepseek-v3.2_20260316_013133/HumanEval_8.json)
[HumanEval_8.json](/home/yangfp/TeSpec/test_reports/claude-opus-4-5-20251101_20260316_143850/HumanEval_8.json)
[HumanEval_8.json](/home/yangfp/TeSpec/test_reports/claude-sonnet-4-6_20260316_143850/HumanEval_8.json)
[HumanEval_8.json](/home/yangfp/TeSpec/test_reports/claude-opus-4-6_20260316_143850/HumanEval_8.json)
[HumanEval_8.json](/home/yangfp/TeSpec/test_reports/gemini-3-pro-preview_20260317_120447/HumanEval_8.json)
[HumanEval_8.json](/home/yangfp/TeSpec/test_reports/gemini-3.1-pro-preview_20260317_120447/HumanEval_8.json)
[HumanEval_8.json](/home/yangfp/TeSpec/test_reports/gemini-3.1-flash-lite-preview_20260317_120447/HumanEval_8.json)

这题在 10 个模型上都是 `precondition_failed`。  
它说明：只靠自然语言写前条件时，模型很容易把输入域收得过窄。

例子 B：
[HumanEval_145.json](/home/yangfp/TeSpec/test_reports/gpt-5-nano_20260318_151556/HumanEval_145.json)
[HumanEval_145.json](/home/yangfp/TeSpec/test_reports/gpt-5-mini_20260316_012906/HumanEval_145.json)
[HumanEval_145.json](/home/yangfp/TeSpec/test_reports/gpt-5_20260316_013133/HumanEval_145.json)
[HumanEval_145.json](/home/yangfp/TeSpec/test_reports/deepseek-v3.2_20260316_013133/HumanEval_145.json)
[HumanEval_145.json](/home/yangfp/TeSpec/test_reports/claude-opus-4-5-20251101_20260316_143850/HumanEval_145.json)
[HumanEval_145.json](/home/yangfp/TeSpec/test_reports/claude-sonnet-4-6_20260316_143850/HumanEval_145.json)
[HumanEval_145.json](/home/yangfp/TeSpec/test_reports/claude-opus-4-6_20260316_143850/HumanEval_145.json)
[HumanEval_145.json](/home/yangfp/TeSpec/test_reports/gemini-3-pro-preview_20260317_120447/HumanEval_145.json)
[HumanEval_145.json](/home/yangfp/TeSpec/test_reports/gemini-3.1-pro-preview_20260317_120447/HumanEval_145.json)
[HumanEval_145.json](/home/yangfp/TeSpec/test_reports/gemini-3.1-flash-lite-preview_20260317_120447/HumanEval_145.json)

这题在 10 个模型上都是 `postcondition_failed`。  
它说明：有些题即使前条件没写坏，`postcondition` 仍会系统性地把正确实现错杀。

#### 1. `postcondition` 和实现语义不一致

例子：
[HumanEval_30.json](/home/yangfp/TeSpec/test_reports/gpt-5_20260316_013133/HumanEval_30.json)
[HumanEval_30.py](/home/yangfp/TeSpec/output/gpt-5_20260316_013133/HumanEval_30.py)

任务是 `get_positive(l)`。

自然语言描述：

- 输入：一个列表 `l`
- 输出：只保留其中正数后的新列表
- 题面示例：`[-1, 2, -4, 5, 6] -> [2, 5, 6]`

生成出的规约是：

```python
def precondition(input) -> bool:
    return isinstance(input, tuple) and len(input) == 1 and isinstance(input[0], list)

def postcondition(input, output) -> bool:
    if not precondition(input):
        return True
    l = input[0]
    if not isinstance(output, list):
        return False

    def is_positive(x):
        if isinstance(x, bool):
            return False
        ...
    expected = [x for x in l if is_positive(x)]
    return output == expected
```

实现本身则是：

```python
def _impl(l: list):
    return list(filter(lambda x: x > 0, l))
```

具体失败样例：

```json
{
  "input": [[false, true, false, false, true]],
  "expected": [true, true],
  "failure_type": "postcondition_failed"
}
```

这里官方期望输出是 `[True, True]`，因为在 Python 里 `True > 0` 为真。  
但规约里的 `is_positive` 把 `bool` 单独排除了，所以：

- `_impl` 输出：`[True, True]`
- `postcondition` 期望：`[]`
- 最终表现：正确实现被 `postcondition` 错杀

这说明这里不是前条件问题，而是 `postcondition` 本身和 Python 语义不一致。

#### 2. 生成结果存在语法错误

例子：
[HumanEval_49.json](/home/yangfp/TeSpec/test_reports/gpt-5_20260316_013133/HumanEval_49.json)
[HumanEval_49.py](/home/yangfp/TeSpec/output/gpt-5_20260316_013133/HumanEval_49.py)

这些例子里，语法错误并不是一个模糊概念，而是能精确指出“哪一行坏了、怎么坏了”。

`gpt-5` 在 `HumanEval_49` 上的坏代码是：

```python
def postcondition(input, output) -> bool:
    try
        :
```

对应测试报告里写得也很明确：

- 模型：`gpt-5`
- 文件：[HumanEval_49.py](/home/yangfp/TeSpec/output/gpt-5_20260316_013133/HumanEval_49.py)
- 错误：`SyntaxError: expected ':' (line 18)`

也就是说这里不是“逻辑上有点问题”，而是 `try:` 这一行连 Python 语法都没写对。

目前仓库里仍然保留、且会影响结果统计的语法错误代表例子主要是这一类：

1. 控制结构写坏了
   例子：`try` 后面缺少 `:`

这类错误的共同特点是：

- 文件根本 import 不进来
- 直接记为 `syntax_error`
- 正负例测试都无法正常展开

`HumanEval/49` 这种情况可以看成最直接的模型失败：

- 自然语言描述本身没有歧义
- 不是规约太弱或太强
- 就是生成出来的 Python 代码本身不合法

#### 3. `postcondition` 太慢，复杂度明显失配

例子：
[HumanEval_163.json](/home/yangfp/TeSpec/test_reports/gpt-5-mini_20260316_012906/HumanEval_163.json)
[HumanEval_163.py](/home/yangfp/TeSpec/output/gpt-5-mini_20260316_012906/HumanEval_163.py)

自然语言描述：

- 输入：两个正整数 `a, b`
- 输出：`a` 和 `b` 之间的偶数字，按升序返回

它的 `postcondition` 里有：

```python
expected = [d for d in range(lo, hi + 1) if 0 <= d <= 9 and d % 2 == 0]
```

对 `(1, 100000)`、`(987654321, 123456789)` 这类输入会遍历超大区间。  
但 `_impl` 本身是近似常数级：

```python
return [i for i in range(a, min(b + 1, 10)) if i % 2 == 0]
```

实测 `_impl` 只有微秒级：

- `(1, 100000)`：约 `0.60 us`
- `(987654321, 123456789)`：约 `0.32 us`
- `(123456792, 123456791)`：约 `0.27 us`

这里的问题非常明确：

- 实现不慢
- 慢的是 `postcondition`
- 规约复杂度明显高于实现复杂度

如果把这个例子展开成“输入 / 输出 / 规约”的形式，就是：

- 自然语言要求：返回区间内的偶数字，且结果只会落在 `0..9`
- 实现 `_impl`：只遍历到 `min(b + 1, 10)`
- 规约 `postcondition`：却遍历整个 `[min(a,b), max(a,b)]`

典型大输入测试用例：

```python
generate_integers(1, 100000)
generate_integers(987654321, 123456789)
```

这些输入下：

- `_impl` 很快得到 `[]` 或很短的列表
- `postcondition` 却要枚举一个超大整数区间
- 结果整题被记为 `task_timeout`

#### 4. 正例和负例都抓不住，说明 `postcondition` 太弱

例子：
[HumanEval_141.json](/home/yangfp/TeSpec/test_reports/gpt-5_20260316_013133/HumanEval_141.json)
[HumanEval_145.json](/home/yangfp/TeSpec/test_reports/gpt-5_20260316_013133/HumanEval_145.json)
[HumanEval_91.json](/home/yangfp/TeSpec/negative_report/gpt-5_20260316_013133/HumanEval_91.json)

这类题的共同特征是：

- 正例上已经出现 `postcondition_failed`
- 负例上还会出现 `postcondition_survived`

也就是说：

- 正确输出有时会被错杀
- 错误输出有时又被放过

这种情况说明 `postcondition` 既不稳定，也不够精确，是最典型的“模型真的写坏了规约”。

这类例子的阅读方式是：

- 看正例报告里的 `postcondition_failed`
- 再看负例报告里的 `postcondition_survived`

如果两边同时出现，就说明：

- 对正确输出，规约会误杀
- 对错误输出，规约又会放行

这种规约基本不能用。

#### 5. 正例能过，但负例过不了，说明 `postcondition` 只约束了“像是对的”，没有约束“必须就是对的”

这类题是最值得单独看的，因为它们说明：

- 官方正例测试不够强时，生成规约可能顺利通过
- 但一旦换成错误实现，`postcondition` 只检查了宽松性质，抓不住真正的错误输出

下面给几个更具体的例子。

例子 A：`gpt-5-nano` 在 `HumanEval/4` 上把数值容差放得过宽
[HumanEval_4.py](/home/yangfp/TeSpec/output/gpt-5-nano_20260318_151556/HumanEval_4.py)
[HumanEval_4.json](/home/yangfp/TeSpec/negative_report/gpt-5-nano_20260318_151556/HumanEval_4.json)

任务是 `mean_absolute_deviation(numbers)`。

自然语言描述：

- 输入：一个数值列表
- 输出：这些数围绕均值的平均绝对偏差

生成规约的核心是：

```python
mean = sum(nums) / n
expected = sum(abs(x - mean) for x in nums) / n
return math.isclose(output, expected, rel_tol=1e-9, abs_tol=1e-9)
```

这题正例能过，但负例里有一个非常小的数值边界失败：

```json
{
  "input": [[1e-308]],
  "original_output": 0.0,
  "mutation_output": 2e-308,
  "failure_type": "postcondition_survived"
}
```

这里正确输出应该是 `0.0`，但变异输出变成了 `2e-308`。  
由于 `postcondition` 用了比较宽松的 `math.isclose(..., abs_tol=1e-9)`，`2e-308` 也被当成“足够接近 0”，于是错误输出被放过。

这说明：

- 规约表面上写了精确公式
- 但真正判定时用了过大的绝对误差容忍
- 所以正例没暴露问题，负例一换成极小数就漏掉了

这个错误明确是 `gpt-5-nano` 的规约问题，不是题面本身有歧义。

例子 B：`gpt-5` 在 `HumanEval/91` 上只检查了宽松上界，没有检查真实语义
[HumanEval_91.py](/home/yangfp/TeSpec/output/gpt-5_20260316_013133/HumanEval_91.py)
[HumanEval_91.json](/home/yangfp/TeSpec/negative_report/gpt-5_20260316_013133/HumanEval_91.json)

任务是 `is_bored(S)`。

自然语言描述：

- 输入：一个字符串
- 句子由 `. ? !` 分隔
- 输出：有多少个句子以单词 `"I"` 开头

生成规约只检查了一些上界：

```python
if output < 0:
    return False
num_segments_upper = S.count('.') + S.count('?') + S.count('!') + 1
if output > num_segments_upper:
    return False
if 'I' not in S and output != 0:
    return False
if output > count_I_words:
    return False
return True
```

问题在于它没有真正重新判定“哪些句子是以 `I` 开头的句子”，只是在检查：

- 输出不是负数
- 输出不超过句子数上界
- 输出不超过字符串里可能的 `I` 单词数

负例中的失败样例是：

```json
{
  "input": ["I feel good today. I will be productive. will kill It"],
  "original_output": 2,
  "mutation_output": 1,
  "failure_type": "postcondition_survived"
}
```

这里正确答案是 `2`，变异实现输出 `1`。  
但 `1` 仍然满足上面的所有宽松约束，于是 `postcondition` 返回 `True`。

这类错误很典型：

- 正例里题目样例都能过
- 但规约只检查必要条件，不检查充分条件
- 因而很多错误输出会“看起来也合理”

这里是 `gpt-5` 的典型问题：正例能过，但规约只写了必要条件，没有写充分条件。

例子 C：`claude-opus-4-5-20251101` 在 `HumanEval/129` 上只检查“路径合法”，没检查“路径最优”
[HumanEval_129.py](/home/yangfp/TeSpec/output/claude-opus-4-5-20251101_20260316_143850/HumanEval_129.py)
[HumanEval_129.json](/home/yangfp/TeSpec/negative_report/claude-opus-4-5-20251101_20260316_143850/HumanEval_129.json)

任务是 `minPath(grid, k)`。

自然语言描述：

- 输入：一个 `N x N` 网格，每个数 `1..N*N` 恰好出现一次，以及正整数 `k`
- 输出：长度为 `k` 的最小字典序路径
- 路径必须每一步走到共享边的相邻格子

生成规约主要检查的是：

```python
if len(output) != k:
    return False
for val in output:
    if val < 1 or val > n * n:
        return False
for i in range(1, k):
    if abs(r1 - r2) + abs(c1 - c2) != 1:
        return False
return True
```

也就是说，它只验证：

- 长度对不对
- 值域对不对
- 相邻两步是否真的在网格里相邻

但没有验证“这是不是字典序最小路径”。

负例中的失败样例是：

```json
{
  "input": [[[6,1,5],[3,8,9],[2,7,4]], 8],
  "original_output": [1,5,1,5,1,5,1,5],
  "mutation_output": [1,6,1,6,1,6,1,6],
  "failure_type": "postcondition_survived"
}
```

这两个输出都是合法路径，但只有 `[1,5,1,5,1,5,1,5]` 才是题目要求的最小字典序答案。  
因为规约只检查“是不是一条合法路径”，没有检查“是不是最小路径”，所以错误输出被放过了。

这个例子说明：

- 自然语言要求的是一个优化目标
- 但生成规约只写出了可行性约束
- 可行性约束能过正例，却不足以挡住很多错误实现

这里错的是 `claude-opus-4-5-20251101` 生成出的 `postcondition`，因为它漏掉了“字典序最小”这个题目最核心的约束。

例子 D：`deepseek-v3.2` 在 `HumanEval/30` 上只检查“输出里的元素都合法”，没检查“该保留的都保留了”
[HumanEval_30.py](/home/yangfp/TeSpec/output/deepseek-v3.2_20260316_013133/HumanEval_30.py)
[HumanEval_30.json](/home/yangfp/TeSpec/negative_report/deepseek-v3.2_20260316_013133/HumanEval_30.json)

任务是 `get_positive(l)`。

自然语言描述：

- 输入：一个列表
- 输出：其中所有正数，保持原顺序

`deepseek-v3.2` 生成的规约是：

```python
if not isinstance(output, list):
    return False
if not all(isinstance(x, (int, float)) for x in output):
    return False
if not all(x > 0 for x in output):
    return False
if not all(x in l for x in output):
    return False
return True
```

它检查了：

- 输出是不是列表
- 输出里是不是全是正数
- 输出元素是不是都来自输入

但没有检查：

- 是否漏掉了某些本该保留的正数
- 是否保留了原有顺序

负例里的失败样例是：

```json
{
  "input": [[5, 3, -5, 2, 3, 3, 9, 0, 123, 1, -10]],
  "original_output": [5, 3, 2, 3, 3, 9, 123, 1],
  "mutation_output": [5, 3, 2, 3, 3, 9, 123],
  "failure_type": "postcondition_survived"
}
```

变异输出少了最后一个 `1`，显然不对，但它仍然满足“都是正数，而且都来自原列表”，所以被 `postcondition` 放过了。

这个错误很典型地属于 `deepseek-v3.2`：

- 它学到了输出的大致形状
- 但没有写出“输出必须恰好等于输入中所有正数子序列”这种强语义

例子 E：`gpt-5-mini` 在 `HumanEval/56` 上把布尔规约写成了单向约束
[HumanEval_56.py](/home/yangfp/TeSpec/output/gpt-5-mini_20260316_012906/HumanEval_56.py)
[HumanEval_56.json](/home/yangfp/TeSpec/negative_report/gpt-5-mini_20260316_012906/HumanEval_56.json)

任务是 `correct_bracketing(brackets)`。

自然语言描述：

- 输入：只含 `<` 和 `>` 的字符串
- 输出：是否每个左括号都能被正确匹配

`gpt-5-mini` 的规约核心是：

```python
all_openings_closed = (opens == 0)
if output:
    return all_openings_closed
return True
```

这相当于说：

- 如果函数返回 `True`，那必须满足一个宽松的“看起来像闭合了”的条件
- 但如果函数返回 `False`，就一律接受

负例里的失败样例有两类：

```json
{
  "input": ["<>"],
  "original_output": true,
  "mutation_output": false,
  "failure_type": "postcondition_survived"
}
```

以及：

```json
{
  "input": ["<<<><>>>>"],
  "original_output": false,
  "mutation_output": true,
  "failure_type": "postcondition_survived"
}
```

第一类说明：

- 明明正确答案是 `True`
- 变异实现返回了 `False`
- 但因为规约对 `False` 基本不做检查，所以错误输出直接活下来了

第二类说明：

- 即便是 `True` 分支，它检查的也不是完整括号匹配，只是“最后有没有剩余左括号”
- 像 `">"` 这种前缀已经非法的串，也可能被放过

这个错误是 `gpt-5-mini` 很典型的一类：把布尔规格写成“只约束一种返回值”。

例子 F：`gpt-5-nano` 在 `HumanEval/22` 上混淆了 `int`、`bool` 和 `float`
[HumanEval_22.py](/home/yangfp/TeSpec/output/gpt-5-nano_20260318_151556/HumanEval_22.py)
[HumanEval_22.json](/home/yangfp/TeSpec/negative_report/gpt-5-nano_20260318_151556/HumanEval_22.json)

任务是 `filter_integers(values)`。

自然语言描述：

- 输入：任意 Python 值组成的列表
- 输出：只保留其中的整数

`gpt-5-nano` 的规约写成：

```python
expected = [x for x in values if type(x) is int]
return output == expected
```

看起来像是精确规约，但它对 Python 类型细节理解不稳定。  
负例里能看到这几种失败：

```json
{
  "input": [[true, false, true, true, true, false, false]],
  "original_output": [true, false, true, true, true, false, false],
  "mutation_output": [],
  "failure_type": "postcondition_survived"
}
```

以及：

```json
{
  "input": [[true, false, 1, 1.0, "1", [1], {"1": 1}, null]],
  "original_output": [true, false, 1],
  "mutation_output": [1.0],
  "failure_type": "postcondition_survived"
}
```

这些例子反映的是：

- 这题题面里的 “integer” 在 Python 里和 `bool`、`float` 的边界并不直观
- `gpt-5-nano` 生成的规约在这些边界值上没有稳定把语义钉死
- 所以正例能过，但负例一旦专门攻击类型边界，就会出现漏检


### 第二类：不完全是模型错，更多是任务边界本身难

这类问题并不表示模型完全没问题，而是单靠自然语言很难恢复出一个完全独立、不过强、又足够高效的规约。

#### 1. `precondition` 过强，边界很难从自然语言恢复

例子：
[HumanEval_8.json](/home/yangfp/TeSpec/test_reports/gpt-5-nano_20260318_151556/HumanEval_8.json)
[HumanEval_8.py](/home/yangfp/TeSpec/output/gpt-5-nano_20260318_151556/HumanEval_8.py)

任务是 `sum_product(numbers)`。

自然语言描述：

- 输入：一个整数列表 `numbers`
- 输出：一个二元组 `(sum, product)`
- 题面示例：空列表应返回 `(0, 1)`

生成出的规约是：

```python
def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    numbers = input[0]
    if not isinstance(numbers, list):
        return False
    for x in numbers:
        if not isinstance(x, int):
            return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(output, tuple) or len(output) != 2:
        return False
    s = sum(numbers)
    p = 1
    for x in numbers:
        p *= x
    return output[0] == s and output[1] == p
```

正例里的失败样例是：

```json
{
  "input": [""],
  "expected": [0, 1],
  "failure_type": "precondition_failed"
}
```

也就是说实际调用等价于：

```python
sum_product("")
```

而在负例里，同一个输入还会出现更具体的失败：

```json
{
  "input": [""],
  "original_output": [0, 1],
  "mutation_output": [1, 1],
  "failure_type": "precondition_failed_then_postcondition_failed"
}
```

这里从报告能看到：

- `spec_correct = false`
- `postcondition_correct_without_precondition = true`

这说明 `_impl` 本身在官方测试上没问题，失败主要来自前条件过强。  
它反映的是：题面说“整数列表”，但没有精确定义 Python 动态语义下到底允许哪些边界输入。

#### 2. 规约和实现本质几乎没区别

这类情况很常见，也很难完全避免，尤其是简单函数。

例子：
[HumanEval_8.py](/home/yangfp/TeSpec/output/gpt-5-nano_20260318_151556/HumanEval_8.py)
[HumanEval_0.py](/home/yangfp/TeSpec/output/gpt-5-nano_20260318_151556/HumanEval_0.py)
[HumanEval_97.py](/home/yangfp/TeSpec/output/gpt-5-mini_20260316_012906/HumanEval_97.py)

`HumanEval_8` 的 `postcondition` 直接重算和与积：

```python
s = sum(numbers)
p = 1
for x in numbers:
    p *= x
return output[0] == s and output[1] == p
```

`HumanEval_0` 的 `postcondition` 重新求解“是否存在接近元素”：

```python
for i in range(n):
    for j in range(i + 1, n):
        if abs(numbers[i] - numbers[j]) < threshold:
            expected = True
```

`HumanEval_97` 的 `postcondition` 则直接搬公式：

```python
return isinstance(output, int) and output == (a % 10) * (b % 10)
```

这些写法的共同问题是：

- `postcondition` 更像“再实现一遍函数”
- 而不是只检查更抽象的行为性质

但这类问题不完全是模型偷懒。对于一些特别短、特别公式化的任务，只靠自然语言很容易就滑向“把题目公式直接搬进规约”。  
因此它既是模型输出问题，也是任务类型本身决定的难点。

把这些例子写得更具体一点：

- `HumanEval_8`
  - 自然语言：返回列表元素的和与积
  - `postcondition`：重新计算 `sum(numbers)` 和 `product(numbers)`
  - 问题：这和实现几乎是同一个算法，只是换了一种写法

- `HumanEval_0`
  - 自然语言：判断是否存在两个足够接近的数
  - `postcondition`：双重循环枚举所有数对重新算 `expected`
  - 问题：不是在检查性质，而是在重新解题

- `HumanEval_97`
  - 自然语言：返回两个整数个位数字的乘积
  - `postcondition`：直接写 `output == (a % 10) * (b % 10)`
  - 问题：对这种简单题，规约几乎就退化成了公式化实现

#### 3. 负例上前条件通过与否，本身也可能很难从题面判断

例子：
[HumanEval_8.json](/home/yangfp/TeSpec/negative_report/gpt-5-nano_20260318_151556/HumanEval_8.json)
[HumanEval_43.json](/home/yangfp/TeSpec/negative_report/gpt-5_20260316_013133/HumanEval_43.json)

这类题在负例里常见两种失败：

- `precondition_failed_then_postcondition_failed`
- `precondition_failed_but_postcondition_passed`

它们都说明：变异输出确实错了，但模型给出的前条件并没有把“哪些输入应该让规约开始判定”说清楚。  
这不是单纯的实现错误，而是自然语言没有明确给出一个可执行的输入域边界。

例如在 [HumanEval_8.json](/home/yangfp/TeSpec/negative_report/gpt-5-nano_20260318_151556/HumanEval_8.json) 里：

```json
{
  "input": [""],
  "original_output": [0, 1],
  "mutation_output": [1, 1],
  "precondition_result": false,
  "postcondition_result": false,
  "failure_type": "precondition_failed_then_postcondition_failed"
}
```

这个例子不是说变异体没错，而是说：

- 错误输出已经出现了
- 但规约首先在前条件阶段就把输入挡掉了
- 因此没有真正做到“靠后条件识别错误输出”

### 这两类问题怎么理解

第一类更适合直接归因为模型错误：

- 语法错
- `postcondition` 逻辑错
- `postcondition` 复杂度严重失配
- 正负例两边都表现很差

第二类更适合看作任务和规约形式本身的难点：

- 题面没有明确前条件边界
- Python 动态语义让输入域比自然语言更宽
- 有些题的 `postcondition` 很容易退化成“另一份实现”

所以在读这些指标时，不能简单把所有失败都算成同一种错误。  
有些失败是在惩罚模型质量，有些失败其实是在暴露“自然语言到可执行规约”这件事本身就不完全可判定。

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
