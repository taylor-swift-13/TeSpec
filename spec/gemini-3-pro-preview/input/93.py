def string_to_list(s: str) -> list:
    return list(s)

def list_to_string(l: list) -> str:
    return "".join(l)

def is_upper(c: str) -> bool:
    n = ord(c)
    return 65 <= n <= 90

def is_lower(c: str) -> bool:
    n = ord(c)
    return 97 <= n <= 122

def switch_case_char(c: str) -> str:
    n = ord(c)
    if is_upper(c):
        return chr(n + 32)
    elif is_lower(c):
        return chr(n - 32)
    else:
        return c

def is_vowel(c: str) -> bool:
    n = ord(c)
    return n in {65, 69, 73, 79, 85, 97, 101, 105, 111, 117}

def vowel_change_char(c: str) -> str:
    if is_vowel(c):
        return chr(ord(c) + 2)
    else:
        return c

def encode_process(l: list) -> list:
    return [vowel_change_char(switch_case_char(c)) for c in l]

def encode_spec(message: str, result: str) -> bool:
    return result == list_to_string(encode_process(string_to_list(message)))
