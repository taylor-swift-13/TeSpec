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

def _orig_rolling_max_spec(numbers, output):
    if len(output) != len(numbers):
        return False
    for i in range(len(numbers)):
        prefix = numbers[:i + 1]
        expected = 0
        for n in prefix:
            expected = max(expected, n)
        if output[i] != expected:
            return False
    return True

def rolling_max_spec(numbers, output):
    return bool(_orig_rolling_max_spec(numbers, output))
