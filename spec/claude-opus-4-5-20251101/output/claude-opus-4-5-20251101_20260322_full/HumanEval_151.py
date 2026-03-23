def is_positive_odd_integer(n):
    return (n > 0) and (n % 2 == 1)

def sum_of_squares_of_positive_odd_integers(lst):
    total = 0
    for x in lst:
        if is_positive_odd_integer(x):
            total += x * x
    return total

def double_the_difference_spec(lst, result):
    return result == sum_of_squares_of_positive_odd_integers(lst)

def _impl(lst):
    ans = 0
    for num in lst:
        if num % 2 == 1 and num > 0 and "." not in str(num):
            ans += num ** 2
    return ans

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(double_the_difference_spec(*input, output))

def double_the_difference(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
