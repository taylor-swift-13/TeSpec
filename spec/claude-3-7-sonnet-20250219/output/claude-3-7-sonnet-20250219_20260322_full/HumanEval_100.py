def make_a_pile_spec(n, res):
    """
    Definition make_a_pile_spec (n : nat) (res : list nat) : Prop :=
      n > 0 /\
      length res = n /\
      (forall i, i < n -> nth i res 0 = n + 2 * i).
    """
    # n > 0
    if not (isinstance(n, int) and n > 0):
        return False
    
    # length res = n
    if not (isinstance(res, list) and len(res) == n):
        return False
    
    # forall i, i < n -> nth i res 0 = n + 2 * i
    # Since len(res) == n, for all i < n, nth i res 0 is simply res[i].
    for i in range(n):
        if res[i] != n + 2 * i:
            return False
            
    return True

def _impl(n):
    ans, num = [], n
    for _ in range(n):
        ans.append(num)
        num += 2
    return ans

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(make_a_pile_spec(*input, output))

def make_a_pile(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
