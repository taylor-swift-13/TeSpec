def to_digits_helper(n, k):
    res = []
    for _ in range(k):
        if n == 0:
            break
        res.append(n % 10)
        n = n // 10
    return res

def to_digits_rev(n):
    return to_digits_helper(n, n)

def list_nat_eqb(l1, l2):
    return l1 == l2

def is_palindrome_b(n):
    if n == 0:
        return False
    d = to_digits_rev(n)
    return d == d[::-1]

def is_even(n):
    return n % 2 == 0

def is_even_pal(n):
    return is_palindrome_b(n) and is_even(n)

def is_odd_pal(n):
    return is_palindrome_b(n) and not is_even(n)

def count_in_range(P, k):
    count = 0
    for i in range(1, k + 1):
        if P(i):
            count += 1
    return count

def count_palindromes_impl(n):
    return (count_in_range(is_even_pal, n), count_in_range(is_odd_pal, n))

def _orig_problem_107_pre(n):
    return n > 0

def _orig_problem_107_spec(n, output):
    return output == count_palindromes_impl(n)

def problem_107_pre(n):
    return bool(_orig_problem_107_pre(n))

def problem_107_spec(n, output):
    return bool(_orig_problem_107_spec(n, output))
