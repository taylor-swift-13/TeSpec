from typing import List

def problem_26_pre(input):
    return True

def problem_26_spec(input, output):
    expected = [x for x in input if input.count(x) == 1]
    return output == expected

def _impl(numbers: List[int]) -> List[int]:
    num_cnt = dict()
    for number in numbers:
        if number not in num_cnt:
            num_cnt[number] = 0
        num_cnt[number] += 1
    return [number for number in numbers if num_cnt[number] == 1]

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_26_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_26_spec(*input, output))

def remove_duplicates(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
