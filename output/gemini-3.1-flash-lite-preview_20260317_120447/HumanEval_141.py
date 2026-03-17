
def precondition(input):
    file_name = input[0]
    return isinstance(file_name, str)

def postcondition(input, output):
    file_name = input[0]
    
    if '.' not in file_name or file_name.count('.') != 1:
        expected = 'No'
    else:
        name, ext = file_name.split('.')
        digit_count = sum(c.isdigit() for c in file_name)
        
        valid_conditions = (
            digit_count <= 3 and
            len(name) > 0 and
            name[0].isalpha() and
            ext in ['txt', 'exe', 'dll']
        )
        expected = 'Yes' if valid_conditions else 'No'
        
    return output == expected

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
