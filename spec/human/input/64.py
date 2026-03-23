def is_vowel_char(c: str) -> bool:
    return c in "aeiouAEIOU"

def is_y(c: str) -> bool:
    return c in "yY"

def vowels_count_func(s: str) -> int:
    if s == "":
        return 0
    c = s[0]
    s_prime = s[1:]
    rest = vowels_count_func(s_prime)
    if is_vowel_char(c):
        return 1 + rest
    else:
        if is_y(c) and s_prime == "":
            return 1 + rest
        else:
            return rest

def vowels_count_impl(s: str) -> int:
    return vowels_count_func(s)

def _orig_problem_64_pre(s: str) -> bool:
    return True

def _orig_problem_64_spec(s: str, output: int) -> bool:
    return output == vowels_count_impl(s)

def problem_64_pre(s):
    return bool(_orig_problem_64_pre(s))

def problem_64_spec(s, output):
    return bool(_orig_problem_64_spec(s, output))
