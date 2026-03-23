def get_positive_spec(l, res):
    """
    Checks if res contains exactly the positive elements of l.
    
    Coq Specification:
    Definition get_positive_spec (l: list Z) (res: list Z) : Prop :=
      (forall x, In x res -> In x l /\ x > 0) /\
      (forall x, In x l -> x > 0 -> In x res).
    """
    # (forall x, In x res -> In x l /\ x > 0)
    # Every element in the result list must be present in the original list and be positive.
    cond1 = all(x in l and x > 0 for x in res)

    # (forall x, In x l -> x > 0 -> In x res)
    # Every positive element in the original list must be present in the result list.
    cond2 = all(x in res for x in l if x > 0)

    return cond1 and cond2
