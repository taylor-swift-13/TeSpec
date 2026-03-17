from typing import List

def precondition(args) -> bool:
    if len(args) != 1:
        return False
    numbers = args[0]
    if not isinstance(numbers, list):
        return False
    return all(isinstance(x, int) for x in numbers)

def postcondition(args, output) -> bool:
    numbers = args[0]
    if not isinstance(output, list):
        return False
    expected = [x for x in numbers if numbers.count(x) == 1]
    return output == expected

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
