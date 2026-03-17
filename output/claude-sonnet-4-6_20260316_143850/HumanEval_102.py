
def precondition(args):
    if len(args) != 2:
        return False
    x, y = args
    if not isinstance(x, (int, float)):
        return False
    if not isinstance(y, (int, float)):
        return False
    if x <= 0 or y <= 0:
        return False
    return True


def postcondition(args, output):
    x, y = args
    if not isinstance(output, (int, float)):
        return False
    if output == -1:
        # There should be no even integer in [x, y]
        import math
        low = math.ceil(x)
        high = math.floor(y)
        for n in range(low, high + 1):
            if n % 2 == 0:
                return False
        return True
    # output should be an even integer
    if output != int(output):
        return False
    output_int = int(output)
    if output_int % 2 != 0:
        return False
    # output should be in [x, y]
    if output_int < x or output_int > y:
        return False
    # output should be the biggest such even integer
    import math
    high = math.floor(y)
    # find the largest even number <= high
    if high % 2 == 0:
        biggest_even = high
    else:
        biggest_even = high - 1
    if biggest_even < x:
        return False
    if output_int != biggest_even:
        return False
    return True

def _impl(x, y):
    """This function takes two positive numbers x and y and returns the
    biggest even integer number that is in the range [x, y] inclusive. If 
    there's no such number, then the function should return -1.

    For example:
    choose_num(12, 15) = 14
    choose_num(13, 12) = -1"""
    if x > y: return -1
    if x == y: return y if y % 2 == 0 else -1
    return y if y % 2 == 0 else y - 1

def choose_num(x, y):
    _input = (x, y)
    assert precondition(_input)
    _output = _impl(x, y)
    assert postcondition(_input, _output)
    return _output
