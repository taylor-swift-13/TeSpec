def is_uppercase(c: str) -> bool:
    """
    Checks if a character is an uppercase ASCII character (ASCII 65-90).
    """
    if not c:
        return False
    n = ord(c)
    # Nat.leb 65 n && Nat.leb n 90
    return 65 <= n <= 90

def sum_uppercase_ascii(s: str) -> int:
    """
    Iterates through the string and sums the ASCII values of uppercase characters.
    """
    total = 0
    for c in s:
        if is_uppercase(c):
            total += ord(c)
    return total

def digitSum_impl(s: str) -> int:
    """
    Main implementation of the digitSum task.
    """
    return sum_uppercase_ascii(s)

def problem_66_pre(s: str) -> bool:
    """
    Precondition for problem 66.
    """
    return True

def problem_66_spec(s: str, output: int) -> bool:
    """
    Specification for problem 66: the output must match the result of digitSum_impl.
    """
    return output == digitSum_impl(s)

# Examples and verification based on the prompt:
# digitSum_impl("") => 0
# digitSum_impl("abAB") => 131
# digitSum_impl("abcCd") => 67
# digitSum_impl("helloE") => 69
# digitSum_impl("woArBld") => 131
# digitSum_impl("aAaaaXa") => 153

def _impl(s):
    return sum([ord(ch) for ch in s if ch.isupper()])

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_66_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_66_spec(*input, output))

def digitSum(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
