
def precondition(args):
    arr = args[0]
    if not isinstance(arr, list):
        return False
    for x in arr:
        if not isinstance(x, int):
            return False
    return True

def postcondition(args, result):
    arr = args[0]
    if not isinstance(result, int):
        return False
    if result < 0:
        return False
    count = 0
    for num in arr:
        if not isinstance(num, int):
            return False
        s = sum(int(d) for d in str(abs(num)))
        if num < 0:
            s = -int(str(abs(num))[0]) + sum(int(d) for d in str(abs(num))[1:])
        if s > 0:
            count += 1
    return result == count

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
