def is_digit_bool(c: str) -> bool:
    return '0' <= c <= '9'

def is_alpha(c: str) -> bool:
    return ('a' <= c <= 'z') or ('A' <= c <= 'Z')

def problem_141_pre(file_name: str) -> bool:
    return True

def problem_141_spec(file_name_str: str, result: str) -> bool:
    digit_count = sum(1 for c in file_name_str if is_digit_bool(c))
    
    is_valid = False
    if digit_count <= 3:
        if file_name_str.count('.') == 1:
            prefix, suffix = file_name_str.split('.')
            if len(prefix) > 0 and is_alpha(prefix[0]):
                if suffix in ["txt", "exe", "dll"]:
                    is_valid = True
                    
    if is_valid:
        return result == "Yes"
    else:
        return result == "No"

def _impl(file_name):
    if len(list(filter(lambda ch: ch.isdigit(), file_name))) > 3:
        return "No"
    f_list = file_name.split(".")
    if len(f_list) != 2: return "No"
    if len(f_list[0]) == 0: return "No"
    if not f_list[0][0].isalpha(): return "No"
    if f_list[1] not in ["txt", "exe", "dll"]: return "No"
    return "Yes"

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_141_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_141_spec(*input, output))

def file_name_check(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
