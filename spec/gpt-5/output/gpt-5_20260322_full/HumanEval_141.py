def is_digitb(c: str) -> bool:
    if len(c) != 1:
        return False
    n = ord(c)
    return 48 <= n <= 57

def is_upperb(c: str) -> bool:
    if len(c) != 1:
        return False
    n = ord(c)
    return 65 <= n <= 90

def is_lowerb(c: str) -> bool:
    if len(c) != 1:
        return False
    n = ord(c)
    return 97 <= n <= 122

def is_alphab(c: str) -> bool:
    return is_upperb(c) or is_lowerb(c)

def count_digits(s: str) -> int:
    return sum(1 for c in s if is_digitb(c))

def count_char(s: str, ch: str) -> int:
    if len(ch) != 1:
        return 0
    return s.count(ch)

def starts_with_alpha(s: str) -> bool:
    if not s:
        return False
    return is_alphab(s[0])

def suffix_in_allowed(suf: str) -> bool:
    return suf in ["txt", "exe", "dll"]

def valid_file_name(s: str) -> bool:
    if count_digits(s) > 3:
        return False
    if count_char(s, '.') != 1:
        return False
    
    parts = s.split('.')
    if len(parts) != 2:
        return False
    
    pref, suf = parts[0], parts[1]
    
    if not pref:
        return False
    if not starts_with_alpha(pref):
        return False
    if not suffix_in_allowed(suf):
        return False
        
    return True

def file_name_check_spec(file_name: str, result: str) -> bool:
    is_valid = valid_file_name(file_name)
    return (is_valid and result == "Yes") or (not is_valid and result == "No")

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
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(file_name_check_spec(*input, output))

def file_name_check(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
