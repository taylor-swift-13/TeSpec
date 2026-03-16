from typing import List

def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    tokens = [t for t in s.split() if t != ""]
    if len(tokens) == 0:
        return False
    allowed = {'zero','one','two','three','four','five','six','seven','eight','nine'}
    for t in tokens:
        if t not in allowed:
            return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    if not isinstance(output, str):
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    tokens = [t for t in s.split() if t != ""]
    if len(tokens) == 0:
        return False
    allowed = {'zero','one','two','three','four','five','six','seven','eight','nine'}
    for t in tokens:
        if t not in allowed:
            return False
    order = ['zero','one','two','three','four','five','six','seven','eight','nine']
    index = {name: i for i, name in enumerate(order)}
    sorted_tokens = sorted(tokens, key=lambda x: index[x])
    expected = ' '.join(sorted_tokens)
    return output == expected

def _impl(numbers: str) -> str:
    """Input is a space-delimited string of numberals from 'zero' to 'nine'.
    Valid choices are 'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight' and 'nine'.
    Return the string with numbers sorted from smallest to largest
    'one three five'"""
    to_int = {'zero': 0, 'one': 1, 'two': 2, 'three': 3, 'four': 4, 'five': 5, 'six': 6, 'seven': 7, 'eight': 8, 'nine': 9}

    if numbers == "": return ""
    return " ".join(sorted(numbers.split(" "), key=lambda n: to_int[n]))

def sort_numbers(numbers: str) -> str:
    _input = (numbers,)
    assert precondition(_input)
    _output = _impl(numbers)
    assert postcondition(_input, _output)
    return _output
