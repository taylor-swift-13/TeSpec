def count_digits_acc(l, acc):
    e, o = acc
    for h in l:
        if h % 2 == 0:
            e += 1
        else:
            o += 1
    return (e, o)

def to_digits_fuel(fuel, n):
    res = []
    for _ in range(fuel):
        p = abs(n)
        if p == 0:
            break
        res.append(p % 10)
        n = p // 10
    return res

def even_odd_count_impl(num):
    fuel = abs(num) + 1
    l = to_digits_fuel(fuel, num)
    return count_digits_acc(l, (0, 0))

def _orig_problem_155_pre(num):
    return True

def _orig_problem_155_spec(num, output):
    return output == even_odd_count_impl(num)

def problem_155_pre(num):
    return bool(_orig_problem_155_pre(num))

def problem_155_spec(num, output):
    return bool(_orig_problem_155_spec(num, output))
