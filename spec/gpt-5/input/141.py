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

def _orig_file_name_check_spec(file_name: str, output: str) -> bool:
    is_valid = valid_file_name(file_name)
    return is_valid and output == 'Yes' or (not is_valid and output == 'No')

def file_name_check_spec(file_name, output):
    return bool(_orig_file_name_check_spec(file_name, output))
