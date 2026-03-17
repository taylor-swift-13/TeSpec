
def precondition(input):
    if len(input) != 1:
        return False
    string = input[0]
    if not isinstance(string, str):
        return False
    return True


def postcondition(input, output):
    if not isinstance(output, str):
        return False
    string = input[0]
    if len(output) != len(string):
        return False
    for i, (orig, flipped) in enumerate(zip(string, output)):
        if orig.isalpha():
            if orig.islower() and not flipped.isupper():
                return False
            if orig.isupper() and not flipped.islower():
                return False
        else:
            if flipped != orig:
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
