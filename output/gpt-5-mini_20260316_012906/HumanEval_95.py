
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) < 1:
        return False
    return isinstance(input[0], dict)

def postcondition(input, output):
    # If precondition fails, do not attempt strict checking here
    if not precondition(input):
        return True
    d = input[0]
    # Output must be a boolean
    if not isinstance(output, bool):
        return False
    # Empty dict should result in False
    if len(d) == 0:
        return output is False
    # All keys must be strings
    if not all(isinstance(k, str) for k in d.keys()):
        return output is False
    # Check if all keys are lowercase or all are uppercase
    all_lower = all(k == k.lower() for k in d.keys())
    all_upper = all(k == k.upper() for k in d.keys())
    expected = (all_lower or all_upper)
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
