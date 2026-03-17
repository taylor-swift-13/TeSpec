
def precondition(input):
    try:
        lst1, lst2 = input
        # Both must be lists
        if not isinstance(lst1, list) or not isinstance(lst2, list):
            return False
        # Both must be non-empty
        if len(lst1) == 0 or len(lst2) == 0:
            return False
        # All elements must be numbers (int or float)
        for x in lst1:
            if not isinstance(x, (int, float)):
                return False
        for x in lst2:
            if not isinstance(x, (int, float)):
                return False
        return True
    except Exception:
        return False


def postcondition(input, output):
    try:
        lst1, lst2 = input
        # Output must be "YES" or "NO"
        if output not in ("YES", "NO"):
            return False
        
        # Count odd numbers in lst1 and even numbers in lst2
        odd_in_lst1 = sum(1 for x in lst1 if x % 2 != 0)
        even_in_lst2 = sum(1 for x in lst2 if x % 2 == 0)
        
        # It's possible iff there are enough even numbers in lst2 to replace all odd numbers in lst1
        expected = "YES" if even_in_lst2 >= odd_in_lst1 else "NO"
        
        return output == expected
    except Exception:
        return False

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
