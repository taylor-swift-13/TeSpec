
def precondition(args):
    file_name = args[0]
    # Check that file_name is a string
    if not isinstance(file_name, str):
        return False
    return True

def postcondition(args, output):
    file_name = args[0]
    # Check that output is either 'Yes' or 'No'
    if output not in ('Yes', 'No'):
        return False
    
    # Verify the output matches the expected validation logic
    # Count digits
    digit_count = sum(1 for c in file_name if c.isdigit())
    
    # Count dots
    dot_count = file_name.count('.')
    
    # Check if exactly one dot
    if dot_count != 1:
        expected = 'No'
    else:
        before_dot, after_dot = file_name.split('.')
        
        # Check if before_dot is not empty and starts with a latin letter
        if not before_dot or not (before_dot[0].isalpha() and before_dot[0].isascii()):
            expected = 'No'
        # Check if after_dot is one of the valid extensions
        elif after_dot not in ['txt', 'exe', 'dll']:
            expected = 'No'
        # Check if there are more than 3 digits
        elif digit_count > 3:
            expected = 'No'
        else:
            expected = 'Yes'
    
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
