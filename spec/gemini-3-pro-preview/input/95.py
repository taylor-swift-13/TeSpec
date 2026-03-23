def is_str(k):
    """
    Predicate corresponding to Python's type checking for strings.
    """
    return isinstance(k, str)

def is_lower(k):
    """
    Predicate corresponding to Python's string islower method.
    In Python, islower() returns True if there is at least one cased character 
    and all cased characters are lowercase.
    """
    if isinstance(k, str):
        return k.islower()
    return False

def is_upper(k):
    """
    Predicate corresponding to Python's string isupper method.
    In Python, isupper() returns True if there is at least one cased character 
    and all cased characters are uppercase.
    """
    if isinstance(k, str):
        return k.isupper()
    return False

def _orig_check_dict_case_spec(dictionary, output):
    """
    Implementation of check_dict_case_spec.
    
    The specification states:
    - If the dictionary is empty, output must be False.
    - If the dictionary is not empty, output is True if and only if:
        - All keys are strings and are lowercase, OR
        - All keys are strings and are uppercase.
    """
    keys = [item[0] for item in dictionary]
    if not keys:
        return output is False
    else:
        all_lower = all((is_str(k) and is_lower(k) for k in keys))
        all_upper = all((is_str(k) and is_upper(k) for k in keys))
        expected_res = all_lower or all_upper
        return output == expected_res

def check_dict_case_spec(dict, output):
    return bool(_orig_check_dict_case_spec(dict, output))
