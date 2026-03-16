from typing import List

from collections import Counter

_allowed = {
    'zero': 0, 'one': 1, 'two': 2, 'three': 3, 'four': 4,
    'five': 5, 'six': 6, 'seven': 7, 'eight': 8, 'nine': 9
}

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) < 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    # allow empty or whitespace-only string
    tokens = s.split()
    for t in tokens:
        if t not in _allowed:
            return False
    return True

def postcondition(input, output):
    # If precondition does not hold, consider postcondition vacuously true
    if not precondition(input):
        return True
    if not isinstance(output, str):
        return False
    s = input[0]
    in_tokens = s.split()
    out_tokens = output.split()
    # If there were no input tokens, expect output to be empty or whitespace
    if len(in_tokens) == 0:
        return output.strip() == ''
    # All output tokens must be valid
    for t in out_tokens:
        if t not in _allowed:
            return False
    # Multiset of tokens must be preserved
    if Counter(in_tokens) != Counter(out_tokens):
        return False
    # Output tokens must be in non-decreasing numeric order
    for a, b in zip(out_tokens, out_tokens[1:]):
        if _allowed[a] > _allowed[b]:
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
