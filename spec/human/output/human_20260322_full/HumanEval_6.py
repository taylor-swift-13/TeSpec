from typing import List

lparen = "("
rparen = ")"
space = " "

def max_depth_aux(g: str, current_depth: int, max_seen: int) -> int:
    for h in g:
        if h == lparen:
            current_depth += 1
            max_seen = max(max_seen, current_depth)
        elif h == rparen:
            current_depth = max(0, current_depth - 1)
    return max_seen

def MaxDepth(g: str) -> int:
    return max_depth_aux(g, 0, 0)

def SplitOnSpaces_aux(current_group: list, S: str) -> list:
    res = []
    curr = list(current_group)
    for h in S:
        if h == space:
            if curr:
                res.append("".join(reversed(curr)))
                curr = []
        else:
            curr.insert(0, h)
    if curr:
        res.append("".join(reversed(curr)))
    return res

def SplitOnSpaces(S: str) -> list:
    return SplitOnSpaces_aux([], S)

def is_paren_or_space(c: str) -> bool:
    return c == lparen or c == rparen or c == space

def IsBalanced_aux(l: str, count: int) -> bool:
    for h in l:
        if h == lparen:
            count += 1
        elif h == rparen:
            if count == 0:
                return False
            count -= 1
    return count == 0

def IsBalanced(l: str) -> bool:
    return IsBalanced_aux(l, 0)

def parse_nested_parens_impl(input: str) -> list:
    return [MaxDepth(g) for g in SplitOnSpaces(input)]

def ForallChars(P, s: str) -> bool:
    for h in s:
        if not P(h):
            return False
    return True

def problem_6_pre(input: str) -> bool:
    return ForallChars(is_paren_or_space, input) and IsBalanced(input)

def problem_6_spec(input: str, output: list) -> bool:
    return output == parse_nested_parens_impl(input)

def _impl(paren_string: str) -> List[int]:
    def count_depth(s: str) -> int:
        max_depth, cnt = 0, 0
        for ch in s:
            if ch == "(": cnt += 1
            if ch == ")": cnt -= 1
            max_depth = max(max_depth, cnt)
        return max_depth
    return [count_depth(s) for s in paren_string.split(" ") if s != ""]

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_6_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_6_spec(*input, output))

def parse_nested_parens(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
