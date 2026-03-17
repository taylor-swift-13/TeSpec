
def precondition(input) -> bool:
    # Check that input is a tuple with exactly one element
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    
    s = input[0]
    
    # Check that s is a string
    if not isinstance(s, str):
        return False
    
    return True


def postcondition(input, output) -> bool:
    # Check that input satisfies precondition
    if not precondition(input):
        return False
    
    s = input[0]
    
    # Check that output is a string
    if not isinstance(output, str):
        return False
    
    # Check that output has the same length as input
    if len(output) != len(s):
        return False
    
    # Check that output contains the same characters as input (just rearranged)
    if sorted(output) != sorted(s):
        return False
    
    return True

def _impl(s: str):
    """takes as input string encoded with encode_cyclic function. Returns decoded string.
    """
    groups = [s[(3 * i):min((3 * i + 3), len(s))] for i in range((len(s) + 2) // 3)]
    groups = [(group[2] + group[:2]) if len(group) == 3 else group for group in groups]
    return "".join(groups)

def decode_cyclic(s: str):
    _input = (s,)
    assert precondition(_input)
    _output = _impl(s)
    assert postcondition(_input, _output)
    return _output
