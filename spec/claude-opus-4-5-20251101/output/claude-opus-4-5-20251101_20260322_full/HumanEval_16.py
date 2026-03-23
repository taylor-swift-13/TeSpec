def to_lower(c):
    n = ord(c)
    if 65 <= n <= 90:
        return chr(n + 32)
    return c

def string_to_list(s):
    return list(s)

def list_to_lower(l):
    return [to_lower(c) for c in l]

def mem_ascii(c, l):
    return c in l

def distinct(l):
    if not l:
        return []
    c = l[0]
    rest = l[1:]
    if mem_ascii(c, rest):
        return distinct(rest)
    else:
        return [c] + distinct(rest)

def count_distinct_characters_spec(s, count):
    return count == len(distinct(list_to_lower(string_to_list(s))))

def _impl(string: str) -> int:
    return len(set(string.lower()))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(count_distinct_characters_spec(*input, output))

def count_distinct_characters(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
