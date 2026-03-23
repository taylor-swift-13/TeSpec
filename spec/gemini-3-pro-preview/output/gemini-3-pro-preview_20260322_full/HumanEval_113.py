def is_odd_digit(c: str) -> bool:
    return c in ["1", "3", "5", "7", "9"]

def count_odd_digits(s: str) -> int:
    return sum(1 for c in s if is_odd_digit(c))

def string_of_nat(n: int) -> str:
    return str(n)

template = "the number of odd elements in the string i of the input."

def replace_i(s: str, replacement: str) -> str:
    return s.replace("i", replacement)

def odd_count_spec(lst: list, ans: list) -> bool:
    expected = [replace_i(template, string_of_nat(count_odd_digits(s))) for s in lst]
    return ans == expected

def _impl(lst):
    ans, template = [], "the number of odd elements in the string i of the input."
    for s in lst:
        odd_cnt = len(list(filter(lambda ch: int(ch) % 2 == 1, s)))
        ans.append(template.replace("i", str(odd_cnt)))
    return ans

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(odd_count_spec(*input, output))

def odd_count(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
