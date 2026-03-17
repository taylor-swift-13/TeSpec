
def precondition(input):
    args = input
    if len(args) != 1:
        return False
    lst = args[0]
    if not isinstance(lst, list):
        return False
    for item in lst:
        if not isinstance(item, int):
            return False
    return True


def postcondition(input, output):
    args = input
    lst = args[0]
    if not isinstance(output, (int, float)):
        return False
    expected = 0
    for i in range(len(lst)):
        if i % 3 == 0:
            expected += lst[i] ** 2
        elif i % 4 == 0:
            expected += lst[i] ** 3
        else:
            expected += lst[i]
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
