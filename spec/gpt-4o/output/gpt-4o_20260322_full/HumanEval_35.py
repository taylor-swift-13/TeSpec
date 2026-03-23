def max_element_spec(l, max_elem):
    """
    Checks if max_elem is the maximum element in the list l.
    Coq definition:
    Definition max_element_spec (l : list nat) (max_elem : nat) : Prop :=
      In max_elem l /\ (forall x, In x l -> x <= max_elem).
    """
    # In max_elem l
    is_in_list = max_elem in l
    
    # forall x, In x l -> x <= max_elem
    is_maximal = all(x <= max_elem for x in l)
    
    return is_in_list and is_maximal

def _impl(l: list):
    return max(l)

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(max_element_spec(*input, output))

def max_element(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
