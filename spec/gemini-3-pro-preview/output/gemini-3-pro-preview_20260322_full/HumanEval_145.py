def nat_to_digits_rev(n, fuel):
    res = []
    while fuel > 0:
        if n == 0:
            break
        res.append(n % 10)
        n //= 10
        fuel -= 1
    return res

def get_digits(z):
    if z == 0:
        return [0]
    n = abs(z)
    return list(reversed(nat_to_digits_rev(n, n + 1)))

def sum_list(l):
    return sum(l)

def weight(x):
    ds = get_digits(x)
    if x < 0:
        if not ds:
            return 0
        return -ds[0] + sum_list(ds[1:])
    else:
        return sum_list(ds)

def weight_index_le(p1, p2):
    v1, i1 = p1
    v2, i2 = p2
    w1 = weight(v1)
    w2 = weight(v2)
    return w1 < w2 or (w1 == w2 and i1 <= i2)

def order_by_points_spec(nums, res):
    # Python's built-in sorted function is guaranteed to be stable,
    # which perfectly matches the weight_index_le sorting logic
    # (sorting by weight first, then preserving original index order).
    expected = sorted(nums, key=weight)
    return res == expected

def _impl(nums):
    def weight(x):
        x_list = list(str(x))
        if x_list[0] == "-":
            x_list = x_list[1:]
            x_list = list(map(int, x_list))
            x_list[0] = -x_list[0]
        else:
            x_list = list(map(int, x_list))
        return sum(x_list)
    return sorted(nums, key=weight)

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(order_by_points_spec(*input, output))

def order_by_points(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
