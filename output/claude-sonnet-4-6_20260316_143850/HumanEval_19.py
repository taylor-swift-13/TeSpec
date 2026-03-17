from typing import List

def precondition(input):
    numbers = input[0]
    if not isinstance(numbers, str):
        return False
    valid = {'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'}
    if numbers.strip() == '':
        return False
    tokens = numbers.split(' ')
    for token in tokens:
        if token not in valid:
            return False
    return True


def postcondition(input, output):
    if not isinstance(output, str):
        return False
    order = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
    input_tokens = input[0].split(' ')
    output_tokens = output.split(' ')
    if sorted(input_tokens) != sorted(output_tokens):
        return False
    if len(output_tokens) != len(input_tokens):
        return False
    for token in output_tokens:
        if token not in order:
            return False
    for i in range(len(output_tokens) - 1):
        if order.index(output_tokens[i]) > order.index(output_tokens[i + 1]):
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
