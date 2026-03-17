
def precondition(inp):
    if len(inp) != 1:
        return False
    nums = inp[0]
    if not isinstance(nums, (list, tuple)):
        return False
    return all(isinstance(x, (int, float)) for x in nums)

def postcondition(inp, out):
    nums = inp[0]
    if type(out) is not int:
        return False
    return 0 <= out <= len(nums)

def _impl(nums):
    """Write a function that takes an array of numbers as input and returns 
    the number of elements in the array that are greater than 10 and both 
    first and last digits of a number are odd (1, 3, 5, 7, 9).
    For example:
    specialFilter([15, -73, 14, -15]) => 1 
    specialFilter([33, -2, -3, 45, 21, 109]) => 2"""
    ans, odd = 0, ["1", "3", "5", "7", "9"]
    for num in nums:
        if num > 10 and str(num)[0] in odd and str(num)[-1] in odd:
            ans += 1
    return ans

def specialFilter(nums):
    _input = (nums,)
    assert precondition(_input)
    _output = _impl(nums)
    assert postcondition(_input, _output)
    return _output
