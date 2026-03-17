
def precondition(input_args: tuple) -> bool:
    return len(input_args) == 1 and isinstance(input_args[0], str)

def postcondition(input_args: tuple, output: str) -> bool:
    if output not in ('Yes', 'No'):
        return False
    
    file_name = input_args[0]
    
    # Condition 1: Not more than three digits
    digit_count = sum(1 for char in file_name if char.isdigit())
    if digit_count > 3:
        is_valid = False
    # Condition 2: Exactly one dot
    elif file_name.count('.') != 1:
        is_valid = False
    else:
        parts = file_name.split('.')
        before = parts[0]
        after = parts[1]
        
        # Condition 3: Substring before dot not empty and starts with latin letter
        if not before:
            is_valid = False
        elif not (('a' <= before[0] <= 'z') or ('A' <= before[0] <= 'Z')):
            is_valid = False
        # Condition 4: Substring after dot is one of ['txt', 'exe', 'dll']
        elif after not in ['txt', 'exe', 'dll']:
            is_valid = False
        else:
            is_valid = True
            
    expected = 'Yes' if is_valid else 'No'
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
