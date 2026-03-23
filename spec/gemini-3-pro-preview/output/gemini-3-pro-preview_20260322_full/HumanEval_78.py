def is_prime_hex(c: str) -> bool:
    if c == "2":
        return True
    elif c == "3":
        return True
    elif c == "5":
        return True
    elif c == "7":
        return True
    elif c == "B":
        return True
    elif c == "D":
        return True
    else:
        return False

def count_primes(s: str) -> int:
    count = 0
    for c in s:
        if is_prime_hex(c):
            count += 1
    return count

def hex_key_spec(num: str, count: int) -> bool:
    return count == count_primes(num)

def _impl(num):
    return len(list(filter(lambda x: x in "2357BD", num)))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(hex_key_spec(*input, output))

def hex_key(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
