
def precondition(input_args):
    return isinstance(input_args[0], (list, tuple))

def postcondition(input_args, output):
    nums = input_args[0]
    if not isinstance(output, int):
        return False
    
    expected_count = 0
    odd_digits = {'1', '3', '5', '7', '9'}
    for x in nums:
        if isinstance(x, (int, float)) and x > 10:
            s = str(int(x))
            if s[0] in odd_digits and s[-1] in odd_digits:
                expected_count += 1
    return output == expected_count

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
