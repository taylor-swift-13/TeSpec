
def precondition(input_args):
    return len(input_args) == 1 and isinstance(input_args[0], str)

def postcondition(input_args, output):
    if not isinstance(output, str):
        return False
    s = input_args[0]
    if len(s) != len(output):
        return False
    for char_in, char_out in zip(s, output):
        if char_in.islower():
            if char_out != char_in.upper():
                return False
        elif char_in.isupper():
            if char_out != char_in.lower():
                return False
        else:
            if char_out != char_in:
                return False
    return True

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
