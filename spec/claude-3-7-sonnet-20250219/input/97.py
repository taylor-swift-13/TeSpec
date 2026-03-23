def _orig_multiply_spec(a, b, output):
    unit_digit_a = abs(a) % 10
    unit_digit_b = abs(b) % 10
    return output == unit_digit_a * unit_digit_b

def multiply_spec(a, b, output):
    return bool(_orig_multiply_spec(a, b, output))
