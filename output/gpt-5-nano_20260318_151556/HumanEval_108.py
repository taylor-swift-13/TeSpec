
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
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    arr = input[0]
    if not isinstance(arr, (list, tuple)):
        return False
    for x in arr:
        if not isinstance(x, int):
            return False

    def sum_signed_digits(n):
        if n == 0:
            return 0
        abs_str = str(abs(n))
        digits_sum = sum(int(ch) for ch in abs_str)
        if n < 0:
            first_digit = int(abs_str[0])
            digits_sum -= 2 * first_digit
        return digits_sum

    expected = 0
    for x in arr:
        if sum_signed_digits(x) > 0:
            expected += 1

    return isinstance(output, int) and output == expected

def _impl(arr):
    """
    Write a function count_nums which takes an array of integers and returns
    the number of elements which has a sum of digits > 0.
    If a number is negative, then its first signed digit will be negative:
    e.g. -123 has signed digits -1, 2, and 3.
    """
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
