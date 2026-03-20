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
- 如果没有 `*_pre`，组合阶段统一生成：
  - `precondition(input) -> True`

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
def precondition(input) -> bool:
    ...

def postcondition(input, output) -> bool:
    ...
```

### 单独跑正例测试

```bash
python3 run_tests.py --output-dir spec/gpt-5/output/<run_name> --idx 10
```

### 单独跑负例测试

```bash
python3 run_negative_tests.py --output-dir spec/gpt-5/output/<run_name> --idx 10
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

## 当前语义

这套链路里，“equivalent” 的含义是：

- Python 与 Coq 在所有具体输入上返回相同结果

它不表示：

- 形式逻辑上的完全等价
- 证明结构保真
- 量词结构完整保留

## 具体输入上的表达能力

这条链路只关心一件事：

- 当 spec 中涉及的所有变量都已经具体化时，Python 是否能返回与 Coq 相同的结果

在这个前提下，这里的结论是：

- 如果所有变量都是具体的，并且判断只依赖这些具体值本身，那么 Python 可以作为可执行 checker，与 Coq 保持完全一致的返回结果。

也就是说，这里不讨论“整体命题是否在形式上等价”，只讨论：

- 对这一组具体输入，Coq 判真还是判假
- Python 也必须判真还是判假

### 1. `Prop` 可以直接落成 `bool`

典型形式：

- `Definition foo_spec ... : Prop := <一些具体可判定条件>`

当所有输入都已经具体化后，这里的 `Prop` 本质上就是：

- 一个关于当前输入的真值判断

Python 不需要保留 `Prop` 这个层次，只需要输出一个 `bool`，就可以与 Coq 保持一致。

### 2. `forall` 可以消成对当前输入的有限检查

典型形式：

- `forall x, In x xs -> P x`
- `forall i, 0 <= i < length xs -> P (nth i xs ...)`

当 `xs` 已经是一个具体列表时，`forall` 不再是抽象量词，而是：

- 对这一个具体列表中的每个元素逐个检查

Python 可以直接把它实现成：

- `all(...)`
- 显式循环

只要每个具体元素上的判断与 Coq 一致，整个结果就一致。

### 3. `exists` 可以消成对当前输入的有限搜索

典型形式：

- `exists x, In x xs /\ P x`
- `exists i, 0 <= i < length xs /\ ...`

当输入已经固定时，`exists` 的候选集合也是具体且有限的。  
Python 可以直接做：

- `any(...)`
- 遍历搜索

只要搜索逻辑与 Coq 在当前输入上的返回一致，就已经满足目标。

### 4. 辅助定义保留可执行行为即可

常见情况是：

- Coq 中先定义若干 `Fixpoint` / `Definition`
- `*_spec` 或 `*_pre` 只是调用这些辅助定义来给出最终判断

在这个任务里，Python 不需要复刻这些定义的证明意义，只需要保留：

- 对具体输入的可执行行为

只要辅助函数在当前输入上的返回和 Coq 一样，最外层 spec 的结果也就会一致。

### 5. 不需要保留证明结构

这里不要求 Python 表达：

- proof term
- tactic 证明过程
- proof obligation
- 命题为何成立的证明结构

因为这些都不影响“对这一组具体输入，最后判真还是判假”。  
所以这条链路允许直接忽略证明结构，只保留最终的判定行为。

### 6. 这条链路的保证边界

这里真正保证的是：

- 对所有已经具体化的输入，Python 返回与 Coq 相同的结果

它不保证：

- Python 在形式上完整复现 Coq 的逻辑表达
- Python 保留 Coq 的证明结构
- Python 保留量词、`Prop`、`Inductive` 的原始逻辑写法

更准确地说，这里做的是：

- 把 Coq spec 消成对当前输入的可执行判断
- 把 `forall` 消成有限遍历
- 把 `exists` 消成有限搜索
- 把 `Prop` 消成 `bool`
- 只保留会影响当前输入返回结果的那部分语义
