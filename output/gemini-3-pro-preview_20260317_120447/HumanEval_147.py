
def precondition(input_args: tuple) -> bool:
    n = input_args[0]
    return isinstance(n, int) and n > 0

def postcondition(input_args: tuple, output: int) -> bool:
    n = input_args[0]
    # a[i] = i*i - i + 1
    # a[i] % 3:
    # i % 3 == 1 -> 1 - 1 + 1 = 1
    # i % 3 == 2 -> 4 - 2 + 1 = 3 = 0
    # i % 3 == 0 -> 0 - 0 + 1 = 1
    # The sequence of remainders mod 3 is 1, 0, 1, 1, 0, 1, ...
    # c0 is the count of i in [1, n] such that i % 3 == 2
    c0 = (n + 1) // 3
    # c1 is the count of i in [1, n] such that i % 3 == 1 or i % 3 == 0
    c1 = n - c0
    
    def combinations_3(count):
        if count < 3:
            return 0
        return (count * (count - 1) * (count - 2)) // 6
    
    expected_count = combinations_3(c0) + combinations_3(c1)
    return output == expected_count

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
