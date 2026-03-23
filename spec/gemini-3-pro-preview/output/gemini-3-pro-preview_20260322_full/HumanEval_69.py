def search_spec(lst, ans):
    counts = {}
    for x in lst:
        counts[x] = counts.get(x, 0) + 1
    
    valid_xs = []
    for x, c in counts.items():
        if x > 0 and c >= x:
            valid_xs.append(x)
            
    if not valid_xs:
        correct_ans = -1
    else:
        correct_ans = max(valid_xs)
        
    return ans == correct_ans

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
