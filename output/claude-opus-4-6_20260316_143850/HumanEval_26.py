from typing import List

def precondition(input):
    numbers = input[0]
    if not isinstance(numbers, list):
        return False
    if not all(isinstance(n, int) for n in numbers):
        return False
    return True


def postcondition(input, output):
    numbers = input[0]
    if not isinstance(output, list):
        return False
    if not all(isinstance(n, int) for n in output):
        return False
    # All elements in output should appear exactly once in the input
    from collections import Counter
    counts = Counter(numbers)
    for elem in output:
        if counts[elem] != 1:
            return False
    # All elements that appear exactly once in input should be in output
    unique_elements = [n for n in numbers if counts[n] == 1]
    if len(output) != len(unique_elements):
        return False
    # Order should be preserved (same as order of unique elements in input)
    if output != unique_elements:
        return False
    return True

def _impl(numbers: List[int]) -> List[int]:
    """From a list of integers, remove all elements that occur more than once.
    Keep order of elements left the same as in the input.
    [1, 3, 4]"""
    num_cnt = dict()
    for number in numbers:
        if number not in num_cnt:
            num_cnt[number] = 0
        num_cnt[number] += 1
    return [number for number in numbers if num_cnt[number] == 1]

def remove_duplicates(numbers: List[int]) -> List[int]:
    _input = (numbers,)
    assert precondition(_input)
    _output = _impl(numbers)
    assert postcondition(_input, _output)
    return _output
