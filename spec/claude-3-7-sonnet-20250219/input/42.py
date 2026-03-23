def _orig_incr_list_spec(l, output):
    """
    Checks if 'output' is the result of incrementing each element in 'l' by 1.
    Corresponds to the Coq definition:
    Definition incr_list_spec (l output : list nat) : Prop :=
      length l = length output /      forall i, nth_error output i = 
                match nth_error l i with
                | Some x => Some (x + 1)
                | None => None
                end.
    """
    if len(l) != len(output):
        return False
    for i in range(len(l)):
        if output[i] != l[i] + 1:
            return False
    return True

def incr_list_spec(l, output):
    return bool(_orig_incr_list_spec(l, output))
