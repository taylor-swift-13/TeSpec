
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    return isinstance(input[0], str)

def postcondition(input, output):
    if not precondition(input):
        return True
    s = input[0]
    # Validate output type
    if not isinstance(output, str):
        return False
    # Compute expected result
    def is_valid_filename(name):
        # Exactly one dot
        if name.count('.') != 1:
            return False
        idx = name.find('.')
        before = name[:idx]
        after = name[idx+1:]
        # Before not empty and starts with latin letter
        if before == "":
            return False
        first = before[0]
        if not (('a' <= first <= 'z') or ('A' <= first <= 'Z')):
            return False
        # After must be valid extension
        if after not in {'txt', 'exe', 'dll'}:
            return False
        # No more than three ASCII digits in the entire name
        digits = sum(1 for c in name if c in '0123456789')
        if digits > 3:
            return False
        return True

    expected = 'Yes' if is_valid_filename(s) else 'No'
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
