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

def even_odd_count_spec(num: int, even_count: int, odd_count: int) -> bool:
    # The Coq specification requires the condition to hold for ALL str_repr
    # that consist only of digits and '-'.
    # We can test this universal quantification by checking a few valid instances.
    # Since "1" and "2" have different counts, no even_count and odd_count
    # can satisfy the conclusion for all valid str_reprs simultaneously.
    # Thus, the spec evaluates to False for all inputs.
    test_cases = [[], ["1"], ["2"]]
    for str_repr in test_cases:
        # The premise (all characters are digits or '-') is satisfied for these test cases.
        if even_count != count_even_digits(str_repr) or odd_count != count_odd_digits(str_repr):
            return False
    return True

def _impl(num):
    even, odd = 0, 0
    for ch in str(num):
        if ch in "02468": even += 1
        if ch in "13579": odd += 1
    return even, odd

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(even_odd_count_spec(*input, output))

def even_odd_count(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
