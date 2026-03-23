def _orig_concatenate_spec(strings, output):
    """
    Implements the Coq definition:
    Definition concatenate_spec (strings : list string) (output : string) : Prop :=
      output = fold_right append "" strings.
      
    In Coq, fold_right append "" strings computes the concatenation of all strings
    in the list. In Python, this is equivalent to "".join(strings).
    """
    return output == ''.join(strings)

def concatenate_spec(strings, output):
    return bool(_orig_concatenate_spec(strings, output))
