def is_prime_hex_digit(c):
    return c in ('2', '3', '5', '7', 'B', 'D')

def count_prime_hex(s):
    return sum(1 for c in s if is_prime_hex_digit(c))

def hex_key_impl(s):
    return count_prime_hex(s)

def problem_78_pre(s):
    return True

def problem_78_spec(s, output):
    return output == hex_key_impl(s)
