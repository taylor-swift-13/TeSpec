def is_odd_digit(c: str) -> bool:
    return c in ["1", "3", "5", "7", "9"]

def count_odd_digits(s: str) -> int:
    return sum(1 for c in s if is_odd_digit(c))

def nat_to_string(n: int) -> str:
    return str(n)

def replace_char_with_string(target: str, replacement: str, s: str) -> str:
    return s.replace(target, replacement)

def process_string(s: str) -> str:
    cnt = count_odd_digits(s)
    cnt_str = nat_to_string(cnt)
    templ = "the number of odd elements in the string i of the input."
    return replace_char_with_string("i", cnt_str, templ)

def odd_count_impl(input: list) -> list:
    return [process_string(s) for s in input]

def problem_113_pre(input: list) -> bool:
    for s in input:
        for ch in s:
            if not ('0' <= ch <= '9'):
                return False
    return True

def problem_113_spec(input: list, output: list) -> bool:
    return output == odd_count_impl(input)
