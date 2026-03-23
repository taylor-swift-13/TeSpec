# Coq→Python 翻译修复方案

覆盖 18 个案例。每个案例标注当前状态：

- **有确定修复**：修复方向明确，可直接应用
- **有候选修复，待验证**：给出修复方案但需 judge 复核
- **分析认为等价，但 judge 未通过，需复核**：仍在非全票列表中，不做定性
- **Coq spec 侧 bug，需上游修**：Python 侧无法单独修复

关于 Coq `In` 的语义统一说明：Coq 的 `List.In x l` 是 `exists i, nth_error l i = Some x`，即"x 至少出现一次"。它**不**约束出现次数——`In 1 [1,1,1]` 为 True，`In 1 [1]` 也为 True。因此 `forall x, In x l1 <-> In x l2` 只约束两个列表含有相同的**元素种类**（集合相等），不约束重数。但这也意味着 `In` 条件本身不排斥 `l1` 和 `l2` 有不同的重复结构。具体案例中是否需要计数取决于 spec 的其他约束。

---

## 第一类：明确翻译错误

---

### 1. Claude-3.7-Sonnet / HumanEval_9（0 eq / 9 neq）

**状态**：有确定修复

**问题**：0/9 全票 neq，judge 一致认为整体不等价。Coq 的 `prefix_max` 由于递归结构对非空列表返回单元素列表（全局最大值），而 Python 的 `prefix_max` 返回与输入等长的滚动最大值列表。虽然最终 spec 函数是 `rolling_max_spec`，但 judge 评估的是整个文件的等价性，`prefix_max` 的不等价足以判定整体 neq。

**修复前**：
```python
def prefix_max(numbers):
    """Compute rolling maximum of list"""
    result = []
    current_max = 0
    for n in numbers:
        current_max = max(current_max, n)
        result.append(current_max)
    return result
```

**修复后**：
```python
def prefix_max(numbers):
    """
    Coq 的 prefix_max 递归语义：
    - prefix_max [] = []
    - prefix_max [x] = [x]
    - prefix_max (x :: rest) = [max(x, head(prefix_max rest))]
    对非空列表总返回单元素列表（全局最大值）。
    """
    if not numbers:
        return []
    head = numbers[0]
    tail_result = prefix_max(numbers[1:])
    if not tail_result:
        return [head]
    else:
        return [max(head, tail_result[0])]
```

---

### 2. Claude-Opus-4.5 / HumanEval_50（0 eq / 9 neq）

**状态**：有确定修复

**问题**：Coq 的 `forall original : string` 量化全 ASCII，`encode_shift` 在 mod 26 下不是单射，导致 spec 对非空字符串恒 False。Python 只检查小写字母域（`range(97, 123)`），对有效小写输入返回 True。

**修复前**：
```python
def decode_shift_spec(s: str, result: str) -> bool:
    if result != decode_shift(s):
        return False
    if len(s) != len(result):
        return False
    for s_char, r_char in zip(s, result):
        for code in range(97, 123):  # 只检查小写字母
            orig_char = chr(code)
            if encode_shift_char(orig_char) == s_char and orig_char != r_char:
                return False
    return True
```

**修复后**：
```python
def decode_shift_spec(s: str, result: str) -> bool:
    # 第一个合取：result = decode_shift s
    if result != decode_shift(s):
        return False

    # 第二个合取：forall original : string, encode_shift original = s -> result = original
    # Coq 量化了所有 ASCII 字符串（不限于小写字母）。
    # 逐字符检查：对每个位置，是否存在某个 ASCII 字符 orig 使得
    # encode_shift_char(orig) == s_char 但 orig != r_char。
    # 如果存在，则该全称量词不成立 → spec 为 False。
    for s_char, r_char in zip(s, result):
        for code in range(256):  # 全部 ASCII，不仅是小写
            orig_char = chr(code)
            if encode_shift_char(orig_char) == s_char and orig_char != r_char:
                return False
    return True
```

> 注：修复后对非空字符串几乎总返回 False（因为 encode_shift 非单射），这忠实于 Coq 的实际语义。Coq spec 本身很可能有 bug（意图应限制量化域到小写字母），但这是上游问题。

---

### 3. Claude-Opus-4.5 / HumanEval_69（5 eq / 4 neq）

