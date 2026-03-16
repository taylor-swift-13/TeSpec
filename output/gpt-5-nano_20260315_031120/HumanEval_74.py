
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    lst1, lst2 = input
    if not isinstance(lst1, list) or not isinstance(lst2, list):
        return False
    if not all(isinstance(x, str) for x in lst1):
        return False
    if not all(isinstance(x, str) for x in lst2):
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    lst1, lst2 = input
    total1 = sum(len(s) for s in lst1)
    total2 = sum(len(s) for s in lst2)
    # If total1 <= total2, the first list should be returned; else the second
    if total1 <= total2:
        expected = lst1
    else:
        expected = lst2

    if output is lst1 and total1 <= total2:
        return True
    if output is lst2 and total1 > total2:
        return True
    return False

def _impl(lst1, lst2):
    """Write a function that accepts two lists of strings and returns the list that has 
    total number of chars in the all strings of the list less than the other list.

    if the two lists have the same number of chars, return the first list.

    Examples
    total_match([], []) ➞ []
    total_match(['hi', 'admin'], ['hI', 'Hi']) ➞ ['hI', 'Hi']
    total_match(['hi', 'admin'], ['hi', 'hi', 'admin', 'project']) ➞ ['hi', 'admin']
    total_match(['hi', 'admin'], ['hI', 'hi', 'hi']) ➞ ['hI', 'hi', 'hi']
    total_match(['4'], ['1', '2', '3', '4', '5']) ➞ ['4']"""
    c1, c2 = sum(map(lambda s: len(s), lst1)), sum(map(lambda s: len(s), lst2))
    return lst1 if c1 <= c2 else lst2

def total_match(lst1, lst2):
    _input = (lst1, lst2)
    assert precondition(_input)
    _output = _impl(lst1, lst2)
    assert postcondition(_input, _output)
    return _output
