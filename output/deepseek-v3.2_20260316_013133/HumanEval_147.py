
def precondition(args):
    n = args[0]
    return isinstance(n, int) and n > 0

def postcondition(args, result):
    n = args[0]
    if not isinstance(result, int):
        return False
    if n < 3:
        return result == 0
    return 0 <= result <= n * (n - 1) * (n - 2) // 6

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
