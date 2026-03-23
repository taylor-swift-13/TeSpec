def is_vowel(c: str) -> bool:
    return c in ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']

def filter_string(f, s: str) -> str:
    return "".join(c for c in s if f(c))

def _orig_problem_51_pre(input: str) -> bool:
    return True

def _orig_problem_51_spec(input: str, output: str) -> bool:
    expected = filter_string(lambda c: not is_vowel(c), input)
    return output == expected

def problem_51_pre(text):
    return bool(_orig_problem_51_pre(text))

def problem_51_spec(text, output):
    return bool(_orig_problem_51_spec(text, output))
