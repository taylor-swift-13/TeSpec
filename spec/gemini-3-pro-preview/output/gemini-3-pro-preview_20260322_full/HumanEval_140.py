def count_consecutive_spaces(s: str) -> int:
    count = 0
    for c in s:
        if c == ' ':
            count += 1
        else:
            break
    return count

def skip_n(n: int, s: str) -> str:
    return s[n:]

def fix_spaces_spec(text: str, ans: str) -> bool:
    i = 0
    n = len(text)
    out = []
    while i < n:
        if text[i] != ' ':
            out.append(text[i])
            i += 1
        else:
            count = count_consecutive_spaces(text[i:])
            if count <= 2:
                out.append('_')
                i += 1
            else:
                out.append('-')
                i += count
    return "".join(out) == ans

def _impl(text):
    ans = text
    for i in range(len(text), 2, -1):
        ans = ans.replace(" " * i, "-")
    return ans.replace(" ", "_")

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(fix_spaces_spec(*input, output))

def fix_spaces(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
