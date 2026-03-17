
def precondition(input_args) -> bool:
    if not isinstance(input_args, tuple) or len(input_args) != 2:
        return False
    lst1, lst2 = input_args
    if not isinstance(lst1, list) or not isinstance(lst2, list):
        return False
    if len(lst1) == 0 or len(lst2) == 0:
        return False
    for x in lst1:
        if not isinstance(x, (int, float)):
            return False
    for x in lst2:
        if not isinstance(x, (int, float)):
            return False
    return True

def postcondition(input_args, output) -> bool:
    if output not in ["YES", "NO"]:
        return False
    lst1, lst2 = input_args
    odd_in_lst1 = [x for x in lst1 if x % 2 != 0]
    even_in_lst2 = [x for x in lst2 if x % 2 == 0]
    
    if len(even_in_lst2) >= len(odd_in_lst1):
        expected = "YES"
    else:
        expected = "NO"
        
    return output == expected

def _impl(lst1, lst2):
    """In this problem, you will implement a function that takes two lists of numbers,
    and determines whether it is possible to perform an exchange of elements
    between them to make lst1 a list of only even numbers.
    There is no limit on the number of exchanged elements between lst1 and lst2.
    If it is possible to exchange elements between the lst1 and lst2 to make
    all the elements of lst1 to be even, return "YES".
    Otherwise, return "NO".
    For example:
    exchange([1, 2, 3, 4], [1, 2, 3, 4]) => "YES"
    exchange([1, 2, 3, 4], [1, 5, 3, 4]) => "NO"
    It is assumed that the input lists will be non-empty."""
    cnt_odd = len(list(filter(lambda x: x % 2 == 1, lst1)))
    cnt_even = len(list(filter(lambda x: x % 2 == 0, lst2)))
    return "YES" if cnt_odd <= cnt_even else "NO"

def exchange(lst1, lst2):
    _input = (lst1, lst2)
    assert precondition(_input)
    _output = _impl(lst1, lst2)
    assert postcondition(_input, _output)
    return _output
