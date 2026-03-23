def incr_list_spec(l, res):
    """
    Checks if 'res' is the result of incrementing each element in 'l' by 1.
    Corresponds to the Coq definition:
    Definition incr_list_spec (l res : list nat) : Prop :=
      length l = length res /\
      forall i, nth_error res i = 
                match nth_error l i with
                | Some x => Some (x + 1)
                | None => None
                end.
    """
    # Check length equality
    if len(l) != len(res):
        return False
    
    # Check that for every index i, res[i] == l[i] + 1
    # Since lengths are equal, we only need to check indices within the list bounds.
    # For i >= len(l), nth_error returns None for both, satisfying the condition.
    for i in range(len(l)):
        if res[i] != l[i] + 1:
            return False
            
    return True