**状态**：有确定修复

**问题**：Coq spec 是 `(exists n, ...) -> (...) /\ ((~exists n, ...) -> result = -1)` 的合取结构。当不存在有效候选时，第二个子句要求 `result = -1`。Python 在无候选时直接返回 `True`，未检查 result 的值。

**修复前**：
```python
def search_spec(lst, result):
    valid_candidates = [n for n in set(lst) if valid_candidate(n, lst)]
    if valid_candidates:
        return result == max(valid_candidates)
    return True  # 错误：忽略了 result 必须等于 -1 的要求
```

**修复后**：
```python
def search_spec(lst, result):
    valid_candidates = [n for n in set(lst) if valid_candidate(n, lst)]
    if valid_candidates:
        return result == max(valid_candidates)
    return result == -1  # Coq: (~exists n, valid_candidate n lst) -> result = -1
```

---

### 4. Claude-Opus-4.5 / HumanEval_143（6 eq / 3 neq）

**状态**：有候选修复，待验证

**问题**：

1. Coq 的 `filter` 中 `match is_prime ... with | _ => true end` 无论 `is_prime` 返回什么都返回 true，实际不过滤。但 Python 按 `is_prime` 做了过滤。
2. 成员检查和重数：Coq spec 用 `In w filtered_words <-> (In w words /\ is_prime(word_length w))`。`In` 只约束元素种类（见顶部说明），不约束重数。但 spec 还通过 `exists filtered_words` + `result = join_by_space filtered_words` 隐式约束了 `filtered_words` 的具体内容（包括重数和顺序），所以仅用 `In` 的集合语义不够——`filtered_words` 的长度和重复结构也受约束。

这两个问题交织在一起，使得正确翻译需要同时处理 filter 语义和 existential 的 witness 选取。

**修复前**：
```python
def words_in_sentence_spec(sentence, result):
    words = split_by_space(sentence)
    if not result:
        filtered_words = []
    else:
        filtered_words = split_by_space(result)
    if join_by_space(filtered_words) != result:
        return False

    # 用 set 做成员检查
    all_words = set(words) | set(filtered_words)
    for w in all_words:
        in_filtered = w in filtered_words
        in_words = w in words
        is_p = is_prime(word_length(w))
        if in_filtered != (in_words and is_p):
            return False
    # ... 后续顺序检查 ...
```

**候选修复**：
```python
def words_in_sentence_spec(sentence, result):
    words = split_by_space(sentence)
    if not result:
        filtered_words = []
    else:
        filtered_words = split_by_space(result)
    if join_by_space(filtered_words) != result:
        return False

    # 问题 1：Coq 的 filter 实际不过滤（match ... with | _ => true end）。
    # 但 spec 的 exists 条件用的是 In，不直接引用 filter 的结果。
    # 所以关键约束是下面的 In 双向条件。

    # In 双向条件：forall w, In w filtered_words <-> (In w words /\ is_prime(word_length w))
    # In 只检查元素是否出现，不计重数。
    for w in set(words + filtered_words):
        in_filtered = w in filtered_words
        in_words = w in words
        is_p = is_prime(word_length(w))
        if in_filtered != (in_words and is_p):
            return False

    # 顺序保持：forall i j, i < j -> ... exists i' j' in words with i' < j'
    for i in range(len(filtered_words)):
        for j in range(i + 1, len(filtered_words)):
            w1 = filtered_words[i]
            w2 = filtered_words[j]
            found = False
            for i_prime in range(len(words)):
                if words[i_prime] == w1:
                    for j_prime in range(i_prime + 1, len(words)):
                        if words[j_prime] == w2:
                            found = True
                            break
                if found:
                    break
            if not found:
                return False

    return True
```

> 注：`In` 的集合语义意味着 `in` 检查是正确的对应。但 `exists filtered_words` 的 witness 结构（长度、重复）受 `result = join_by_space filtered_words` 和顺序条件间接约束。如果 judge 争议核心在重数，需要进一步确认 Coq spec 中 `exists filtered_words` 是否额外排除了某些 witness。

---

### 5. Claude-Opus-4.5 / HumanEval_149（6 eq / 3 neq）

**状态**：有候选修复，待验证

**问题**：Coq spec 是 `forall s, In s result <-> (In s lst /\ has_even_length s = true)`。Python 用 `set` 做等价判断。

