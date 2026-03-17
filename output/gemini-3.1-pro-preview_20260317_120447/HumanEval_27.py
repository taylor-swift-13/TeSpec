
def precondition(inputs):
    if len(inputs) != 1:
        return False
    if not isinstance(inputs[0], str):
        return False
    return True

def postcondition(inputs, output):
    if not isinstance(output, str):
        return False
    return output == inputs[0].swapcase()

def _impl(string: str) -> str:
    """For a given string, flip lowercase characters to uppercase and uppercase to lowercase.
    'hELLO'"""
    return "".join(map(lambda x: x.swapcase(), string))

def flip_case(string: str) -> str:
    _input = (string,)
    assert precondition(_input)
    _output = _impl(string)
    assert postcondition(_input, _output)
    return _output
