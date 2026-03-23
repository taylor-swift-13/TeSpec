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
