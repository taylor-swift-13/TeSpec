from typing import List

def precondition(input) -> bool:
    # input is a tuple of positional args; expect first arg is the string
    try:
        if not isinstance(input, (list, tuple)):
            return False
        if len(input) < 1:
            return False
        s = input[0]
        if not isinstance(s, str):
            return False
    except Exception:
        return False

    # allow only parentheses and spaces
    for ch in s:
        if ch not in ("(", ")", " "):
            return False

    # check overall balanced ignoring spaces
    t = "".join(ch for ch in s if ch != " ")
    depth = 0
    for ch in t:
        if ch == "(":
            depth += 1
        else:  # ch == ")"
            depth -= 1
            if depth < 0:
                return False
    if depth != 0:
        return False

    return True


def postcondition(input, output) -> bool:
    # input is tuple; output should be a list/tuple of group strings
    try:
        if not isinstance(input, (list, tuple)):
            return False
        if len(input) < 1:
            return False
        s = input[0]
        if not isinstance(s, str):
            return False
    except Exception:
        return False

    # normalize input by removing spaces
    target = "".join(ch for ch in s if ch != " ")

    # output must be a sequence (list or tuple)
    if not isinstance(output, (list, tuple)):
        return False

    # if target empty, expect empty output
    if target == "":
        return len(output) == 0

    # each element must be a non-empty string of parentheses, balanced,
    # and represent exactly one top-level group (depth > 0 at all prefixes except final)
    parts = []
    for item in output:
        if not isinstance(item, str):
            return False
        # remove spaces in output parts (function is specified to ignore spaces in input;
        # be tolerant if outputs contain spaces)
        part = "".join(ch for ch in item if ch != " ")
        if part == "":
            return False
        # only parentheses
        for ch in part:
            if ch not in ("(", ")"):
                return False
        # balanced check
        depth = 0
        min_prefix_depth = None
        for i, ch in enumerate(part):
            if ch == "(":
                depth += 1
            else:
                depth -= 1
            if depth < 0:
                return False
            # track prefix depths before the final character
            if i < len(part) - 1:
                if min_prefix_depth is None or depth < min_prefix_depth:
                    min_prefix_depth = depth
        if depth != 0:
            return False
        # ensure it's a single top-level group: prefix depths before end must be >=1
        if min_prefix_depth is None:
            # part has length 1? impossible for balanced parentheses
            return False
        if min_prefix_depth < 1:
            return False
        parts.append(part)

    # concatenation of parts must equal target
    if "".join(parts) != target:
        return False

    return True

def _impl(paren_string: str) -> List[str]:
    """Input to this function is a string containing multiple groups of nested parentheses. Your goal is to
    separate those group into separate strings and return the list of those.
    Separate groups are balanced (each open brace is properly closed) and not nested within each other
    Ignore any spaces in the input string.
    ['()', '(())', '(()())']"""
    cnt, group, results = 0, "", []
    for ch in paren_string:
        if ch == "(": cnt += 1
        if ch == ")": cnt -= 1
        if ch != " ": group += ch
        if cnt == 0:
            if group != "": results.append(group)
            group = ""
    return results

def separate_paren_groups(paren_string: str) -> List[str]:
    _input = (paren_string,)
    assert precondition(_input)
    _output = _impl(paren_string)
    assert postcondition(_input, _output)
    return _output
