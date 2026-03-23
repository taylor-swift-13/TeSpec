def is_separator(c: str) -> bool:
    return c == " " or c == ","

def words_string_aux(s: str, acc: str) -> list:
    res = []
    for c in s:
        if is_separator(c):
            if acc == "":
                pass
            else:
                res.append(acc)
                acc = ""
        else:
            acc += c
    if acc != "":
        res.append(acc)
    return res

def words_string_spec(s: str, result: list) -> bool:
    return result == words_string_aux(s, "")

def _impl(s):
    words = (s.replace(",", " ")).split()
    return [word for word in words if word != ""]

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(words_string_spec(*input, output))

def words_string(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
