
def precondition(inp):
    if not isinstance(inp, tuple) or len(inp) != 1:
        return False
    return isinstance(inp[0], str)

def postcondition(inp, out):
    file_name = inp[0]
    
    digits_count = sum(1 for c in file_name if '0' <= c <= '9')
    parts = file_name.split('.')
    
    is_valid = True
    if digits_count > 3:
        is_valid = False
    elif len(parts) != 2:
        is_valid = False
    elif len(parts[0]) == 0:
        is_valid = False
    elif not ('a' <= parts[0][0] <= 'z' or 'A' <= parts[0][0] <= 'Z'):
        is_valid = False
    elif parts[1] not in ['txt', 'exe', 'dll']:
        is_valid = False
        
    return out == ('Yes' if is_valid else 'No')

def _impl(file_name):
    """Create a function which takes a string representing a file's name, and returns
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
    file_name_check("1example.dll") # => 'No' (the name should start with a latin alphapet letter)"""
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
