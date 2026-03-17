from typing import List

def precondition(input):
    if len(input) != 1:
        return False
    numbers = input[0]
    if not isinstance(numbers, str):
        return False
    valid_words = {'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'}
    if numbers == '':
        return True
    words = numbers.split(' ')
    for word in words:
        if word not in valid_words:
            return False
    return True


def postcondition(input, output):
    if not isinstance(output, str):
        return False
    numbers = input[0]
    valid_words = {'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'}
    word_to_num = {
        'zero': 0, 'one': 1, 'two': 2, 'three': 3, 'four': 4,
        'five': 5, 'six': 6, 'seven': 7, 'eight': 8, 'nine': 9
    }
    if numbers == '':
        return output == ''
    input_words = numbers.split(' ')
    if output == '':
        return False
    output_words = output.split(' ')
    if len(input_words) != len(output_words):
        return False
    for word in output_words:
        if word not in valid_words:
            return False
    if sorted(input_words) != sorted(output_words):
        return False
    output_nums = [word_to_num[w] for w in output_words]
    for i in range(len(output_nums) - 1):
        if output_nums[i] > output_nums[i + 1]:
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
