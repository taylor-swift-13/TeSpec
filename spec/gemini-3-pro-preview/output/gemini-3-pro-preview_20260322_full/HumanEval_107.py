def digits_nat(n, fuel):
    res = []
    while fuel > 0:
        if n == 0:
            break
        res.append(n % 10)
        n = n // 10
        fuel -= 1
    return res

def z_to_digits(n):
    n_nat = max(0, int(n))
    d = digits_nat(n_nat, n_nat + 1)
    return list(reversed(d))

def is_palindrome(n):
    d = z_to_digits(n)
    return d == list(reversed(d))

def seq_Z(start, length):
    if length == 0:
        return []
    return list(range(start, start + length))

def even_odd_palindrome_spec(n, res):
    even_cnt, odd_cnt = res
    n_nat = max(0, int(n))
    range_list = seq_Z(1, n_nat)
    palindromes = [x for x in range_list if is_palindrome(x)]
    expected_even = sum(1 for x in palindromes if x % 2 == 0)
    expected_odd = sum(1 for x in palindromes if x % 2 != 0)
    return even_cnt == expected_even and odd_cnt == expected_odd

def _impl(n):
    odd_cnt, even_cnt = 0, 0
    for i in range(1, n + 1):
        if str(i) == str(i)[::-1]:
            if i % 2 == 1:
                odd_cnt += 1
            else:
                even_cnt += 1
    return even_cnt, odd_cnt

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(even_odd_palindrome_spec(*input, output))

def even_odd_palindrome(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
