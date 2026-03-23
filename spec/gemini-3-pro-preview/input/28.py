def concatenate_spec(strings, result):
    """
    Implements the Coq definition:
    Definition concatenate_spec (strings : list string) (result : string) : Prop :=
      result = fold_right append "" strings.
      
    In Coq, fold_right append "" strings computes the concatenation of all strings
    in the list. In Python, this is equivalent to "".join(strings).
    """
    return result == "".join(strings)
