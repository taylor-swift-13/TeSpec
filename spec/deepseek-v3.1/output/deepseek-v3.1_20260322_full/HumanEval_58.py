def NoDup(l):
    """Check if a list has no duplicate elements."""
    return len(set(l)) == len(l)

def StronglySorted_lt(l):
    """Check if a list is strictly increasing (StronglySorted with Z.lt)."""
    for i in range(len(l) - 1):
        if not (l[i] < l[i+1]):
            return False
    return True

def common_spec(l1, l2, result):
    """
    Check if result is the strictly sorted list of unique elements common to l1 and l2.
    
    Coq Specification:
    Definition common_spec (l1 : list Z) (l2 : list Z) (result : list Z) : Prop :=
      exists common_set : list Z,
        NoDup common_set /\
        (forall x : Z, In x common_set <-> (In x l1 /\ In x l2)) /\
        StronglySorted Z.lt common_set /\
        result = common_set.
    """
    # The existence of common_set such that result = common_set 
    # means result itself must satisfy all the conditions.
    
    # 1. NoDup result
    if not NoDup(result):
        return False
    
    # 2. (forall x : Z, In x result <-> (In x l1 /\ In x l2))
    # This means result must contain exactly the elements that are in both l1 and l2.
    set_l1 = set(l1)
    set_l2 = set(l2)
    set_result = set(result)
    intersection = set_l1.intersection(set_l2)
    if set_result != intersection:
        return False
        
    # 3. StronglySorted Z.lt result
    # For integers, StronglySorted with the less-than relation means strictly increasing.
    if not StronglySorted_lt(result):
        return False
        
    return True

def _impl(l1: list, l2: list):
    return sorted(list(set(l1).intersection(set(l2))))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(common_spec(*input, output))

def common(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
