
def precondition(args):
    lst = args[0]
    # lst must be a list
    if not isinstance(lst, list):
        return False
    # each element must be a string consisting only of digits
    for s in lst:
        if not isinstance(s, str):
            return False
        if not all(c.isdigit() for c in s):
            return False
    return True


def postcondition(args, output):
    lst = args[0]
    # output must be a list
    if not isinstance(output, list):
        return False
    # output must have same length as input
    if len(output) != len(lst):
        return False
    # each output element must be a string
    for i, s in enumerate(lst):
        if not isinstance(output[i], str):
            return False
        # count odd digits in the input string
        odd_count = sum(1 for c in s if c in '13579')
        # the expected output string
        expected = "the number of odd elements {}n the str{}ng {} of the {}nput.".format(
            odd_count, odd_count, odd_count, odd_count
        )
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
