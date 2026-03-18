
def precondition(input):
    # input is a tuple of positional arguments
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    lst = input[0]
    if not isinstance(lst, list):
        return False
    for s in lst:
        if not isinstance(s, str):
            return False
        if not s.isdigit():
            return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    lst = input[0]
    if not isinstance(lst, list):
        return False
    if not isinstance(output, list):
        return False
    if len(output) != len(lst):
        return False
    for s, o in zip(lst, output):
        if not isinstance(o, int) or o < 0:
            return False
        count = sum(1 for ch in s if ch in '13579')
        if o != count:
            return False
    return True

def _impl(lst):
    """
    Given a list of strings, where each string consists of only digits, return a list.
    Each element i of the output should be "the number of odd elements in the
    string i of the input." where all the i's should be replaced by the number
    of odd digits in the i'th string of the input.

    ["the number of odd elements 4n the str4ng 4 of the 4nput."]
    ["the number of odd elements 1n the str1ng 1 of the 1nput.",
     "the number of odd elements 8n the str8ng 8 of the 8nput."]
    """
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
