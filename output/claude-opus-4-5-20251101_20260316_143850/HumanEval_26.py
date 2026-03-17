from typing import List

def precondition(input):
    if len(input) != 1:
        return False
    numbers = input[0]
    if not isinstance(numbers, list):
        return False
    for item in numbers:
        if not isinstance(item, int):
            return False
    return True

def postcondition(input, output):
    numbers = input[0]
    if not isinstance(output, list):
        return False
    for item in output:
        if not isinstance(item, int):
            return False
    # Count occurrences in original list
    from collections import Counter
    counts = Counter(numbers)
    # All elements in output should have count of 1 in original
    for item in output:
        if counts[item] != 1:
            return False
    # All elements that occur exactly once in input should be in output
    unique_elements = [x for x in numbers if counts[x] == 1]
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
