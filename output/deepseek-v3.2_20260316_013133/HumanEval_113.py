
def precondition(args):
    lst, = args
    if not isinstance(lst, list):
        return False
    for s in lst:
        if not isinstance(s, str):
            return False
        if not s.isdigit():
            return False
    return True

def postcondition(args, result):
    lst, = args
    if not isinstance(result, list):
        return False
    if len(result) != len(lst):
        return False
    for i, s in enumerate(lst):
        if not isinstance(result[i], str):
            return False
        expected_count = sum(1 for ch in s if int(ch) % 2 == 1)
        expected_str = f"the number of odd elements {expected_count}n the str{expected_count}ng {expected_count} of the {expected_count}nput."
        if result[i] != expected_str:
            return False
    return True

def _impl(lst):
    """Given a list of strings, where each string consists of only digits, return a list.
    Each element i of the output should be "the number of odd elements in the
    string i of the input." where all the i's should be replaced by the number
    of odd digits in the i'th string of the input.

    ["the number of odd elements 4n the str4ng 4 of the 4nput."]
    ["the number of odd elements 1n the str1ng 1 of the 1nput.",
     "the number of odd elements 8n the str8ng 8 of the 8nput."]"""
    ans, template = [], "the number of odd elements in the string i of the input."
    for s in lst:
        odd_cnt = len(list(filter(lambda ch: int(ch) % 2 == 1, s)))
        ans.append(template.replace("i", str(odd_cnt)))
    return ans

def odd_count(lst):
    _input = (lst,)
    assert precondition(_input)
    _output = _impl(lst)
    assert postcondition(_input, _output)
    return _output