关于 `In` 和重数：`In` 只约束元素种类。`forall s, In s result <-> ...` 要求 `result` 和 `{s ∈ lst | has_even_length(s)}` 含有相同的元素种类。所以 `result = ["a", "a", "bb"]` 和 `result = ["a", "bb"]` 在 `In` 条件下都合法（只要 `"a"` 和 `"bb"` 都在 lst 中且偶数长度）。spec 不额外约束 `result` 的长度或重复结构。

judge 反对意见指出 `lst = ['aa', 'aa']` 和 `result = ['aa']` 的场景。在 Coq 下 `In 'aa' ['aa']` 为 True，`In 'aa' ['aa','aa'] /\ has_even_length 'aa'` 也为 True，双向成立。所以 `result = ['aa']` 是合法的。但 `result = ['aa', 'aa']` 也合法。原版 `set` 比较无法区分，而 Coq 的 spec 确实两者都允许。

**修复前**：
```python
def sorted_list_sum_spec(lst: list, result: list) -> bool:
    expected_set = {s for s in lst if has_even_length(s)}
    result_set = set(result)
    return expected_set == result_set and is_sorted_by(cmp_strings, result)
```

**候选修复**（更显式地表达 In 的双向条件）：
```python
def sorted_list_sum_spec(lst: list, result: list) -> bool:
    # Coq: forall s, In s result <-> (In s lst /\ has_even_length s = true)
    # 正向：result 中出现的每个元素必须在 lst 中且偶数长度
    for s in result:
        if s not in lst or not has_even_length(s):
            return False
    # 反向：lst 中每个偶数长度的元素必须在 result 中出现
    for s in lst:
        if has_even_length(s) and s not in result:
            return False
    # 排序
    return is_sorted_by(cmp_strings, result)
```

> 注：这与原版在行为上接近（都是集合层面比较），但更忠实地表达了双向蕴含。`In` 条件不约束重数，所以 `set` 层面的比较在逻辑上是充分的。如果 judge 认为需要计数约束，需要指出 Coq spec 中哪个条件隐含了重数要求。

---

### 6. Claude-Opus-4.5 / HumanEval_155（6 eq / 3 neq）

**状态**：Coq spec 侧 bug，需上游修；当前 Python 待 judge 复核

**问题**：Coq spec 用 `forall (str_repr : list ascii), ...` 量化所有合法字符列表，要求 `even_count` 和 `odd_count` 同时等于每一个合法 `str_repr` 的计数。不同 `str_repr` 给出不同计数，所以没有任何 `(even_count, odd_count)` 能满足——spec 不可满足。

Python 返回 `False` 是对"spec 不可满足则没有合法 result"这一推理的忠实翻译。但 3 票 neq 说明对这个推理存在分歧。

**修复前**：
```python
def even_odd_count_spec(num: int, even_count: int, odd_count: int) -> bool:
    return False
```

**候选修复 A**（忠实于 Coq 字面语义——当前代码可能已正确）：
```python
def even_odd_count_spec(num: int, even_count: int, odd_count: int) -> bool:
    # Coq spec 的 forall 量化了所有合法 str_repr，
    # 不同 str_repr 产生不同计数，因此 spec 不可满足。
    # 作为 Prop 它恒 False → 没有 (even_count, odd_count) 能满足。
    return False
```

**候选修复 B**（如果认为 Coq spec 意图是将 num 转为十进制字符串后计数）：
```python
def even_odd_count_spec(num: int, even_count: int, odd_count: int) -> bool:
    # 假设 Coq spec 意图：let str_repr = digits_of(num)
    digits = list(str(abs(num))) if num != 0 else ["0"]
    expected_even = sum(1 for d in digits if int(d) % 2 == 0)
    expected_odd = sum(1 for d in digits if int(d) % 2 == 1)
    return even_count == expected_even and odd_count == expected_odd
```

> 注：候选 A 和 B 的选择取决于是忠实翻译 Coq 字面语义还是修正其意图。需 judge 和 Coq spec 作者确认。

---

### 7. Claude-Opus-4.5 / HumanEval_99（4 eq / 5 neq）

**状态**：有候选修复，待验证

