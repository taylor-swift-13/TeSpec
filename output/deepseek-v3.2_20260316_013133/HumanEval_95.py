
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    d = input[0]
    return isinstance(d, dict)

def postcondition(input, output):
    if not isinstance(output, bool):
        return False
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    d = input[0]
    if not isinstance(d, dict):
        return False
    
    # Check if output matches the described behavior
    if not d:
        return output == False
    
    # Check if all keys are strings
    all_keys_strings = all(isinstance(k, str) for k in d.keys())
    if not all_keys_strings:
        return output == False
    
    # Check if all keys are lower case or all keys are upper case
    all_lower = all(k.islower() for k in d.keys())
    all_upper = all(k.isupper() for k in d.keys())
    
    expected = all_lower or all_upper
    return output == expected

def _impl(dict):
    """Given a dictionary, return True if all keys are strings in lower 
    case or all keys are strings in upper case, else return False.
    The function should return False is the given dictionary is empty.
    Examples:
    check_dict_case({"a":"apple", "b":"banana"}) should return True.
    check_dict_case({"a":"apple", "A":"banana", "B":"banana"}) should return False.
    check_dict_case({"a":"apple", 8:"banana", "a":"apple"}) should return False.
    check_dict_case({"Name":"John", "Age":"36", "City":"Houston"}) should return False.
    check_dict_case({"STATE":"NC", "ZIP":"12345" }) should return True."""
    keys = list(dict.keys())
    if keys == []: return False
    lower, upper = True, True
    for k in keys:
        if type(k) != str:
            lower = upper = False
            break
        if not k.islower(): lower = False
        if not k.isupper(): upper = False
    return lower or upper

def check_dict_case(dict):
    _input = (dict,)
    assert precondition(_input)
    _output = _impl(dict)
    assert postcondition(_input, _output)
    return _output
