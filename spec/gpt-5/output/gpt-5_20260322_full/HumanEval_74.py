def total_chars(l):
    """
    Definition total_chars (l : list string) : nat :=
      fold_right (fun s acc => String.length s + acc) 0 l.
    """
    return sum(len(s) for s in l)

def total_match_spec(lst1, lst2, res):
    """
    Definition total_match_spec (lst1 lst2 res : list string) : Prop :=
      (total_chars lst1 <= total_chars lst2 /\ res = lst1) \/
      (total_chars lst2 < total_chars lst1 /\ res = lst2).
    """
    tc1 = total_chars(lst1)
    tc2 = total_chars(lst2)
    
    return (tc1 <= tc2 and res == lst1) or (tc2 < tc1 and res == lst2)

def _impl(lst1, lst2):
    c1, c2 = sum(map(lambda s: len(s), lst1)), sum(map(lambda s: len(s), lst2))
    return lst1 if c1 <= c2 else lst2

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(total_match_spec(*input, output))

def total_match(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
