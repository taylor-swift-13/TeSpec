def nat_to_binary_string_aux(n, fuel):
    res = ""
    while fuel > 0:
        if n == 0:
            return "0" + res
        if n == 1:
            return "1" + res
        if n % 2 == 0:
            res = "0" + res
            n = n // 2
        else:
            res = "1" + res
            n = (n - 1) // 2
        fuel -= 1
    return res

def nat_to_binary_string(n):
    if n == 0:
        return "0"
    return nat_to_binary_string_aux(n, n)

def decimal_to_binary_impl(decimal):
    return "db" + nat_to_binary_string(decimal) + "db"

def problem_79_pre(decimal):
    return True

def problem_79_spec(decimal, output):
    return output == decimal_to_binary_impl(decimal)

def _impl(decimal):
    return "db" + bin(decimal)[2:] + "db"

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_79_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_79_spec(*input, output))

def decimal_to_binary(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
