
def precondition(input_args):
    if not isinstance(input_args, tuple) or len(input_args) != 1:
        return False
    lst = input_args[0]
    if not isinstance(lst, list):
        return False
    for s in lst:
        if not isinstance(s, str):
            return False
        if not all('0' <= c <= '9' for c in s):
            return False
    return True

def postcondition(input_args, output):
    lst = input_args[0]
    if not isinstance(output, list):
        return False
    if len(output) != len(lst):
        return False
    for i in range(len(lst)):
        n = sum(1 for char in lst[i] if char in '13579')
        n_str = str(n)
        expected = "the number of odd elements " + n_str + "n the str" + n_str + "ng " + n_str + " of the " + n_str + "nput."
        if output[i] != expected:
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
