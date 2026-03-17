from typing import List

def precondition(inp):
    if len(inp) != 1:
        return False
    numbers = inp[0]
    if not isinstance(numbers, str):
        return False
    valid = {'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'}
    return all(word in valid for word in numbers.split())

def postcondition(inp, out):
    if len(inp) != 1:
        return False
    numbers = inp[0]
    if not isinstance(out, str):
        return False
    val = {
        'zero': 0, 'one': 1, 'two': 2, 'three': 3, 'four': 4,
        'five': 5, 'six': 6, 'seven': 7, 'eight': 8, 'nine': 9
    }
    in_words = numbers.split()
    out_words = out.split()
    if sorted(in_words) != sorted(out_words):
        return False
    if out != ' '.join(out_words):
        return False
    try:
        out_vals = [val[w] for w in out_words]
    except KeyError:
        return False
    return out_vals == sorted(out_vals)

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
