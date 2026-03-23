def IsLow(c: str) -> bool:
    return ord('a') <= ord(c) <= ord('z')

def IsUp(c: str) -> bool:
    return ord('A') <= ord(c) <= ord('Z')

def Upper(c: str) -> str:
    if ord('a') <= ord(c) <= ord('z'):
        return chr(ord(c) - 32)
    return c

def Lower(c: str) -> str:
    if ord('A') <= ord(c) <= ord('Z'):
        return chr(ord(c) + 32)
    return c

def problem_27_pre(input: str) -> bool:
    return True

def problem_27_spec(input: str, output: str) -> bool:
    if len(input) != len(output):
        return False
    
    for i in range(len(input)):
        c = input[i]
        out_c = output[i]
        
        if IsLow(c):
            if out_c != Upper(c):
                return False
        if IsUp(c):
            if out_c != Lower(c):
                return False
        if not IsLow(c) and not IsUp(c):
            if out_c != c:
                return False
                
    return True

def _impl(string: str) -> str:
    return "".join(map(lambda x: x.swapcase(), string))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_27_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_27_spec(*input, output))

def flip_case(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
