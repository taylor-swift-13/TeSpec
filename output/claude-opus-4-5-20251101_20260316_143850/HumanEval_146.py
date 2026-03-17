
def precondition(input):
    if len(input) != 1:
        return False
    nums = input[0]
    if not isinstance(nums, (list, tuple)):
        return False
    for num in nums:
        if not isinstance(num, (int, float)):
            return False
        if isinstance(num, bool):
            return False
    return True

def postcondition(input, output):
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    nums = input[0]
    if output > len(nums):
        return False
    
    odd_digits = {'1', '3', '5', '7', '9'}
    count = 0
    for num in nums:
        if num > 10:
            num_str = str(int(abs(num)))
            first_digit = num_str[0]
            last_digit = num_str[-1]
            if first_digit in odd_digits and last_digit in odd_digits:
                count += 1
    
    return output == count

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
