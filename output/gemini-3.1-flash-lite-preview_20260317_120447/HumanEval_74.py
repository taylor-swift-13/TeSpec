
def precondition(input):
    lst1, lst2 = input
    return isinstance(lst1, list) and isinstance(lst2, list) and \
           all(isinstance(s, str) for s in lst1) and \
           all(isinstance(s, str) for s in lst2)

def postcondition(input, output):
    lst1, lst2 = input
    sum1 = sum(len(s) for s in lst1)
    sum2 = sum(len(s) for s in lst2)
    
    if sum1 <= sum2:
        return output == lst1
    else:
        return output == lst2

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
