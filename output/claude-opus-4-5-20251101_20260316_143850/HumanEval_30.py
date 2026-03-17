
def precondition(input):
    l = input[0]
    if not isinstance(l, list):
        return False
    for item in l:
        if not isinstance(item, (int, float)):
            return False
    return True

def postcondition(input, output):
    l = input[0]
    if not isinstance(output, list):
        return False
    # All items in output should be positive
    for item in output:
        if not isinstance(item, (int, float)):
            return False
        if item <= 0:
            return False
    # All positive items from input should be in output
    positive_in_input = [x for x in l if isinstance(x, (int, float)) and x > 0]
    if len(output) != len(positive_in_input):
        return False
    # Check that output contains exactly the positive numbers from input in order
    output_idx = 0
    for item in l:
        if isinstance(item, (int, float)) and item > 0:
            if output_idx >= len(output) or output[output_idx] != item:
                return False
            output_idx += 1
    return True

def _impl(l: list):
    """Return only positive numbers in the list.
    [2, 5, 6]
    [5, 3, 2, 3, 9, 123, 1]"""
    return list(filter(lambda x: x > 0, l))

def get_positive(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
