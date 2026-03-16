from typing import List

def precondition(input):
    numbers, = input
    return isinstance(numbers, list) and all(isinstance(x, int) for x in numbers)

def postcondition(input, output):
    numbers, = input
    if not isinstance(output, list):
        return False
    if not all(isinstance(x, int) for x in output):
        return False
    # output must be subsequence of input (preserving order)
    it = iter(numbers)
    for out_elem in output:
        try:
            while next(it) != out_elem:
                pass
        except StopIteration:
            return False
    # every element in output must appear exactly once in input
    for elem in output:
        if numbers.count(elem) != 1:
            return False
    # every element that appears exactly once in input must be in output
    for elem in numbers:
        if numbers.count(elem) == 1 and elem not in output:
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
