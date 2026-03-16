
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    arr = input[0]
    if not isinstance(arr, (list, tuple)):
        return False
    for x in arr:
        if not isinstance(x, int):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    arr = input[0]
    if not isinstance(output, int):
        return False
    if output < 0 or output > len(arr):
        return False

    def signed_digit_sum(n: int) -> int:
        if n >= 0:
            if n == 0:
                return 0
            return sum(int(ch) for ch in str(n))
        else:
            t = str(-n)
            first = int(t[0])
            rest = sum(int(ch) for ch in t[1:]) if len(t) > 1 else 0
            return -first + rest

    expected = 0
    for n in arr:
        if signed_digit_sum(n) > 0:
            expected += 1
    return output == expected

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
