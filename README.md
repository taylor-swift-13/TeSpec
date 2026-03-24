# TeSpec

这个分支面向 Coq spec 到可执行 Python checker/oracle 的生成与测试。

目标不是形式上的 Coq/Python 完全等价，而是：

- 对所有具体输入，Python 返回与 Coq 相同的结果或判断
- Python 无法自然表达的 Coq 结构可以忽略
- 最终产物用于正例/负例测试链路

## 当前目录

- [translate_coq_input.py](/home/yangfp/TeSpec/translate_coq_input.py)
  - 读取 `spec/<model>/input/*.v`
  - 生成同目录下的 `*.py`
  - 使用多模型投票验证这份 Python 是否在具体输入上与 Coq 一致
  - 如果不一致，使用自然语言原因回灌给 `gemini-3-pro-preview` 迭代修复
- [compose_coq_output.py](/home/yangfp/TeSpec/compose_coq_output.py)
  - 读取已经生成好的 `spec/<model>/input/*.py`
  - 组合出统一接口文件到 `spec/<model>/output/<run_name>/HumanEval_<idx>.py`
- [run_tests.py](/home/yangfp/TeSpec/run_tests.py)
  - 正例测试
- [run_negative_tests.py](/home/yangfp/TeSpec/run_negative_tests.py)
  - 负例测试
- [run_coq_pipeline.py](/home/yangfp/TeSpec/run_coq_pipeline.py)
  - 一键串联翻译、修复、compose、正例测试、负例测试
- [HumanEvalPlus.jsonl](/home/yangfp/TeSpec/HumanEvalPlus.jsonl)
  - 用于恢复题目的 `entry_point`、辅助定义和参考实现签名
- [humaneval_mutations](/home/yangfp/TeSpec/humaneval_mutations)
  - 负例测试使用的 mutation 数据
- [spec](/home/yangfp/TeSpec/spec)
  - 各模型来源的 Coq 输入目录

## 规则

- `*_spec` 视为后条件
- `*_pre` 视为前条件
- 其他 `Definition` / `Fixpoint` / `Inductive` 都视为辅助函数
- 主 `*_pre` 的参数必须与官方 `_impl` 完全一致；如果没有前条件，可以不定义
- 主 `*_spec` 的参数必须与官方 `_impl` 完全一致，并且最后只多一个 `output`
- `output` 就是 `_impl(*args)` 的真实返回值
- 多返回值题也只能通过单个 `output` 传入，若需要拆开，应在 `*_spec` 函数体内部解构
- `spec/*/input/*.py` 里不应写测试 wrapper，只保留接近 Coq 语义的 Python 规格本体

## Prompt

### 生成 Prompt

`translate_coq_input.py` 当前使用的生成 prompt 核心是：

```text
Produce executable Python code from the following Coq spec.

Goal:
The Python code does not need to be formally equivalent to the Coq code.
The only requirement is: for all concrete inputs, the Python code must return the same result or judgment as the Coq code/spec.
```

它的约束重点是：

- 保留顶层函数名
- `*_spec` / `*_pre` 生成 bool 函数
- 关注具体输入上的行为
- Python 表达不了的 Coq 结构可以忽略
- 最高优先级是“具体输入上结果一致”

### 判定 Prompt

投票模型当前使用的判断 prompt 核心是：

```text
You are checking whether the Python code agrees with the Coq code/spec on concrete inputs.

Important:
Do not require full formal equivalence.
Do not reject the Python code merely because it does not preserve Coq proof structure, Prop structure, or quantifier structure exactly.
The only question is whether, for all concrete inputs, the Python code is likely to return the same result or judgment as the Coq code/spec.
```

输出格式固定为：

```json
{"equivalent": true_or_false, "reason": "short natural language explanation"}
```

这里的 `equivalent` 已经不表示“形式等价”，而表示：

- 这份 Python 在所有具体输入上是否很可能与 Coq 返回相同结果

### 修复 Prompt

修复 prompt 核心是：

```text
Revise the Python code so that it agrees with the Coq code/spec on concrete inputs.

Goal:
Do not aim for full formal equivalence.
The only requirement is: for all concrete inputs, the revised Python code should return the same result or judgment as the Coq code/spec.
```

