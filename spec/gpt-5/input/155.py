def count_even(l):
    count = 0
    for d in l:
        if d % 2 == 0:
            count += 1
    return count

def count_odd(l):
    count = 0
    for d in l:
        if d % 2 != 0:
            count += 1
    return count

def digits10(n, l):
    if n < 0:
        return False
    if n == 0:
        return l == [0]
    digits = []
    temp = n
    while temp > 0:
        digits.append(temp % 10)
        temp //= 10
    digits.reverse()
    return l == digits

def _orig_even_odd_count_spec(num, output):
    n = abs(num)
    if n == 0:
        digits = [0]
    else:
        digits = []
        temp = n
        while temp > 0:
            digits.append(temp % 10)
            temp //= 10
        digits.reverse()
    return tuple(output) == (count_even(digits), count_odd(digits))

def even_odd_count_spec(num, output):
    return bool(_orig_even_odd_count_spec(num, output))
