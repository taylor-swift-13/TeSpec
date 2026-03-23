def is_digit_bool(c: str) -> bool:
    return '0' <= c <= '9'

def is_alpha(c: str) -> bool:
    return ('a' <= c <= 'z') or ('A' <= c <= 'Z')

def _orig_problem_141_pre(file_name: str) -> bool:
    return True

def _orig_problem_141_spec(file_name_str: str, output: str) -> bool:
    digit_count = sum((1 for c in file_name_str if is_digit_bool(c)))
    is_valid = False
    if digit_count <= 3:
        if file_name_str.count('.') == 1:
            (prefix, suffix) = file_name_str.split('.')
            if len(prefix) > 0 and is_alpha(prefix[0]):
                if suffix in ['txt', 'exe', 'dll']:
                    is_valid = True
    if is_valid:
        return output == 'Yes'
    else:
        return output == 'No'

def problem_141_pre(file_name):
    return bool(_orig_problem_141_pre(file_name))

def problem_141_spec(file_name, output):
    return bool(_orig_problem_141_spec(file_name, output))
