def is_even_digit(c: str) -> bool:
    if c in ["0", "2", "4", "6", "8"]:
        return True
    return False

def is_odd_digit(c: str) -> bool:
    if c in ["1", "3", "5", "7", "9"]:
        return True
    return False

def count_even_digits(s: list) -> int:
    if not s:
        return 0
    c = s[0]
    rest = s[1:]
    return (1 if is_even_digit(c) else 0) + count_even_digits(rest)

def count_odd_digits(s: list) -> int:
    if not s:
        return 0
    c = s[0]
    rest = s[1:]
    return (1 if is_odd_digit(c) else 0) + count_odd_digits(rest)

def _orig_even_odd_count_spec(num: int, even_count: int, odd_count: int) -> bool:
    return False

def even_odd_count_spec(num, output):
    return bool(_orig_even_odd_count_spec(num, output[0], output[1]))
