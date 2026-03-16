
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if n < 1:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    n = input[0]
    if not isinstance(output, int):
        return False
    # count of i in 1..n with i % 3 == 2 -> these a[i] are 0 mod 3
    cnt0 = n // 3 + (1 if n % 3 >= 2 else 0)
    cnt1 = n - cnt0
    def choose3(x):
        if x < 3:
            return 0
        return (x * (x - 1) * (x - 2)) // 6
    expected = choose3(cnt0) + choose3(cnt1)
    return output == expected

def _impl(n):
    """You are given a positive integer n. You have to create an integer array a of length n.
        For each i (1 ≤ i ≤ n), the value of a[i] = i * i - i + 1.
        Return the number of triples (a[i], a[j], a[k]) of a where i < j < k, 
    and a[i] + a[j] + a[k] is a multiple of 3.

    Example :
        Input: n = 5
        Output: 1
        Explanation: 
        a = [1, 3, 7, 13, 21]
        The only valid triple is (1, 7, 13)."""
    if n <= 2: return False
    one_cnt = 1 + (n - 2) // 3 * 2 + (n - 2) % 3
    zero_cnt = n - one_cnt
    return one_cnt * (one_cnt - 1) * (one_cnt - 2) // 6 + zero_cnt * (zero_cnt - 1) * (zero_cnt - 2) // 6

def get_max_triples(n):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
