
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    nums = input[0]
    if not isinstance(nums, (list, tuple)):
        return False
    for x in nums:
        if not isinstance(x, int):
            return False
    return True

def postcondition(input, output):
    if not isinstance(output, int):
        return False
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    nums = input[0]
    if not isinstance(nums, (list, tuple)):
        return False
    for x in nums:
        if not isinstance(x, int):
            return False
    count = 0
    for x in nums:
        if x > 10:
            y = abs(x)
            last = y % 10
            first = y
            while first >= 10:
                first //= 10
            if (first % 2 == 1) and (last % 2 == 1):
                count += 1
    return output == count

def _impl(nums):
    """
    Write a function that takes an array of numbers as input and returns 
    the number of elements in the array that are greater than 10 and both 
    first and last digits of a number are odd (1, 3, 5, 7, 9).
    For example:
    specialFilter([15, -73, 14, -15]) => 1 
    specialFilter([33, -2, -3, 45, 21, 109]) => 2
    """
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