也就是说，修复阶段不是去补全 Coq 的逻辑结构，而是只修“具体输入上结果不一致”的问题。

## 翻译流程

`translate_coq_input.py` 当前流程如下：

1. 读取 `spec/<model>/input/<idx>.v`
2. 使用 `gemini-3-pro-preview` 生成 `spec/<model>/input/<idx>.py`
3. 如果生成结果有 Python 语法错误：
   - 不触发投票
   - 直接把编译器错误当作反馈
   - 继续让 `gemini-3-pro-preview` 修复
4. 如果语法正确：
   - 用 `gemini-3-pro-preview`
   - `claude-opus-4-5-20251101`
   - `gpt-5`
   各自独立判断 3 次
5. 如果多数票认为不一致：
   - 收集 `reason`
   - 把这些自然语言原因回灌给 `gemini-3-pro-preview`
   - 继续迭代修复
6. 整个过程共用一个上限：
   - `--max-iterations`

翻译结果会写到：

- `spec/<model>/input/<idx>.py`
- `spec/<model>/input/<idx>.equiv.json`

其中 `.equiv.json` 记录：

- 每个 judge model 的 3 次判断
- 多数票结果
- 不一致原因
- 当前是第几轮修复

## 使用方式

### 只跑翻译与投票修复

```bash
python3 translate_coq_input.py --model gpt-5 --idx 10
```

说明：

- `--model` 只表示读哪个 `spec/<model>/input`
- `--api-model` 才是实际生成用的模型
- 当前默认 `--api-model = gemini-3-pro-preview`

例如：

```bash
python3 translate_coq_input.py --model gpt-5 --api-model gemini-3-pro-preview --idx 10 --max-iterations 2
```

### 组合输出

```bash
python3 compose_coq_output.py --model gpt-5 --idx 10
```

输出会落到：

```text
spec/gpt-5/output/gpt-5_<timestamp>/HumanEval_10.py
```

组合后的文件会统一带：

```python
def precondition(*args) -> bool:
    ...

def postcondition(*args, output) -> bool:
    ...
```

这里的规则是：

- `precondition(*args)` 直接调用主 `*_pre(*args)`；若该题没有 `*_pre`，则恒为 `True`
- `postcondition(*args, output)` 直接调用主 `*_spec(*args, output)`
- 不再通过 `input` tuple 作为真实 spec 接口

### 单独跑正例测试

```bash
python3 run_tests.py \
  --output-dir spec/gpt-5/output/<run_name> \
  --idx 10 \
  --task-timeout 600
```

### 单独跑负例测试

```bash
python3 run_negative_tests.py \
  --output-dir spec/gpt-5/output/<run_name> \
  --idx 10 \
  --task-timeout 600
```

### 一键跑完整流水线

```bash
python3 run_coq_pipeline.py --model gpt-5
```

或者单题 smoke：

```bash
python3 run_coq_pipeline.py --model gpt-5 --idx 26 --run-name gpt-5_pipeline_smoke
```

默认会顺序执行：

1. `translate_coq_input.py`
2. `compose_coq_output.py`
3. `run_tests.py`
4. `run_negative_tests.py`

最终会生成：

- `spec/<model>/output/<run_name>/`
- `test_reports/<run_name>/`
- `negative_report/<run_name>/`
- `spec/<model>/output/<run_name>/_pipeline_summary.json`

## 默认配置

- 实际生成模型默认是：
  - `gemini-3-pro-preview`
- 投票模型默认是：
  - `gemini-3-pro-preview`
  - `claude-opus-4-5-20251101`
  - `gpt-5`
- 每个投票模型默认判断：
  - `3` 次
- 语法修复与行为修复共用：
  - `--max-iterations`
- 正例/负例测试默认推荐：
  - `--task-timeout 600`

## 当前接口约定

对每道题，当前推荐的 `spec/*/input/*.py` 主接口如下：

```python
def <entry_point>_pre(arg1, arg2, ...):
    ...

def <entry_point>_spec(arg1, arg2, ..., output):
    ...
```

要求是：

- `arg1, arg2, ...` 与官方 `_impl(arg1, arg2, ...)` 完全一致
- `output` 是唯一合法的输出形参名
- 不再使用 `input` / `result` / `res` / `ans` 作为主接口形参
- 多输出题也只允许一个 `output`

