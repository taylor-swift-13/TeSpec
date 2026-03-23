def last_digit(n: int) -> int:
    return abs(n % 10)

def msd_fuel(fuel: int, n: int) -> int:
    while fuel > 0:
        if n < 10:
            return n
        n //= 10
        fuel -= 1
    return n % 10

def special_number_b(n: int) -> bool:
    abs_n = abs(n)
    return (10 < n) and (msd_fuel(abs_n, abs_n) % 2 != 0) and (last_digit(abs_n) % 2 != 0)

def specialFilter_impl(nums: list) -> int:
    return sum(1 for n in nums if special_number_b(n))

def problem_146_pre(nums: list) -> bool:
    return True

def problem_146_spec(nums: list, output: int) -> bool:
    return output == specialFilter_impl(nums)

def _impl(nums):
    ans, odd = 0, ["1", "3", "5", "7", "9"]
    for num in nums:
        if num > 10 and str(num)[0] in odd and str(num)[-1] in odd:
            ans += 1
    return ans

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_146_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_146_spec(*input, output))

def specialFilter(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
