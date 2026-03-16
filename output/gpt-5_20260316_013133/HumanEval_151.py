
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    lst = input[0]
    # Must be an iterable, non-iterator, sized container to avoid consumption issues
    try:
        iter(lst)
    except Exception:
        return False
    if hasattr(lst, "__next__"):
        return False
    try:
        len(lst)
    except Exception:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    lst = input[0]

    def compute_total(seq, include_bool):
        total = 0
        for x in seq:
            if isinstance(x, bool):
                if not include_bool:
                    continue
                v = 1 if x else 0
            elif isinstance(x, int):
                v = x
            else:
                continue
            if v >= 0 and v % 2 == 1:
                total += v * v
        return total

    expected_excluding_bool = compute_total(lst, include_bool=False)
    expected_including_bool = compute_total(lst, include_bool=True)

    try:
        return output == expected_excluding_bool or output == expected_including_bool
    except Exception:
        return False

def _impl(lst):
    """Given a list of numbers, return the sum of squares of the numbers
    in the list that are odd. Ignore numbers that are negative or not integers.

    double_the_difference([1, 3, 2, 0]) == 1 + 9 + 0 + 0 = 10
    double_the_difference([-1, -2, 0]) == 0
    double_the_difference([9, -2]) == 81
    double_the_difference([0]) == 0  

    If the input list is empty, return 0."""
    ans = 0
    for num in lst:
        if num % 2 == 1 and num > 0 and "." not in str(num):
            ans += num ** 2
    return ans

def double_the_difference(lst):
    _input = (lst,)
    assert precondition(_input)
    _output = _impl(lst)
    assert postcondition(_input, _output)
    return _output
