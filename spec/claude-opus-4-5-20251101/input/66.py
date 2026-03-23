def is_upper(c: str) -> bool:
    n = ord(c)
    return 65 <= n <= 90

def ascii_to_Z(c: str) -> int:
    return ord(c)

def string_to_list(s: str) -> list:
    return list(s)

def sum_upper_ascii(chars: list) -> int:
    acc = 0
    for c in reversed(chars):
        if is_upper(c):
            acc = ascii_to_Z(c) + acc
    return acc

def digitSum_spec(s: str, result: int) -> bool:
    return result == sum_upper_ascii(string_to_list(s))
