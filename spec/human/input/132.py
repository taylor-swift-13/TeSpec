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
