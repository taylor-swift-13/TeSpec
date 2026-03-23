def check_dict_case_spec(d, res):
    try:
        ks = list(d.keys())
    except AttributeError:
        ks = list(d)
    if not ks:
        expected = False
    else:
        all_lower = all(str(k).isalpha() and str(k).islower() for k in ks)
        all_upper = all(str(k).isalpha() and str(k).isupper() for k in ks)
        expected = all_lower or all_upper
    return expected == res

def _impl(dict):
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

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(check_dict_case_spec(*input, output))

def check_dict_case(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
