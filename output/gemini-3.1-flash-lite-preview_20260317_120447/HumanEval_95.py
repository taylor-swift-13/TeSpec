
def precondition(input):
    return isinstance(input[0], dict)

def postcondition(input, output):
    d = input[0]
    if not d:
        return output is False
    
    keys = list(d.keys())
    if not all(isinstance(k, str) for k in keys):
        return output is False
    
    is_lower = all(k.islower() for k in keys)
    is_upper = all(k.isupper() for k in keys)
    
    return output == (is_lower or is_upper)

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
