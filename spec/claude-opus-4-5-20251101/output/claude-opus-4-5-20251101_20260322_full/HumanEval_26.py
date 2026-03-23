from typing import List

def count_occurrences(n: int, l: list) -> int:
    """
    Counts the number of occurrences of n in list l.
    Equivalent to Coq's count_occurrences.
    """
    return len([x for x in l if x == n])

def occurs_once(n: int, l: list) -> bool:
    """
    Returns True if n occurs exactly once in list l.
    Equivalent to Coq's occurs_once Prop.
    """
    return count_occurrences(n, l) == 1

def remove_duplicates_spec(numbers: list, result: list) -> bool:
    """
    Checks if result is equal to the list of elements from numbers that appear exactly once.
    Equivalent to Coq's remove_duplicates_spec.
    Note: Despite the name 'remove_duplicates', the Coq spec specifically filters 
    for elements that have a count of exactly 1.
    """
    expected = [n for n in numbers if count_occurrences(n, numbers) == 1]
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
