def is_delimiter(c: str) -> bool:
    return c == ',' or c == ' '

def words_string_aux(current_word: list, input_chars: list) -> list:
    res = []
    curr = list(current_word)
    for c in input_chars:
        if is_delimiter(c):
            if curr:
                res.append(curr)
                curr = []
        else:
            curr.append(c)
    if curr:
        res.append(curr)
    return res

def words_string_list_impl(s: list) -> list:
    return words_string_aux([], s)

def words_string(s: str) -> list:
    return ["".join(chars) for chars in words_string_list_impl(list(s))]

def problem_101_pre(s: str) -> bool:
    for c in s:
        n = ord(c)
        if not ((65 <= n <= 90) or (97 <= n <= 122) or c == ',' or c == ' '):
            return False
    return True

def problem_101_spec(s: str, output: list) -> bool:
    return output == words_string(s)

def _impl(s):
    words = (s.replace(",", " ")).split()
    return [word for word in words if word != ""]

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_101_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_101_spec(*input, output))

def words_string(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
