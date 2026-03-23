def contains(l, c):
    """
    Checks if the sequence l contains the character c.
    """
    return c in l

def split(sep, s):
    """
    Splits the string s by the separator sep.
    Mimics the Coq implementation which ignores empty strings resulting from 
    consecutive separators or separators at the boundaries.
    """
    return [x for x in s.split(sep) if x]

def count_odd_lowercase(l):
    """
    Counts the number of lowercase letters with an odd order in the alphabet.
    'a' = 0, 'b' = 1, ..., 'z' = 25.
    Only counts characters where the mapped value is odd.
    Non-lowercase characters map to 0 (even), so they are not counted.
    """
    def lowercase_ord(c):
        if 'a' <= c <= 'z':
            return ord(c) - ord('a')
        return 0

    def is_odd(n):
        return n % 2 != 0

    def is_target_char(c):
        return is_odd(lowercase_ord(c))

    return len([c for c in l if is_target_char(c)])

def problem_125_pre(input):
    """
    Precondition for problem 125. Always True.
    """
    return True

def problem_125_spec(input, output):
    """
    Specification for problem 125.
    Determines if 'output' is the correct result for 'input' according to the rules:
    1. If input contains spaces, split by space.
    2. Else if input contains commas, split by comma.
    3. Else count odd lowercase letters.
    """
    l = input
    if contains(l, ' '):
        res = split(' ', l)
        return output == res
    elif contains(l, ','):
        res = split(',', l)
        return output == res
    else:
        res = count_odd_lowercase(l)
        return output == res

def _impl(txt):
    whitespace = tuple(' \n\r\t')
    if any([x in txt for x in whitespace]): return txt.split()
    if "," in txt: return txt.split(",")
    cnt = 0
    for ch in txt:
        if ch.islower() and (ord(ch) - ord("a")) % 2 == 1: cnt += 1
    return cnt

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_125_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_125_spec(*input, output))

def split_words(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
