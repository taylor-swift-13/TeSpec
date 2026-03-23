def count_digit_7_aux(k, fuel):
    res = 0
    for _ in range(fuel):
        if k == 0:
            break
        if k % 10 == 7:
            res += 1
        k //= 10
    return res

def count_digit_7(k):
    return count_digit_7_aux(k, k)

def fizz_buzz_impl(n):
    acc = 0
    for i in range(n):
        if i % 11 == 0 or i % 13 == 0:
            acc += count_digit_7(i)
    return acc

def problem_36_pre(n):
    return True

def problem_36_spec(n, output):
    return output == fizz_buzz_impl(n)

def _impl(n: int):
    cnt = 0
    for i in range(n):
        if i % 11 == 0 or i % 13 == 0:
            cnt += len(list(filter(lambda c: c == "7", str(i))))
    return cnt

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_36_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_36_spec(*input, output))

def fizz_buzz(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
