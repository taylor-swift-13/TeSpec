from typing import List

def precondition(input):
    numbers = input[0]
    if not isinstance(numbers, str):
        return False
    valid = {'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'}
    parts = numbers.split()
    return all(p in valid for p in parts)

def postcondition(input, output):
    if not isinstance(output, str):
        return False
    mapping = {
        'zero': 0, 'one': 1, 'two': 2, 'three': 3, 'four': 4,
        'five': 5, 'six': 6, 'seven': 7, 'eight': 8, 'nine': 9
    }
    input_parts = input[0].split()
    output_parts = output.split()
    if len(input_parts) != len(output_parts):
        return False
    if sorted(input_parts, key=lambda x: mapping[x]) != output_parts:
        return False
    return True

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
