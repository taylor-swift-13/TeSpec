def is_prime_hex_digit(c):
    return c in ['2', '3', '5', '7', 'B', 'D']

def string_to_list(s):
    return list(s)

def count_prime_hex_digits(chars):
    count = 0
    for c in chars:
        if is_prime_hex_digit(c):
            count += 1
    return count

def _orig_hex_key_spec(num, output):
    return output == count_prime_hex_digits(string_to_list(num))

def hex_key_spec(num, output):
    return bool(_orig_hex_key_spec(num, output))
