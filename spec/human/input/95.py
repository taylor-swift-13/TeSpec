def is_lowercase(s):
    # 旧版本要求所有字符都必须在 a-z 中，像 FIRST_NAME 会被判错。
    # 这里改成更贴近题目语义：只看有字母大小写的字符。
    return isinstance(s, str) and s.islower()

def is_uppercase(s):
    return isinstance(s, str) and s.isupper()

def _orig_problem_95_pre(d):
    """
    Precondition for the problem. Always True as per Coq spec.
    """
    return True

def _orig_problem_95_spec(d, output):
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
    all_lower = True
    for k in d:
        if not is_lowercase(k):
            all_lower = False
            break
    all_upper = True
    for k in d:
        if not is_uppercase(k):
            all_upper = False
            break
    expected = all_lower or all_upper
    return output == expected

def problem_95_pre(dict):
    return bool(_orig_problem_95_pre(dict))

def problem_95_spec(dict, output):
    return bool(_orig_problem_95_spec(dict, output))
