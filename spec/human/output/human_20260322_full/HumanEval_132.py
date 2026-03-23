def contains_subseq(s: list, target: list) -> bool:
    if not target:
        return True
    t_idx = 0
    for c in s:
        if c == target[t_idx]:
            t_idx += 1
            if t_idx == len(target):
                return True
    return False

def is_nested(s: str) -> bool:
    return contains_subseq(list(s), ['[', '[', ']', ']'])

def problem_132_pre(s: str) -> bool:
    return all(c == '[' or c == ']' for c in s)

def problem_132_spec(s: str, output: bool) -> bool:
    return output == is_nested(s)

def _impl(string):
    for i in range(len(string)):
        if string[i] == "]": continue
        cnt, max_nest = 0, 0
        for j in range(i, len(string)):
            if string[j] == "[":
                cnt += 1
            else:
                cnt -= 1
            max_nest = max(max_nest, cnt)
            if cnt == 0:
                if max_nest >= 2:
                    return True
                break
    return False

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_132_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_132_spec(*input, output))

def is_nested(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
