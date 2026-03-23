def count_occurrences(n, lst):
    return lst.count(n)

def valid_candidate(n, lst):
    return n > 0 and n in lst and count_occurrences(n, lst) >= n

def search_spec(lst, result):
    valid_candidates = [n for n in set(lst) if valid_candidate(n, lst)]
    if valid_candidates:
        return result == max(valid_candidates)
    else:
        return result == -1

def _impl(lst):
    count = dict()
    for num in lst:
        if num not in count:
            count[num] = 0
        count[num] += 1
    ans = -1
    for num, cnt in count.items():
        if cnt >= num:
            ans = max(ans, num)
    return ans

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(search_spec(*input, output))

def search(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
