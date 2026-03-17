
def precondition(input):
    (file_name,) = input
    return isinstance(file_name, str)

def postcondition(input, output):
    (file_name,) = input
    if not isinstance(output, str):
        return False
    if output not in ('Yes', 'No'):
        return False
    
    # Verify the output is correct
    dot_count = file_name.count('.')
    digit_count = sum(c.isdigit() for c in file_name)
    
    valid = True
    
    # Exactly one dot
    if dot_count != 1:
        valid = False
    else:
        before_dot, after_dot = file_name.split('.')
        
        # Before dot should not be empty and starts with a latin letter
        if len(before_dot) == 0 or not before_dot[0].isalpha():
            valid = False
        
        # After dot should be one of the valid extensions
        if after_dot not in ('txt', 'exe', 'dll'):
            valid = False
    
    # No more than three digits in the entire file name
    if digit_count > 3:
        valid = False
    
    expected = 'Yes' if valid else 'No'
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
