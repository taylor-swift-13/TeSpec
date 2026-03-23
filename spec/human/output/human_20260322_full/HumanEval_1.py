from typing import List

lparen = "("
rparen = ")"
space = " "

def IsBalanced_aux(s: str, count: int) -> bool:
    for h in s:
        if h == lparen:
            count += 1
        elif h == rparen:
            if count == 0:
                return False
            count -= 1
        else:
            pass
    return count == 0

def IsBalanced(s: str) -> bool:
    return IsBalanced_aux(s, 0)

def remove_spaces(s: str) -> str:
    return s.replace(space, "")

def is_paren_or_space(c: str) -> bool:
    return c == lparen or c == rparen or c == space

def ForallChars(P, s: str) -> bool:
    return all(P(c) for c in s)

def separate_paren_groups_aux(s: str, count: int, current: list, acc: list) -> list:
    current = list(current)
    acc = list(acc)
    for h in s:
        if h == lparen:
            count += 1
            current.append(h)
        elif h == rparen:
            if count == 0:
                return acc
            count -= 1
            current.append(h)
            if count == 0:
                acc.append("".join(current))
                current = []
        elif h == space:
            pass
        else:
            current.append(h)
    if current:
        acc.append("".join(current))
    return acc

def separate_paren_groups_impl(input: str) -> list:
    return separate_paren_groups_aux(remove_spaces(input), 0, [], [])

def problem_1_pre(input: str) -> bool:
    return ForallChars(is_paren_or_space, input) and IsBalanced(remove_spaces(input))

def problem_1_spec(input: str, output: list) -> bool:
    return output == separate_paren_groups_impl(input)

def _impl(paren_string: str) -> List[str]:
    cnt, group, results = 0, "", []
    for ch in paren_string:
        if ch == "(": cnt += 1
        if ch == ")": cnt -= 1
        if ch != " ": group += ch
        if cnt == 0:
            if group != "": results.append(group)
            group = ""
    return results

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_1_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_1_spec(*input, output))

def separate_paren_groups(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
