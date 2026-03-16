
def precondition(input):
    # input is a tuple of positional arguments
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    lst = input[0]
    if not isinstance(lst, list):
        return False
    for x in lst:
        if type(x) is not int:
            return False
    return True

def postcondition(input, output):
    # input is a tuple of positional arguments, output is the function result
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    lst = input[0]
    if not isinstance(lst, list):
        return False
    for x in lst:
        if type(x) is not int:
            return False
    if not isinstance(output, int):
        return False

    total = 0
    for idx, val in enumerate(lst):
        if idx % 3 == 0:
            transformed = val * val
        elif idx % 4 == 0:  # not a multiple of 3 due to the prior check
            transformed = val * val * val
        else:
            transformed = val
        total += transformed
    return output == total

def _impl(lst):
    """"
    This function will take a list of integers. For all entries in the list, the function shall square the integer entry if its index is a 
    multiple of 3 and will cube the integer entry if its index is a multiple of 4 and not a multiple of 3. The function will not 
    change the entries in the list whose indexes are not a multiple of 3 or 4. The function shall then return the sum of all entries. 

    Examples:
    For lst = [1,2,3] the output should be 6
    For lst = []  the output should be 0
    For lst = [-1,-5,2,-1,-5]  the output should be -126"""
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