例如：

```python
def below_threshold_spec(l, t, output):
    return output == all(x < t for x in l)
```

如果 `_impl` 返回的是 tuple/list，则在 spec 内部自行解构：

```python
def sum_product_spec(numbers, output):
    sum_value, product_value = output
    ...
```

## 当前语义

这套链路里，“equivalent” 的含义是：

- Python 与 Coq 在所有具体输入上返回相同结果

它不表示：

- 形式逻辑上的完全等价
- 证明结构保真
- 量词结构完整保留

在这个前提下，这里的结论是：

- 如果所有变量都是具体的，并且判断只依赖这些具体值本身，那么 Python 可以作为可执行 checker，与 Coq 保持完全一致的返回结果。

也就是说，这里不讨论“整体命题是否在形式上等价”，只讨论：

- 对这一组具体输入，Coq 判真还是判假
- Python 也必须判真还是判假



## 非全票翻译检查

多模型投票里，“非全票通过”指的是：

- 9 票里不是 `9/0`
- 但大多数情况下仍然是 `6/3`、`8/1` 这类“多数认为可接受”

这类题不能直接当成“翻译一定错误”，因为里面混着两种情况：

1. judge 对 Coq 含义存在分歧，但在当前具体输入测试里没有暴露问题
2. Python 版本确实会在具体输入上与 Coq 产生不同判断

### 统计

下面这张表只统计：

- 已经生成 `.equiv.json` 的题
- 其中不是全票通过的题数
- 以及这些题里，后续正例/负例测试确实失败的个数

| 模型 | 非全票题数 | 正例失败 | 负例失败 |
| --- | ---: | ---: | ---: |
| `gpt-4o` | `3` | `2` | `2` |
| `claude-3-7-sonnet-20250219` | `8` | `5` | `3` |
| `claude-opus-4-5-20251101` | `31` | `7` | `14` |
| `deepseek-v3.1` | `4` | `3` | `2` |
| `gemini-3-pro-preview` | `33` | `4` | `11` |
| `gpt-5` | `22` | `6` | `6` |
| `human` | `43` | `15` | `17` |

这张表的含义是：

- 非全票 != 一定错误
- 但非全票题里，确实有相当一部分会在后续正负例里暴露出真实行为偏差



## 正例测试结果

以下统计基于当前最新一轮正例：

- `*_20260324_010947_positive600`
- 只看正例
- 整题超时：`600s`

对应目录：

- `test_reports/*_20260324_010947_positive600`

### 1. 任务级统计

口径：

- 忽略前条件，只统计官方 `_impl` 输出是否满足 `postcondition`
- `正例后条件正确率`：`postcondition_correct_without_precondition_tasks / 164`
- 缺失题目按未通过计入分母

| 模型 | 正例后条件正确率 | testcase 正确率 |
| --- | ---: | ---: |
| `claude-3-7-sonnet-20250219` | `26/164 = 0.1585` | `0.9233` |
| `claude-opus-4-5-20251101` | `78/164 = 0.4756` | `0.9119` |
| `deepseek-v3.1` | `10/164 = 0.0610` | `0.9844` |
| `gemini-3-pro-preview` | `113/164 = 0.6890` | `0.9439` |
| `gpt-4o` | `17/164 = 0.1037` | `0.8050` |
| `gpt-5` | `98/164 = 0.5976` | `0.9486` |
| `human` | `129/164 = 0.7866` | `0.9601` |

### 2. 已确认的 spec 本身问题

这里的“spec 本身问题”指：

- 不是 runner/compose 框架错误
- 不是单纯性能超时
- 而是把官方 `_impl` 的正确输出代回当前 Coq/Python 规格后，规格自己拒绝

#### `claude-3-7-sonnet-20250219`

- `HumanEval/9`
  问题定义：`prefix_max` 语义写成了滚动前缀最大值，但 Coq 递归语义对应的是“非空时返回首个最长候选/单元素全局最大值”的那一版。
- `HumanEval/24`
  问题定义：最长元素的 witness/位置约束写得过强，重复最长值时会错误拒绝合法输出。
  错误 case：
  - `["dog", "cat", "horse", "cow", "hore", "horse"]`
  - 官方输出：`"horse"`
