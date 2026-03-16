
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    nums = input[0]
    from collections.abc import Sequence
    if not isinstance(nums, Sequence):
        return False
    if isinstance(nums, (str, bytes, bytearray)):
        return False
    try:
        import numbers
        for x in nums:
            if not isinstance(x, numbers.Integral):
                return False
    except Exception:
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    nums = input[0]
    import numbers
    if not isinstance(output, numbers.Integral):
        return False
    if output < 0:
        return False

    def both_first_last_digits_odd(n):
        a = abs(int(n))
        last = a % 10
        first = a
        while first >= 10:
            first //= 10
        return (first % 2 == 1) and (last % 2 == 1)

    count = 0
    try:
        for x in nums:
            if isinstance(x, numbers.Integral) and x > 10 and both_first_last_digits_odd(x):
                count += 1
    except Exception:
        return False

    try:
        if output > len(nums):
            return False
    except Exception:
        pass

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
