def total_length(lst):
    """
    Calculates the total length of all strings in a list.
    Equivalent to the Coq Fixpoint total_length.
    """
    count = 0
    for s in lst:
        count += len(s)
    return count

def total_match_spec(lst1, lst2, result):
    """
    Checks if the result matches the list with the smaller total length.
    If total lengths are equal, it checks if result matches lst1.
    Equivalent to the Coq Definition total_match_spec.
    """
    c1 = total_length(lst1)
    c2 = total_length(lst2)
    
    # Nat.leb c1 c2 is equivalent to c1 <= c2
    if c1 <= c2:
        return result == lst1
    else:
        return result == lst2