**问题**：5 票 neq 指出 Python 的 `up(r)` 定义为 `floor(r) + 1`，而 Coq 的 `up` 满足 `IZR(up r) - 1 < r <= IZR(up r)`，即 ceiling 语义。两者在整数输入上差一：`up(0.0)` 在 Python 中为 1，在 Coq 中为 0。此差异传播到 `truncate`、`is_equidistant`、`standard_round`。

但 4 票 eq 说明也有 judge 认为当前翻译正确。

**修复前**：
```python
def up(r):
    """Coq's up function: smallest integer z such that r <= z"""
    return math.floor(r) + 1
```

**候选修复**：
```python
def up(r):
    """
    Coq 的 up 函数满足：IZR(up r) - 1 < r <= IZR(up r)
    即 up(r) = ceil(r)。
    注意：floor(r) + 1 在整数输入上比 ceil(r) 大 1。
    """
    return math.ceil(r)
```

> 注：需要直接查看 Coq 项目中 `up` 的定义来最终确认。如果确认是 ceiling 语义，修复 `up` 即可修复整个链条（`truncate`、`is_equidistant`、`standard_round`、`round_away_from_zero` 都依赖 `up`）。

---

### 8. Deepseek-v3.1 / HumanEval_130（6 eq / 3 neq）

**状态**：有确定修复

**问题**：Coq spec 中 `exists (ans : list nat), ans = [1; 3] /\ (forall i ...) /\ result = ans`。`ans` 被固定为 `[1; 3]`（长度 2），`forall i, 2 <= i <= n -> ...` 中 `nth (i-1) ans 0` 在 i≥4 时越界（返回默认值 0），使等式不成立。Python 跳过了 forall 验证，直接返回 `result == [1, 3]`。

**修复前**：
```python
def tri_spec(n, result):
    if n == 0:
        return result == [1]
    if n == 1:
        return result == [1, 3]
    # For n >= 2
    ans = [1, 3]
    return result == ans  # 跳过了 forall 验证
```

**修复后**：
```python
def tri_spec(n, result):
    if n == 0:
        return result == [1]
    if n == 1:
        return result == [1, 3]
    
    # n >= 2: exists ans, ans = [1; 3] /\ (forall i, 2 <= i <= n -> ...) /\ result = ans
    ans = [1, 3]
    
    def nth(idx, lst, default=0):
        """Coq 的 nth：越界返回 default"""
        if 0 <= idx < len(lst):
            return lst[idx]
        return default
    
    # 验证 forall 条件
    for i in range(2, n + 1):
        if i % 2 == 0:  # Nat.even i = true
            lhs = nth(i - 2, ans) + 1 + i // 2
            rhs = nth(i - 1, ans)
            if lhs != rhs:
                return False  # forall 条件不满足 → 不存在合法 witness
        else:  # Nat.even i = false
            lhs = nth(i - 2, ans) + nth(i - 3, ans) + 1 + (i + 1) // 2
            rhs = nth(i - 1, ans)
            if lhs != rhs:
                return False
    
    return result == ans
```

> 注：n=2 时 i=2（偶数）：`nth(0,[1,3]) + 1 + 1 = 3`，`nth(1,[1,3]) = 3`，通过。n=3 时 i=3（奇数）：`nth(1,[1,3]) + nth(0,[1,3]) + 1 + 2 = 7`，`nth(2,[1,3]) = 0`，不通过 → 返回 False。这忠实于 Coq 语义（spec 对 n≥3 不可满足）。

---

### 9. Deepseek-v3.1 / HumanEval_139（6 eq / 3 neq）

**状态**：分析认为等价，但 judge 未通过，需复核

**问题**：Coq spec 中 `fac = 1 /\ fac' = fac * i /\ fac = fac'` 对 i≥2 时要求 `1 = 1 * i`，矛盾。Python 对 n≥2 返回 False。

反对票认为"存在量词可以为每个 i 独立选择 witness"。但 Coq 的结构是外层 `exists fac ans` 绑定了 `fac=1, ans=1`，内层 `forall i, 2<=i<=n -> exists fac' ans', fac' = fac * i /\ fac = fac'` 中 `fac` 引用的是外层的 `fac=1`，不会被内层 `exists` 修改。所以 `fac = fac'` 要求 `1 = 1 * i`，当 i≥2 时矛盾。

