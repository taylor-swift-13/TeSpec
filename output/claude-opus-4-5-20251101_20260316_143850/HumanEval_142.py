
def precondition(args):
    lst = args[0]
    # Check that lst is a list
    if not isinstance(lst, list):
        return False
    # Check that all elements are integers
    for item in lst:
        if not isinstance(item, int):
            return False
        # Exclude bool since bool is subclass of int
        if isinstance(item, bool):
            return False
    return True


def postcondition(args, output):
    lst = args[0]
    # Output must be an integer
    if not isinstance(output, int):
        return False
    if isinstance(output, bool):
        return False
    # Compute expected result
    expected = 0
    for i, val in enumerate(lst):
        if i % 3 == 0:
            # Index is multiple of 3, square it
            expected += val * val
        elif i % 4 == 0:
            # Index is multiple of 4 but not multiple of 3, cube it
            expected += val * val * val
        else:
            # No change
            expected += val
    return output == expected

def _impl(lst):
    """
    "
    This function will take a list of integers. For all entries in the list, the function shall square the integer entry if its index is a 
    multiple of 3 and will cube the integer entry if its index is a multiple of 4 and not a multiple of 3. The function will not 
    change the entries in the list whose indexes are not a multiple of 3 or 4. The function shall then return the sum of all entries. 

    Examples:
    For lst = [1,2,3] the output should be 6
    For lst = []  the output should be 0
    For lst = [-1,-5,2,-1,-5]  the output should be -126
    """
    ans = 0
    for i, num in enumerate(lst):
        if i % 3 == 0:
            ans += num ** 2
        elif i % 4 == 0:
            ans += num ** 3
        else:
            ans += num
    return ans

def sum_squares(lst):
    _input = (lst,)
    assert precondition(_input)
    _output = _impl(lst)
    assert postcondition(_input, _output)
    return _output
