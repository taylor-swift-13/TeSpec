# TeSpec

当前分支只保留 Coq `spec` 到 Python 的翻译与组合输出链路，不再保留测试脚本、测试报告和 mutation 数据。

## 当前目录

- [translate_coq_input.py](/home/yangfp/TeSpec/translate_coq_input.py)
  - 读取 `spec/<model>/input/*.v`
  - 调用 LLM 把 Coq spec 翻成同目录下的 `*.py`
- [compose_coq_output.py](/home/yangfp/TeSpec/compose_coq_output.py)
  - 读取已经翻译好的 `spec/<model>/input/*.py`
  - 统一补出：
    - `def precondition(input) -> bool:`
    - `def postcondition(input, output) -> bool:`
  - 输出到 `spec/<model>/output/<model>_<timestamp>/`
- [HumanEvalPlus.jsonl](/home/yangfp/TeSpec/HumanEvalPlus.jsonl)
  - 仅用于恢复题目的 `entry_point`、辅助定义和参考实现签名
- [llm.py](/home/yangfp/TeSpec/llm.py)
  - OpenAI-compatible API 调用封装
- [config.py](/home/yangfp/TeSpec/config.py)
  - 默认 API 配置
- [spec](/home/yangfp/TeSpec/spec)
  - 各模型来源的 Coq 输入目录

## 规则

- `*_spec` 视为后条件
- `*_pre` 视为前条件
- 其他 `Definition` / `Fixpoint` / `Inductive` 都视为辅助函数
- 如果没有 `*_pre`，则统一生成：
  - `precondition(input) -> True`

## 翻译

从某个输入目录读取 `.v`，实际统一调用 `gemini-3-pro-preview`：

```bash
python3 translate_coq_input.py --model gpt-5 --api-model gemini-3-pro-preview --idx 10
```

这条命令会把：

```text
spec/gpt-5/input/10.v
```

翻成：

```text
spec/gpt-5/input/10.py
```

注意：

- `--model` 只表示读哪个 `spec/<model>/input`
- `--api-model` 才是实际调用的模型
- 当前默认 `--api-model` 已经是 `gemini-3-pro-preview`

## 组合输出

把已经翻译好的 Python spec 统一包装成标准接口：

```bash
python3 compose_coq_output.py --model gpt-5 --idx 10
```

输出会落到：

```text
spec/gpt-5/output/gpt-5_<timestamp>/HumanEval_10.py
```

输出文件里会统一带：

```python
def precondition(input) -> bool:
    ...

def postcondition(input, output) -> bool:
    ...
```

## 当前状态

仓库已经删除：

- 旧实验报告
- 旧生成脚本
- 旧正负例测试脚本
- 旧 mutation 数据

现在只保留 Coq→Python 翻译与组合输出相关内容。
