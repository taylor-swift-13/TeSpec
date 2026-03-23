def is_lowercase(s):
    """
    Checks if a string consists only of lowercase characters 'a' through 'z'.
    Corresponds to Coq definition:
    Definition is_lowercase (s : string) : Prop :=
      Forall (fun c => (("a" <=? c)%char && (c <=? "z")%char) = true) (list_ascii_of_string s).
    """
    for c in s:
        if not ('a' <= c <= 'z'):
            return False
    return True

def is_uppercase(s):
    """
    Checks if a string consists only of uppercase characters 'A' through 'Z'.
    Corresponds to Coq definition:
    Definition is_uppercase (s : string) : Prop :=
      Forall (fun c => (("A" <=? c)%char && (c <=? "Z")%char) = true) (list_ascii_of_string s).
    """
    for c in s:
        if not ('A' <= c <= 'Z'):
            return False
    return True

def problem_95_pre(d):
    """
    Precondition for the problem. Always True as per Coq spec.
    """
    return True

def problem_95_spec(d, output):
    """
    Specification for check_dict_case.
    d: dictionary (represented as a Python dict)
    output: bool
    
    Logic:
    - If d is empty, output must be False.
    - Otherwise, output is True iff (all keys are lowercase strings OR all keys are uppercase strings).
    - Non-string keys cause the condition to fail (treated as KeyOther).
    """
    if not d:
        return output is False

    # Check if all keys are strings and satisfy is_lowercase
    all_lower = True
    for k in d:
        if not isinstance(k, str) or not is_lowercase(k):
            all_lower = False
            break

    # Check if all keys are strings and satisfy is_uppercase
    all_upper = True
    for k in d:
        if not isinstance(k, str) or not is_uppercase(k):
            all_upper = False
            break

    expected = all_lower or all_upper
    return output == expected

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
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_95_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_95_spec(*input, output))

def check_dict_case(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
