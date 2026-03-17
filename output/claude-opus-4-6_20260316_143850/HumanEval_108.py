
def precondition(input):
    args = input
    if len(args) != 1:
        return False
    arr = args[0]
    if not isinstance(arr, (list, tuple)):
        return False
    for x in arr:
        if not isinstance(x, int) or isinstance(x, bool):
            return False
    return True


def postcondition(input, output):
    arr = input[0]
    if not isinstance(output, int):
        return False
    if output < 0 or output > len(arr):
        return False
    
    # Verify by computing expected result
    count = 0
    for x in arr:
        if x == 0:
            continue
        digits_sum = 0
        neg = x < 0
        n = abs(x)
        digits = []
        while n > 0:
            digits.append(n % 10)
            n //= 10
        digits.reverse()
        if neg and len(digits) > 0:
            digits[0] = -digits[0]
        digits_sum = sum(digits)
        if digits_sum > 0:
            count += 1
    
    return output == count

def _impl(arr):
    """Write a function count_nums which takes an array of integers and returns
    the number of elements which has a sum of digits > 0.
    If a number is negative, then its first signed digit will be negative:
    e.g. -123 has signed digits -1, 2, and 3."""
    def judge(x: int) -> int:
        l = list(str(x))
        if l[0] == "-":
            l = l[1:]
            l = list(map(int, l))
            l[0] = -l[0]
        else:
            l = list(map(int, l))
        return 1 if sum(l) > 0 else 0
    return sum(map(judge, arr))

def count_nums(arr):
    _input = (arr,)
    assert precondition(_input)
    _output = _impl(arr)
    assert postcondition(_input, _output)
    return _output