**修复前/后**：
```python
def special_factorial_spec(n: int, result: int) -> bool:
    if n == 0:
        return result == 1
    if n >= 2:
        return False  # Coq spec 在 n>=2 时不可满足
    return result == 1  # n=1: forall 范围空，vacuously true
```

> 注：分析后倾向于认为翻译正确，但仍有 3 票 neq。可能是对 Coq 存在量词作用域的不同理解。需 judge 复核——特别是确认 `fac` 在 `forall` 内是否被遮蔽。

---

### 10. Human / HumanEval_12（6 eq / 3 neq）

**状态**：有候选修复，待验证

**问题**：Coq spec 中 `forall j, j < length input -> exists s, nth_error input j = Some s -> String.length s <= String.length out` 里的 `exists s, P(s) -> Q(s)` 可以选取不满足 P 的 witness s 使蕴含式 vacuously true。Python 尝试检查实际元素。

**修复前**：
```python
# Python 检查实际元素是否满足长度条件
for j in range(len(input)):
    s = nth_error(input, j)
    if s is not None:
        premise = (nth_error(input, j) == s)
        conclusion = (len(s) <= len(out))
        if premise and not conclusion:
            cond1 = False
            # 尝试找替代 witness...
```

**候选修复**：
```python
def problem_12_spec(input_list, output):
    if len(input_list) == 0:
        return output is None
    if output is None:
        return False

    # Coq: exists i, i < length input /\ nth_error input i = Some output /\ (forall j, ...)
    # 内层 forall 中的 exists s 可以 vacuously satisfy（选取 s ≠ nth_error input j）
    # 因此 forall j 条件总是可以被满足
    # spec 退化为：output 出现在 input 中的某个位置
    for i in range(len(input_list)):
        if input_list[i] == output:
            return True
    return False
```

> 注：如果 Coq spec 意图是"output 是最短的元素"，则 Coq spec 本身有 bug（`exists s` 应改为直接引用 `nth_error input j` 的结果或使用 `forall s`）。当前修复忠实于 Coq 的字面语义。

---

### 11. Human / HumanEval_71（0 eq / 9 neq）

**状态**：有确定修复

**问题**：`Fraction(rounded_val)` 取 float 的精确二进制表示（分母通常是 2 的幂），导致 `100 % denominator != 0` 对大多数十进制数为 True，`is_rounded_to_2_decimals` 几乎总返回 False。

**修复前**：
```python
def is_rounded_to_2_decimals(rounded_val, area):
    f_rounded = Fraction(rounded_val)  # 精确二进制表示
    if 100 % f_rounded.denominator != 0:  # 几乎总是 False
        return False
    # ...
```

**修复后**：
```python
def is_rounded_to_2_decimals(rounded_val, area):
    # Coq: exists z : Z, rounded_val = IZR z / 100
    # 用 str() 转换获得十进制语义，避免 IEEE 754 精度问题
    f_rounded = Fraction(str(rounded_val))
    # 检查 rounded_val * 100 是否为整数
    if (f_rounded * 100).denominator != 1:
        return False
    z = int(f_rounded * 100)
    # 检查是 area 四舍五入到 2 位小数的结果
    f_area = Fraction(str(area))
    expected_z = round(f_area * 100)
    return z == expected_z
```

> 注：核心修复是 `Fraction(rounded_val)` → `Fraction(str(rounded_val))`。`heron_area` 中的 `math.sqrt` 也存在精度问题，理想情况下应使用精确算术，但这超出了单函数修复的范围。

---

## 第三类：灰色地带

---

### 12. Human / HumanEval_75（6 eq / 3 neq）

**状态**：分析认为等价，但 judge 未通过，需复核

**问题**：反对票之一认为 `a < 8` 的判断拒绝了 `a=8`。但 `a=8` 时 `a < 8` 为 False，不进入该分支，会进入正常搜索流程，能找到 `2*2*2=8`。另一条反对意见认为 Coq 允许三素数无序而 Python 限制 `i<=j<=k`，但乘法交换律保证了无序不影响存在性判定。

**修复前/后**：
```python
def problem_75_spec(a, b):
    if a < 8:
        return b == False
    # ... 正常搜索三个素数之积 ...
```

> 注：仍在非全票列表中，不做定性。建议对边界值（a=8, a=7, a=12, a=30 等）写测试用例，提交 judge 复核。

