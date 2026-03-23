def is_sorted_spec(lst, res):
    is_sorted = all(lst[i] <= lst[i+1] for i in range(len(lst)-1))
    
    all_le_2 = True
    counts = {}
    for x in lst:
        counts[x] = counts.get(x, 0) + 1
        if counts[x] > 2:
            all_le_2 = False
            break
            
    expected = is_sorted and all_le_2
    return bool(res) == expected

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
