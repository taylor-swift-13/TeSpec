from typing import List

from collections import Counter
from collections.abc import Sequence

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) < 1:
        return False
    numbers = input[0]
    # accept list or tuple of ints
    if not isinstance(numbers, Sequence) or isinstance(numbers, (str, bytes)):
        return False
    try:
        # ensure we can iterate and check ints
        for x in numbers:
            if not isinstance(x, int):
                return False
    except TypeError:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    numbers = list(input[0])
    # output should be a sequence (list or tuple), but not str/bytes
    if not isinstance(output, Sequence) or isinstance(output, (str, bytes)):
        return False
    try:
        for x in output:
            if not isinstance(x, int):
                return False
    except TypeError:
        return False
    counts = Counter(numbers)
    # output should contain exactly the elements that appear exactly once in numbers,
    # in the same order as in numbers, and have no duplicates
    uniques_in_input = [x for x in numbers if counts[x] == 1]
    # Convert output to list for comparison while allowing tuple outputs
    output_list = list(output)
    if output_list != uniques_in_input:
        return False
    # Ensure no duplicates in output
    if len(output_list) != len(set(output_list)):
        return False
    # Ensure every element in output occurred exactly once in the original input
    for x in output_list:
        if counts[x] != 1:
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
