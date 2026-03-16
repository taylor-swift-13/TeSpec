
def precondition(args) -> bool:
    if not isinstance(args, tuple):
        return False
    if len(args) != 1:
        return False
    n = args[0]
    if isinstance(n, bool) or not isinstance(n, int):
        return False
    if n < 0:
        return False
    return True

def postcondition(args, output) -> bool:
    if not precondition(args):
        return False
    n = args[0]
    if isinstance(output, bool) or not isinstance(output, int):
        return False
    if output < 0:
        return False
    # Count of indices i in [1..n] with i % 3 == 2
    q, r = divmod(n, 3)
    z = q + (1 if r == 2 else 0)  # count where a[i] % 3 == 0
    o = n - z                     # count where a[i] % 3 == 1
    def comb3(m):
        return (m * (m - 1) * (m - 2)) // 6 if m >= 3 else 0
    expected = comb3(z) + comb3(o)
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
