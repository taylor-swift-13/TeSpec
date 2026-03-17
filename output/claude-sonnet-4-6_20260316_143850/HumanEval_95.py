
def precondition(args):
    if len(args) != 1:
        return False
    d = args[0]
    if not isinstance(d, dict):
        return False
    return True

def postcondition(args, output):
    if not isinstance(output, bool):
        return False
    d = args[0]
    if not isinstance(d, dict):
        return False
    if len(d) == 0:
        return output == False
    all_string_keys = all(isinstance(k, str) for k in d.keys())
    if not all_string_keys:
        return output == False
    all_lower = all(k == k.lower() for k in d.keys())
    all_upper = all(k == k.upper() for k in d.keys())
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
