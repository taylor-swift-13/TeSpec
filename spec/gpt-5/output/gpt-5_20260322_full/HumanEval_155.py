def count_even(l):
    count = 0
    for d in l:
        if d % 2 == 0:
            count += 1
    return count

def count_odd(l):
    count = 0
    for d in l:
        if d % 2 != 0:
            count += 1
    return count

def digits10(n, l):
    if n < 0:
        return False
    if n == 0:
        return l == [0]
    digits = []
    temp = n
    while temp > 0:
        digits.append(temp % 10)
        temp //= 10
    digits.reverse()
    return l == digits

def even_odd_count_spec(num, res):
    n = abs(num)
    if n == 0:
        digits = [0]
    else:
        digits = []
        temp = n
        while temp > 0:
            digits.append(temp % 10)
            temp //= 10
        digits.reverse()
    
    return tuple(res) == (count_even(digits), count_odd(digits))

def _impl(num):
    even, odd = 0, 0
    for ch in str(num):
        if ch in "02468": even += 1
        if ch in "13579": odd += 1
    return even, odd

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(even_odd_count_spec(*input, output))

def even_odd_count(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
