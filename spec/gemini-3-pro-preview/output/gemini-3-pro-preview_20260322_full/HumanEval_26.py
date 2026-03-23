from typing import List

def remove_duplicates_spec(numbers, result):
    expected = [x for x in numbers if numbers.count(x) == 1]
    return result == expected

def _impl(numbers: List[int]) -> List[int]:
    num_cnt = dict()
    for number in numbers:
        if number not in num_cnt:
            num_cnt[number] = 0
        num_cnt[number] += 1
    return [number for number in numbers if num_cnt[number] == 1]

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(remove_duplicates_spec(*input, output))

def remove_duplicates(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