- `HumanEval/62`, `HumanEval/63`, `HumanEval/163`
  问题定义：当前规格与官方题意仍有细节偏差，表现为 `_impl` 输出被后条件拒绝。

#### `claude-opus-4-5-20251101`

- `HumanEval/12`
  问题定义：最长字符串规格对重复最长值的索引条件写得过强。
  错误 case：
  - `["dog", "cat", "horse", "cow", "hore", "horse"]`
  - 官方输出：`"horse"`
- `HumanEval/17`
  问题定义：带标签输出/构造子语义仍没有完全对齐官方裸输出。
- `HumanEval/22`
  问题定义：把抽象整数/类型约束具体化成了 Python 类型判定。
- `HumanEval/32`
  问题定义：Coq 规格要求精确根，官方题是数值近似求根。
- `HumanEval/45`
  问题定义：精确数值语义和 Python 落地的近似判断存在差异。
- `HumanEval/92`
  问题定义：是否“是整数”的判断按 Coq/有理数语义与官方实现有差异。
- `HumanEval/99`
  问题定义：精确最近整数语义与官方 `float` 语义在大数上分叉。
- `HumanEval/111`
  问题定义：输出表示/频次最大项约束与官方接口仍未完全一致。
- `HumanEval/151`
  问题定义：Coq 输入域是整数列表，官方任务允许浮点并要求忽略非整数。
- `HumanEval/155`
  问题定义：当前 even/odd digit 计数规格与官方返回 tuple 的行为仍存在差异。

#### `deepseek-v3.1`

- `HumanEval/139`
  问题定义：当前规约对构造/递推结果的判定仍和 Coq/官方行为不一致。

#### `gemini-3-pro-preview`

- `HumanEval/27`
  问题定义：大小写翻转规则对非 ASCII/边界字符的处理与题意不完全一致。
- `HumanEval/32`
  问题定义：精确根 vs 数值近似根。
- `HumanEval/92`
  问题定义：整数判定按 Coq/有理数语义与官方实现不一致。
- `HumanEval/95`
  问题定义：抽象大小写谓词被具体化成 Python 字符串判定。
- `HumanEval/101`
  问题定义：分词/字符串处理规格与官方返回值有细节偏差。
- `HumanEval/133`
  问题定义：上取整/边界条件落地仍与题意不完全一致。
- `HumanEval/148`
  问题定义：集合/顺序类约束在 Python 侧实现偏强或偏弱。

#### `gpt-4o`

- `HumanEval/9`
  问题定义：`prefix_max` 语义未和 Coq 递归定义对齐。
- `HumanEval/12`
  问题定义：最长元素的 witness/位置条件写得过强。
- `HumanEval/85`
  问题定义：当前判定条件仍和 Coq 题意存在边界不一致。
- `HumanEval/92`
  问题定义：整数判定按 Coq/有理数语义与官方实现不一致。
- `HumanEval/151`
  问题定义：输入域被 Coq 写成整数列表，官方任务允许浮点。
- `HumanEval/162`
  问题定义：当前输出/约束实现与 Coq/官方行为仍有差异。

#### `gpt-5`

- `HumanEval/1`
  问题定义：后条件结构约束仍过强，拒绝了官方实现输出。
- `HumanEval/27`
  问题定义：大小写翻转语义仍有字符域边界差异。
- `HumanEval/45`
  问题定义：精确数值语义和当前 Python 近似判断不完全一致。
- `HumanEval/71`
  问题定义：两位小数/面积舍入规则仍和官方行为不完全一致。
- `HumanEval/92`
  问题定义：整数判定按 Coq/有理数语义与官方实现不一致。
- `HumanEval/101`
  问题定义：字符串/分词规格仍有边界偏差。
- `HumanEval/133`
  问题定义：边界数值语义仍未完全贴合。
- `HumanEval/137`
  问题定义：字符串数值与浮点数值的比较仍受表示方式影响。
- `HumanEval/141`
  问题定义：ASCII 文件名约束与官方任务更宽的输入域不一致。
- `HumanEval/148`
  问题定义：集合/顺序约束实现仍未完全贴合题意。
- `HumanEval/161`
  问题定义：ASCII 大小写语义与官方 Unicode 测试不一致。