---

### 13. Gemini / HumanEval_49（6 eq / 3 neq）

**状态**：有确定修复

**问题**：
1. `p = 0` 时：Coq 的 `Z.modulo a 0 = 0`，Python 返回 `2 ** n`（错误）。
2. `p < 0` 时：Coq 的 `Z.modulo` 返回 `[0, |p|)` 范围的非负余数，Python 调整到 `(p, 0]` 范围（错误）。

**修复前**：
```python
def modp_spec(n: int, p: int, result: int) -> bool:
    if n < 0:
        val = 0
    elif p == 0:
        val = 2 ** n           # 错误：Coq 的 a mod 0 = 0
    elif p > 0:
        val = pow(2, n, p)
    else:
        # p < 0: 错误地调整到 (p, 0] 区间
        r_abs = pow(2, n, abs(p))
        val = r_abs + p if r_abs != 0 else 0
    return result == val
```

**修复后**：
```python
def modp_spec(n: int, p: int, result: int) -> bool:
    if n < 0:
        # Coq: Z.pow 2 n = 0 for n < 0, then 0 mod p = 0
        val = 0
    elif p == 0:
        # Coq: Z.modulo a 0 = 0
        val = 0
    elif p > 0:
        val = pow(2, n, p)
    else:
        # p < 0: Coq 的 Z.modulo 返回 [0, |p|) 范围的非负余数
        val = pow(2, n, abs(p))  # Python 的 pow(a, b, m) 当 m>0 返回 [0, m)
    return result == val
```

---

### 14. Claude-Opus-4.5 / HumanEval_49（6 eq / 3 neq）

**状态**：分析认为等价，但 judge 未通过，需复核

**问题**：Coq spec 是 `p > 0 /\ result = (2^n) mod p`。当 `p <= 0` 时整个 Prop 为 False → 没有合法 result → Python 返回 False。当 `p > 0` 时检查 `result == pow(2, n, p)`（`n < 0` 时 Coq 的 `2^n = 0`，Python 返回 `result == 0`）。

**修复前/后**：
```python
def modp_spec(n: int, p: int, result: int) -> bool:
    if p <= 0:
        return False  # Coq: p > 0 是前提，不满足则 Prop 为 False
    if n < 0:
        return result == 0  # Coq: Z.pow 2 n = 0 for n < 0
    return result == pow(2, n, p)
```

> 注：仍在非全票列表中，不做定性。如果反对票质疑的是 `n < 0` 时 `Z.pow` 的行为，可以通过 `Compute (Z.pow 2 (-1))` 在 Coq 中验证。

---

### 15. GPT-5 / HumanEval_137（5 eq / 4 neq）

**状态**：有候选修复，待验证

**问题**：`Fraction(str(v.r))` 对 `VFloat(0.1)` 给出精确的 `1/10`，但 float `0.1` 的 IEEE 754 值不等于 `1/10`。Coq 用数学实数 R，语义上更接近 float 的精确二进制值。

**修复前**：
```python
def num_of(v):
    if isinstance(v, VFloat):
        return Fraction(str(v.r))  # str(0.1) = "0.1" → Fraction(1, 10)
```

**候选修复**：
```python
def num_of(v):
    if isinstance(v, VFloat):
        # Coq 直接使用实数值 r，不经过十进制字符串转换。
        # Fraction(float) 保留 IEEE 754 的精确二进制值。
        return Fraction(v.r)
```

> 注：Coq 的 R 是数学实数，既不是 IEEE 754 也不是十进制字符串，两种方案都是近似。`Fraction(v.r)` 保证了和 Python float 运算的一致性；`Fraction(str(v.r))` 保证了"人类意图"的十进制精度。需要根据项目的输入假设和 Coq 侧的 R 使用方式决定。

---

### 16. Gemini / HumanEval_113（8 eq / 1 neq）

**状态**：分析认为等价，但 judge 未通过，需复核

**问题**：Coq 的 `string_of_nat` 是未指定参数，Python 用 `str(n)`。

**修复前/后**：
```python
def string_of_nat(n):
    return str(n)
```

> 注：代码本身无法修——如果 Coq 侧没有给出具体定义，Python 侧任何实现都是假设。需要确认 Coq 项目中 `string_of_nat` 的具体实例化。

---

