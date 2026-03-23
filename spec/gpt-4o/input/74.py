def total_match_spec(lst1, lst2, result):
    """
    Implementation of the Coq total_match_spec.
    Returns True if result is the list with the smaller total character count 
    (or lst1 if counts are equal), False otherwise.
    """
    # Calculate the total length of strings in lst1
    # Equivalent to fold_left (fun acc s => acc + String.length s) lst1 0
    c1 = sum(len(s) for s in lst1)
    
    # Calculate the total length of strings in lst2
    # Equivalent to fold_left (fun acc s => acc + String.length s) lst2 0
    c2 = sum(len(s) for s in lst2)
    
    # (c1 <= c2 /\ result = lst1) \/ (c1 > c2 /\ result = lst2)
    cond1 = (c1 <= c2 and result == lst1)
    cond2 = (c1 > c2 and result == lst2)
    
    return cond1 or cond2
