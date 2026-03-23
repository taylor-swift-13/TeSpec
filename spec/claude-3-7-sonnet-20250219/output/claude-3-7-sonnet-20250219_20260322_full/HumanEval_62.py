def derivative_spec(xs, ds):
    """
    Implements the Coq specification:
    Fixpoint derivative_spec (xs : list nat) (ds : list nat) : Prop :=
      length ds = pred (length xs) /\
      (forall i : nat, 1 <= i < length xs -> nth i ds 0 = nth i xs 0 * i).
    """
    
    # length ds = pred (length xs)
    # In Coq, pred 0 is 0.
    len_xs = len(xs)
    len_ds = len(ds)
    
    expected_len_ds = max(0, len_xs - 1)
    if len_ds != expected_len_ds:
        return False
    
    # Helper for Coq's nth function: nth n l default
    def nth(n, l, default):
        if 0 <= n < len(l):
            return l[n]
        return default

    # forall i : nat, 1 <= i < length xs -> nth i ds 0 = nth i xs 0 * i
    # Note: In Coq, nth is 0-indexed.
    for i in range(1, len_xs):
        val_ds = nth(i, ds, 0)
        val_xs = nth(i, xs, 0)
        
        if val_ds != val_xs * i:
            return False
            
    return True

def _impl(xs: list):
    return [xs[i] * i for i in range(1, len(xs))]

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(derivative_spec(*input, output))

def derivative(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