### 17. Human / HumanEval_76（6 eq / 3 neq）

**状态**：分析认为等价，但 judge 未通过，需复核

**问题**：反对票对负数基底的幂运算做了详尽分析，多数反对者在分析过程中自我修正为等价。

**修复前/后**：无代码修改。

> 注：仍在非全票列表中，不做定性。建议用测试用例（`n=-2, x=4`；`n=0, x=0`；`n=-1, x=-1` 等）验证行为一致性，提交 judge 复核。

---

### 18. GPT-5 / HumanEval_95（6 eq / 3 neq）

**状态**：有候选修复，待验证（取决于 Coq 侧定义）

**问题**：`IsLower('123')` 和 `IsUpper('123')` 在 Python 下同时返回 True，因为 `'123'.lower() == '123'` 且 `'123'.upper() == '123'`。Coq 侧 `IsLower` 和 `IsUpper` 是抽象谓词，语义不明。

**修复前**：
```python
def IsLower(s):
    return s == s.lower()

def IsUpper(s):
    return s == s.upper()
```

**候选修复 A**（如果 Coq 要求至少含一个对应大小写字母）：
```python
def IsLower(s):
    return s == s.lower() and any(c.isalpha() for c in s)

def IsUpper(s):
    return s == s.upper() and any(c.isalpha() for c in s)
```

**候选修复 B**（如果 Coq 也是 `s == lowercase(s)` 语义）：
```python
# 无需修改
```

> 注：无法在不查看 Coq 侧 `IsLower`/`IsUpper` 定义的情况下确定修复方向。

---

## 汇总

| # | 模型 | 题号 | 状态 | 修复方向 |
|---|------|------|------|---------|
| 1 | Claude-3.7 | HumanEval_9 | ✅ 有确定修复 | prefix_max 递归语义 |
| 2 | Claude-Opus-4.5 | HumanEval_50 | ✅ 有确定修复 | 量化域扩展到全 ASCII |
| 3 | Claude-Opus-4.5 | HumanEval_69 | ✅ 有确定修复 | 补 `result == -1` 分支 |
| 4 | Claude-Opus-4.5 | HumanEval_143 | ⚠️ 候选修复，待验证 | filter 不过滤 + In 语义 |
| 5 | Claude-Opus-4.5 | HumanEval_149 | ⚠️ 候选修复，待验证 | In 双向条件显式化 |
| 6 | Claude-Opus-4.5 | HumanEval_155 | 🔧 Coq spec bug，需上游修 | `return False` 待复核 |
| 7 | Claude-Opus-4.5 | HumanEval_99 | ⚠️ 候选修复，待验证 | `up()`: floor+1 → ceil |
| 8 | Deepseek-v3.1 | HumanEval_130 | ✅ 有确定修复 | 补 forall 验证 |
| 9 | Deepseek-v3.1 | HumanEval_139 | 🔍 分析倾向等价，需复核 | 外层 fac 不被内层遮蔽 |
| 10 | Human | HumanEval_12 | ⚠️ 候选修复，待验证 | vacuous existential 退化 |
| 11 | Human | HumanEval_71 | ✅ 有确定修复 | `Fraction(float)` → `Fraction(str(...))` |
| 12 | Human | HumanEval_75 | 🔍 分析倾向等价，需复核 | 边界测试验证 |
| 13 | Gemini | HumanEval_49 | ✅ 有确定修复 | mod 0 和负模数语义 |
| 14 | Claude-Opus-4.5 | HumanEval_49 | 🔍 分析倾向等价，需复核 | 需验证 Z.pow 负指数 |
| 15 | GPT-5 | HumanEval_137 | ⚠️ 候选修复，待验证 | `Fraction(str())` vs `Fraction(float)` |
| 16 | Gemini | HumanEval_113 | 🔍 分析倾向等价，需复核 | 需确认 Coq 侧定义 |
| 17 | Human | HumanEval_76 | 🔍 分析倾向等价，需复核 | 边界测试验证 |
| 18 | GPT-5 | HumanEval_95 | ⚠️ 候选修复，待验证 | 需查 Coq 侧 IsLower 定义 |

图例：✅ 确定修复 ｜ ⚠️ 候选修复待验证 ｜ 🔍 分析倾向等价但需复核 ｜ 🔧 上游 bug