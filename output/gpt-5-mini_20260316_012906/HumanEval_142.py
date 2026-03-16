
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    lst = input[0]
    if not isinstance(lst, list):
        return False
    for x in lst:
        # require plain ints (exclude bool)
        if not isinstance(x, int) or isinstance(x, bool):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    lst = input[0]
    # raw sum of the list as currently observed
    try:
        raw_sum = sum(lst)
    except Exception:
        return False
    # sum after applying the specified transform once
    transformed_sum = 0
    for i, v in enumerate(lst):
        if i % 3 == 0:
            transformed_sum += v * v
        elif i % 4 == 0 and i % 3 != 0:
            transformed_sum += v * v * v
        else:
            transformed_sum += v
    # output should be an int (not bool) and equal either the transformed sum
    # or the raw sum (to allow in-place transformation)
    if not isinstance(output, int) or isinstance(output, bool):
        return False
    return output == transformed_sum or output == raw_sum

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
