
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    file_name = input[0]
    if not isinstance(file_name, str):
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    if not isinstance(output, str):
        return False
    file_name = input[0]
    if not isinstance(file_name, str):
        return False
    if output not in ('Yes', 'No'):
        return False

    s = file_name
    # Exactly one dot
    if s.count('.') != 1:
        expected = 'No'
        return output == expected

    dot = s.find('.')
    before = s[:dot]
    after = s[dot+1:]

    ok = True
    # Substring before dot should not be empty and must start with a latin letter
    if before == '':
        ok = False
    else:
        first = before[0]
        if not (('a' <= first <= 'z') or ('A' <= first <= 'Z')):
            ok = False

    # Substring after dot must be one of allowed extensions
    allowed_after = {'txt', 'exe', 'dll'}
    if after not in allowed_after:
        ok = False

    # Not more than three digits in the file name
    digits = sum(ch.isdigit() for ch in s)
    if digits > 3:
        ok = False

    expected = 'Yes' if ok else 'No'
    return output == expected

def _impl(file_name):
    """
    Create a function which takes a string representing a file's name, and returns
    'Yes' if the the file's name is valid, and returns 'No' otherwise.
    A file's name is considered to be valid if and only if all the following conditions 
    are met:
    - There should not be more than three digits ('0'-'9') in the file's name.
    - The file's name contains exactly one dot '.'
    - The substring before the dot should not be empty, and it starts with a letter from 
    the latin alphapet ('a'-'z' and 'A'-'Z').
    - The substring after the dot should be one of these: ['txt', 'exe', 'dll']
    Examples:
    file_name_check("example.txt") # => 'Yes'
    file_name_check("1example.dll") # => 'No' (the name should start with a latin alphapet letter)
    """
    if len(list(filter(lambda ch: ch.isdigit(), file_name))) > 3:
        return "No"
    f_list = file_name.split(".")
    if len(f_list) != 2: return "No"
    if len(f_list[0]) == 0: return "No"
    if not f_list[0][0].isalpha(): return "No"
    if f_list[1] not in ["txt", "exe", "dll"]: return "No"
    return "Yes"

def file_name_check(file_name):
    _input = (file_name,)
    assert precondition(_input)
    _output = _impl(file_name)
    assert postcondition(_input, _output)
    return _output
