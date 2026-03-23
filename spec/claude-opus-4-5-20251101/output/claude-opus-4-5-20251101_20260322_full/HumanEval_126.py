def count_occurrences(x, lst):
    return lst.count(x)

def no_more_than_two_duplicates(lst):
    for x in lst:
        if count_occurrences(x, lst) > 2:
            return False
    return True

def is_ascending(lst):
    for i in range(len(lst) - 1):
        if lst[i] > lst[i + 1]:
            return False
    return True

def is_sorted_spec(lst, result):
    expected = is_ascending(lst) and no_more_than_two_duplicates(lst)
    return bool(result) == expected

def _impl(lst):
    count = dict()
    for x in lst:
        if x not in count: count[x] = 0
        count[x] += 1
        if count[x] > 2: return False
    return lst == sorted(lst)

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(is_sorted_spec(*input, output))

def is_sorted(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
