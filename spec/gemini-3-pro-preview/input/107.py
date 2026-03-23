def digits_nat(n, fuel):
    output = []
    while fuel > 0:
        if n == 0:
            break
        output.append(n % 10)
        n = n // 10
        fuel -= 1
    return output

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

def _orig_even_odd_palindrome_spec(n, output):
    (even_cnt, odd_cnt) = output
    n_nat = max(0, int(n))
    range_list = seq_Z(1, n_nat)
    palindromes = [x for x in range_list if is_palindrome(x)]
    expected_even = sum((1 for x in palindromes if x % 2 == 0))
    expected_odd = sum((1 for x in palindromes if x % 2 != 0))
    return even_cnt == expected_even and odd_cnt == expected_odd

def even_odd_palindrome_spec(n, output):
    return bool(_orig_even_odd_palindrome_spec(n, output))
