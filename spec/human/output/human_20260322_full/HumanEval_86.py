def is_space_bool(c):
    return c == ' '

def insert_char(c, s):
    for i, h in enumerate(s):
        if ord(c) <= ord(h):
            return s[:i] + c + s[i:]
    return s + c

def sort_chars(s):
    return "".join(sorted(s))

def anti_shuffle_aux(s, acc):
    result = []
    current_acc = acc
    for c in s:
        if is_space_bool(c):
            result.append(sort_chars(current_acc))
            result.append(c)
            current_acc = ""
        else:
            current_acc = c + current_acc
    result.append(sort_chars(current_acc))
    return "".join(result)

def anti_shuffle_impl(s):
    return anti_shuffle_aux(s, "")

def problem_86_pre(s):
    return True

def problem_86_spec(s, s_out):
    return s_out == anti_shuffle_impl(s)

def _impl(s):
    words = s.split(" ")
    return " ".join(map(lambda x: "".join(sorted(x, key=lambda ch: ord(ch))), words))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_86_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_86_spec(*input, output))

def anti_shuffle(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
