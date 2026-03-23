def multiply_spec(a, b, res):
    unit_digit_a = abs(a) % 10
    unit_digit_b = abs(b) % 10
    return res == unit_digit_a * unit_digit_b
