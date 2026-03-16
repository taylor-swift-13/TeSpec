
def precondition(input):
    file_name = input[0]
    return isinstance(file_name, str)

def postcondition(input, output):
    file_name = input[0]
    if not isinstance(file_name, str):
        return False
    if output not in ('Yes', 'No'):
        return False
    
    # Check if output is consistent with rules
    # Count digits
    digit_count = sum(1 for c in file_name if c.isdigit())
    
    # Check dot count
    dot_count = file_name.count('.')
    
    # Check extension
    valid_extensions = {'txt', 'exe', 'dll'}
    if dot_count == 1:
        parts = file_name.split('.')
        if len(parts) == 2:
            name_part, ext_part = parts
            extension_valid = ext_part in valid_extensions
            name_non_empty = len(name_part) > 0
            starts_with_letter = name_part and name_part[0].isalpha()
        else:
            extension_valid = False
            name_non_empty = False
            starts_with_letter = False
    else:
        extension_valid = False
        name_non_empty = False
        starts_with_letter = False
    
    # All conditions for "Yes"
    should_be_yes = (digit_count <= 3 and 
                     dot_count == 1 and 
                     name_non_empty and 
                     starts_with_letter and 
                     extension_valid)
    
    # Output should be 'Yes' if all conditions met, 'No' otherwise
    return (should_be_yes and output == 'Yes') or (not should_be_yes and output == 'No')

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
