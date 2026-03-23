def _orig_get_positive_spec(l, output):
    """
    Checks if output contains exactly the positive elements of l.
    
    Coq Specification:
    Definition get_positive_spec (l: list Z) (output: list Z) : Prop :=
      (forall x, In x output -> In x l /\\ x > 0) /      (forall x, In x l -> x > 0 -> In x output).
    """
    cond1 = all((x in l and x > 0 for x in output))
    cond2 = all((x in output for x in l if x > 0))
    return cond1 and cond2

def get_positive_spec(l, output):
    return bool(_orig_get_positive_spec(l, output))
