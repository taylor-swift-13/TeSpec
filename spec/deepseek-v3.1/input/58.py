def NoDup(l):
    """Check if a list has no duplicate elements."""
    return len(set(l)) == len(l)

def StronglySorted_lt(l):
    """Check if a list is strictly increasing (StronglySorted with Z.lt)."""
    for i in range(len(l) - 1):
        if not (l[i] < l[i+1]):
            return False
    return True

def _orig_common_spec(l1, l2, output):
    """
    Check if output is the strictly sorted list of unique elements common to l1 and l2.
    
    Coq Specification:
    Definition common_spec (l1 : list Z) (l2 : list Z) (output : list Z) : Prop :=
      exists common_set : list Z,
        NoDup common_set /        (forall x : Z, In x common_set <-> (In x l1 /\\ In x l2)) /        StronglySorted Z.lt common_set /        output = common_set.
    """
    if not NoDup(output):
        return False
    set_l1 = set(l1)
    set_l2 = set(l2)
    set_result = set(output)
    intersection = set_l1.intersection(set_l2)
    if set_result != intersection:
        return False
    if not StronglySorted_lt(output):
        return False
    return True

def common_spec(l1, l2, output):
    return bool(_orig_common_spec(l1, l2, output))
