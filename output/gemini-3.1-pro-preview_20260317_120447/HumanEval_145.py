
def precondition(inp):
    if len(inp) != 1:
        return False
    nums = inp[0]
    if not isinstance(nums, list):
        return False
    if not all(isinstance(x, int) for x in nums):
        return False
    return True

def postcondition(inp, out):
    nums = inp[0]
    if not isinstance(out, list):
        return False
    
    def sum_of_digits(n):
        return sum(int(d) for d in str(abs(n)))
        
    return out == sorted(nums, key=sum_of_digits)

def _impl(nums):
    """Write a function which sorts the given list of integers
    in ascending order according to the sum of their digits.
    Note: if there are several items with similar sum of their digits,
    order them based on their index in original list.

    For example:"""
    def weight(x):
        x_list = list(str(x))
        if x_list[0] == "-":
            x_list = x_list[1:]
            x_list = list(map(int, x_list))
            x_list[0] = -x_list[0]
        else:
            x_list = list(map(int, x_list))
        return sum(x_list)
    return sorted(nums, key=weight)

def order_by_points(nums):
    _input = (nums,)
    assert precondition(_input)
    _output = _impl(nums)
    assert postcondition(_input, _output)
    return _output
