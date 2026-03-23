from typing import List

def problem_11_pre(a: str, b: str) -> bool:
    if len(a) != len(b):
        return False
    for i in range(len(a)):
        if a[i] not in ('0', '1') or b[i] not in ('0', '1'):
            return False
    return True

def problem_11_spec(a: str, b: str, output: str) -> bool:
    if len(a) != len(b):
        return False
    if len(output) != len(a):
        return False
    for i in range(len(output)):
        if a[i] == b[i]:
            if output[i] != '0':
                return False
        else:
            if output[i] != '1':
                return False
    return True

def _impl(a: str, b: str) -> str:
    return "".join(str(int(a[i]) ^ int(b[i])) for i in range(len(a)))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_11_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_11_spec(*input, output))

def string_xor(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