#### `human`

- `HumanEval/0`
  问题定义：Coq 用 `<= threshold`，官方实现用严格 `< threshold`。
  错误 case：
  - `numbers = [1.0, 2.0, 3.0, 4.0, 5.0]`
  - `threshold = 1.0`
  - 官方输出：`False`
- `HumanEval/32`
  问题定义：精确根 vs 数值近似根。
- `HumanEval/50`
  问题定义：当前规约按 Coq 的全字符算术位移，官方题意更接近字母表位移。
- `HumanEval/91`
  问题定义：把“句子以单词 I 开头”实现成了字符串前缀 `"I"`。
- `HumanEval/92`
  问题定义：Coq 把数值等于整数的有理数也当整数。
- `HumanEval/99`
  问题定义：已修复“平局远离 0”，但仍会在超大数上和官方 `float` 实现分叉。
  错误 case：
  - 输入：`"-578000000007654321.12345"`
  - 官方输出：`-578000000007654272`
- `HumanEval/111`
  问题定义：输出表示/频次最大项约束仍与官方接口有缝。
- `HumanEval/125`
  问题定义：Coq 使用 `sum (list string) nat`，而官方输出是裸 `list | int`；虽然 Python 已把输出类型对齐，但 Coq 的 split 语义仍与官方 Python `split` 不完全一致。
  错误 case：
  - 输入：`"as,words,,a"`
  - 官方输出：`["as", "words", "", "a"]`
- `HumanEval/126`
  问题定义：Coq 用严格升序 `Sorted Nat.lt`，不允许重复。
- `HumanEval/137`
  问题定义：字符串数值语法与官方实现不完全一致，例如 `.0`、`-.123`。
  错误 case：
  - 输入：`(".0", "-2.0")`
  - 官方输出：`.0`
- `HumanEval/141`
  问题定义：只接受 ASCII 拉丁字母开头。
- `HumanEval/151`
  问题定义：Coq 输入域写成 `list Z`，官方任务允许浮点并要求忽略非整数。
- `HumanEval/155`
  问题定义：even/odd digit 计数规格与官方 tuple 行为仍未完全对齐。
- `HumanEval/161`
  问题定义：只处理 ASCII 大小写，官方测试包含 `äëïöü`。

## 负例测试结果

以下统计基于当前最新一轮负例：

- `*_20260324_010947_negative600`
- 只看负例
- 整题超时：`600s`

对应目录：

- `negative_report/*_20260324_010947_negative600`

### 1. 任务级统计

口径：

- `语法正确率`：`syntax_correct_tasks / 164`
- `负例后条件正确率`：`spec_correct_tasks / 164`
- `testcase 正确率`：`passed_cases / 271701`
- `消除变异体个数`：`passed_mutations / 620`
- 缺失题目、缺失 testcase、缺失 mutation 按未通过计入分母

| 模型 | 语法正确率 | 负例后条件正确率 | testcase 正确率 | 消除变异体个数 |
| --- | ---: | ---: | ---: | ---: |
| `claude-3-7-sonnet-20250219` | `32/164 = 0.1951` | `26/164 = 0.1585` | `44754/271701 = 0.1647` | `103/620 = 0.1661` |
| `claude-opus-4-5-20251101` | `98/164 = 0.5976` | `81/164 = 0.4939` | `162926/271701 = 0.5997` | `361/620 = 0.5823` |
| `deepseek-v3.1` | `13/164 = 0.0793` | `7/164 = 0.0427` | `10523/271701 = 0.0387` | `29/620 = 0.0468` |
| `gemini-3-pro-preview` | `128/164 = 0.7805` | `104/164 = 0.6341` | `223327/271701 = 0.8220` | `485/620 = 0.7823` |
| `gpt-4o` | `24/164 = 0.1463` | `19/164 = 0.1159` | `38652/271701 = 0.1423` | `85/620 = 0.1371` |
| `gpt-5` | `110/164 = 0.6707` | `96/164 = 0.5854` | `190857/271701 = 0.7025` | `446/620 = 0.7194` |
| `human` | `164/164 = 1.0000` | `117/164 = 0.7134` | `267009/271701 = 0.9827` | `572/620 = 0.9226` |

