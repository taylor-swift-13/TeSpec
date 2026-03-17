from typing import List

def precondition(input) -> bool:
    if len(input) != 1:
        return False
    numbers = input[0]
    if not isinstance(numbers, list):
        return False
    for x in numbers:
        if not isinstance(x, int):
            return False
    return True


def postcondition(input, output) -> bool:
    numbers = input[0]
    if not isinstance(output, list):
        return False
    from collections import Counter
    counts = Counter(numbers)
    expected = [x for x in numbers if counts[x] == 1]
    if output != expected:
        return False
    for x in output:
        if not isinstance(x, int):
            return False
        if counts[x] != 1:
            return False
    for x in output:
        if x not in numbers:
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
