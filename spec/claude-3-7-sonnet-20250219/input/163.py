def even(n):
    return n % 2 == 0

def _orig_generate_integers_spec(a, b, output):
    if not (a > 0 and b > 0):
        return False
    limit = min(b, 9)
    sub = limit - a if limit >= a else 0
    length = sub + 1
    seq = list(range(a, a + length))
    filtered_seq = [i for i in seq if a <= i <= limit]
    expected_res = [i for i in filtered_seq if even(i)]
    if output != expected_res:
        return False
    if len(output) != len(set(output)):
        return False
    for x in output:
        if not (a <= x <= b or b <= x <= a):
            return False
    for x in output:
        if not even(x):
            return False
    for x in range(10):
        if even(x) and (a <= x <= b or b <= x <= a):
            if x not in output:
                return False
    return True

def generate_integers_spec(a, b, output):
    return bool(_orig_generate_integers_spec(a, b, output))