### 2. 具体 spec 错误

这里只保留 **spec 本身错误**：

- `postcondition_survived`：错误输出没有被后条件拦住
- `postcondition_evaluation_error`：后条件自身求值时报错
- `precondition_failed_then_postcondition_failed`：前条件过强，先拒绝了输入

已经通过修复变异体/原始实现避免掉的：

- `mutation_load_error`
- `original_runtime_error`

#### `claude-3-7-sonnet-20250219`

- `HumanEval/9`
  问题定义：`prefix_max` 规格没有拦住错误的前缀最大值输出。
- `HumanEval/49`
  问题定义：模运算/边界条件规格仍未充分约束错误输出。
- `HumanEval/97`
  问题定义：当前字符串/分词类约束不足，错误输出可以存活。

#### `claude-opus-4-5-20251101`

- `HumanEval/22`
  问题定义：抽象整数/类型语义被具体化后，错误输出仍能通过。
- `HumanEval/49`
  问题定义：模运算规格不足以拦住一部分错误输出。
- `HumanEval/92`
  问题定义：整数判定按 Coq/有理数语义写得过宽，错误输出仍可存活。
- `HumanEval/111`
  问题定义：频次最大项规格仍未完全约束错误输出。
- `HumanEval/122`
  问题定义：当前列表/顺序类约束偏弱，错误输出存活。
- `HumanEval/150`
  问题定义：当前约束不足以拦住部分错误输出。
- `HumanEval/162`
  问题定义：边界条件和关系约束仍有缺口，错误输出存活。

#### `deepseek-v3.1`

- `HumanEval/49`
  问题定义：模运算/边界条件规格不足。
- `HumanEval/162`
  问题定义：关系类约束不足以拦住错误输出。

#### `gemini-3-pro-preview`

- `HumanEval/4`
  问题定义：数值语义近似化后，错误输出仍能通过。
- `HumanEval/21`
  问题定义：归一化/数值比较规格约束不足。
- `HumanEval/22`
  问题定义：类型语义具体化后，错误输出仍能存活。
- `HumanEval/27`
  问题定义：字符域/大小写规则约束不足。
- `HumanEval/45`
  问题定义：面积/数值比较规格仍偏弱。
- `HumanEval/49`
  问题定义：模运算规格不足以拦住错误输出。
- `HumanEval/70`
  问题定义：顺序/排列类约束偏弱。
- `HumanEval/92`
  问题定义：整数判定过宽，错误输出存活。
- `HumanEval/95`
  问题定义：大小写谓词被具体化后，错误输出仍能通过。
- `HumanEval/122`
  问题定义：列表/顺序类约束不足。
- `HumanEval/132`
  问题定义：子序列/匹配类约束偏弱。
- `HumanEval/133`
  问题定义：边界数值语义约束不足。
- `HumanEval/150`
  问题定义：当前约束不足以拦住错误输出。
- `HumanEval/97`
  问题定义：字符串/分词约束偏弱。

#### `gpt-4o`

- `HumanEval/9`
  问题定义：`prefix_max` 规格没有拦住错误输出。
- `HumanEval/85`
  问题定义：关系/边界条件规格仍有漏洞。
- `HumanEval/92`
  问题定义：整数判定过宽，错误输出存活。
- `HumanEval/151`
  问题定义：输入域和官方任务不一致后，现有约束无法有效过滤错误输出。

#### `gpt-5`

- `HumanEval/22`
  问题定义：类型语义具体化后，错误输出仍能通过。
- `HumanEval/27`
  问题定义：字符域/大小写规则仍偏弱。
- `HumanEval/70`
  问题定义：顺序/排列类约束不足。
- `HumanEval/92`
  问题定义：整数判定过宽。
- `HumanEval/95`
  问题定义：抽象大小写谓词被具体化后，错误输出存活。
- `HumanEval/97`
  问题定义：字符串/分词约束偏弱。
- `HumanEval/122`
  问题定义：列表/顺序类约束不足。
- `HumanEval/133`
  问题定义：边界数值语义仍不够强。
- `HumanEval/141`
  问题定义：ASCII 文件名约束与任务输入域有差异，当前错误输出仍能存活。
