from typing import List

def precondition(input):
    # input is a tuple of positional arguments
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    numbers_str = input[0]
    if not isinstance(numbers_str, str):
        return False
    tokens = numbers_str.split()
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
    numbers_str = input[0]
    tokens = numbers_str.split()
    allowed = {'zero','one','two','three','four','five','six','seven','eight','nine'}
    order = {
        'zero': 0, 'one': 1, 'two': 2, 'three': 3, 'four': 4,
        'five': 5, 'six': 6, 'seven': 7, 'eight': 8, 'nine': 9
    }
    for t in tokens:
        if t not in allowed:
            return False
    expected_tokens = sorted(tokens, key=lambda t: order[t])
    out_tokens = output.split()
    return out_tokens == expected_tokens

def _impl(numbers: str) -> str:
    """
    Input is a space-delimited string of numberals from 'zero' to 'nine'.
    Valid choices are 'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight' and 'nine'.
    Return the string with numbers sorted from smallest to largest
    'one three five'
    """
    to_int = {'zero': 0, 'one': 1, 'two': 2, 'three': 3, 'four': 4, 'five': 5, 'six': 6, 'seven': 7, 'eight': 8, 'nine': 9}

    if numbers == "": return ""
    return " ".join(sorted(numbers.split(" "), key=lambda n: to_int[n]))

def sort_numbers(numbers: str) -> str:
    _input = (numbers,)
    assert precondition(_input)
    _output = _impl(numbers)
    assert postcondition(_input, _output)
    return _output
