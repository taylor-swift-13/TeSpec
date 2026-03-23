def count_digit_7_aux(k, fuel):
    res = 0
    for _ in range(fuel):
        if k == 0:
            break
        if k % 10 == 7:
            res += 1
        k //= 10
    return res

def count_digit_7(k):
    return count_digit_7_aux(k, k)

def fizz_buzz_impl(n):
    acc = 0
    for i in range(n):
        if i % 11 == 0 or i % 13 == 0:
            acc += count_digit_7(i)
    return acc

def _orig_problem_36_pre(n):
    return True

def _orig_problem_36_spec(n, output):
    return output == fizz_buzz_impl(n)

def problem_36_pre(n):
    return bool(_orig_problem_36_pre(n))

def problem_36_spec(n, output):
    return bool(_orig_problem_36_spec(n, output))