- `HumanEval/161`
  问题定义：ASCII 大小写语义与官方更宽字符域不一致。

#### `human`

- `HumanEval/0`
  问题定义：`<= threshold` 写得过宽，错误输出可以存活。
- `HumanEval/4`
  问题定义：数值近似/精确值处理仍不足以拦住所有错误输出。
- `HumanEval/12`
  问题定义：重复最长字符串的 witness/位置条件过强或不稳定，错误输出未被完全过滤。
- `HumanEval/20`
  问题定义：多返回值题的输出约束仍偏弱。
- `HumanEval/21`
  问题定义：归一化/数值比较约束偏弱。
- `HumanEval/22`
  问题定义：类型语义具体化后，错误输出存活。
- `HumanEval/27`
  问题定义：字符域/大小写规则约束不足。
- `HumanEval/45`
  问题定义：面积/数值比较规格仍偏弱。
- `HumanEval/49`
  问题定义：模运算/边界条件规格不足。
- `HumanEval/91`
  问题定义：字符串前缀版的 “I” 规则过宽，错误输出仍可能存活。
- `HumanEval/92`
  问题定义：整数判定过宽。
- `HumanEval/95`
  问题定义：大小写谓词具体化后，错误输出存活。
- `HumanEval/97`
  问题定义：字符串/分词约束偏弱。
- `HumanEval/111`
  问题定义：前条件过强，出现 `precondition_failed_then_postcondition_failed`。
- `HumanEval/122`
  问题定义：列表/顺序类约束不足。
- `HumanEval/124`
  问题定义：布尔性质规格偏弱。
- `HumanEval/126`
  问题定义：严格升序语义与官方任务不一致，错误输出未被稳定拦住。
- `HumanEval/137`
  问题定义：字符串数值/浮点值比较仍有表示层问题，错误输出存活。
- `HumanEval/141`
  问题定义：ASCII 文件名约束与任务输入域不一致。
- `HumanEval/150`
  问题定义：当前约束不足以拦住错误输出。
- `HumanEval/151`
  问题定义：输入域写成 `list Z`，与官方任务不一致。
- `HumanEval/155`
  问题定义：tuple/分量语义仍未完全对齐。
- `HumanEval/160`
  问题定义：前条件过强，出现 `precondition_failed_then_postcondition_failed`。
- `HumanEval/161`
  问题定义：ASCII 大小写语义与官方更宽字符域不一致。

### 3. 超时案例与原因

这轮超时全部是整题超时：

- `--task-timeout 600`

这些超时目前更像性能问题，不直接说明 spec 语义错误。

#### 代表例子

- `human / HumanEval/31`
  问题定义：大数判素数。
  原因：当前规格按试除法判素数，测试里有很大的输入，整题累计超过 `600s`。

- `human / HumanEval/39`
  问题定义：prime-fib 递推/计数。
  原因：会反复做 prime/fib 判定，整题累计很重。

- `human / HumanEval/55`
  问题定义：Fibonacci 规格。
  原因：当前实现是朴素递归 Fibonacci，复杂度指数级。

- `human / HumanEval/129`
  问题定义：路径扩展/最优路径选择。
  原因：候选路径扩展有组合爆炸。

- `human / HumanEval/130`
  问题定义：递推列表验证。
  原因：既要构造递推值又要整列表校验，累计很慢。

- `claude-opus / HumanEval/15`
  问题定义：构造 `0..n` 的长字符串。
  原因：`n` 可到 `10^6` 量级，生成完整字符串序列代价很高。

- `claude-opus / HumanEval/50`
  问题定义：当前规格按全字符位移校验。
  原因：虽然单次不一定慢，但整题 case 多时累计超过 `600s`。

- `claude-opus / HumanEval/55`
  问题定义：Fibonacci 规格。
  原因：同样是朴素递归带来的累计超时。

- `deepseek / HumanEval/130`
  问题定义：递推列表验证。
  原因：与 `human / 130` 同类，整列表递推检查过慢。

- `gemini / HumanEval/31`
  问题定义：大数判素数。
  原因：与 `human / 31` 同类。

- `gemini / HumanEval/5`
  问题定义：虽然单次输入不大，但整题 case 数多。
  原因：在当前 runner 的整题粒度下，累计执行时间超过 `600s`。
