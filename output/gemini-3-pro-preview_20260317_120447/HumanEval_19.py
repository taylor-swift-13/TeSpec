from typing import List

def precondition(input):
    if not isinstance(input[0], str):
        return False
    valid = {'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'}
    parts = input[0].split(' ')
    return all(part in valid for part in parts)

def postcondition(input, output):
    if not isinstance(output, str):
        return False
    mapping = {
        'zero': 0, 'one': 1, 'two': 2, 'three': 3, 'four': 4,
        'five': 5, 'six': 6, 'seven': 7, 'eight': 8, 'nine': 9
    }
    in_parts = input[0].split(' ')
    try:
        expected = sorted(in_parts, key=lambda x: mapping[x])
        return output == ' '.join(expected)
    except KeyError:
        return False

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
