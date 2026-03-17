
def precondition(input):
    arr = input[0]
    return isinstance(arr, list) and all(isinstance(x, int) for x in arr)

def postcondition(input, output):
    arr = input[0]
    if not isinstance(output, int) or output < 0 or output > len(arr):
        return False
    
    count = 0
    for num in arr:
        s = str(abs(num))
        digits = [int(d) for d in s]
        if num < 0:
            digits[0] = -digits[0]
        if sum(digits) > 0:
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
