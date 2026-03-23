def nat_to_digits_rev(n, fuel):
    output = []
    while fuel > 0:
        if n == 0:
            break
        output.append(n % 10)
        n //= 10
        fuel -= 1
    return output

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

def _orig_order_by_points_spec(nums, output):
    expected = sorted(nums, key=weight)
    return output == expected

def order_by_points_spec(nums, output):
    return bool(_orig_order_by_points_spec(nums, output))
