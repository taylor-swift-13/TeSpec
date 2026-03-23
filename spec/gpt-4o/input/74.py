def _orig_total_match_spec(lst1, lst2, output):
    """
    Implementation of the Coq total_match_spec.
    Returns True if output is the list with the smaller total character count 
    (or lst1 if counts are equal), False otherwise.
    """
    c1 = sum((len(s) for s in lst1))
    c2 = sum((len(s) for s in lst2))
    cond1 = c1 <= c2 and output == lst1
    cond2 = c1 > c2 and output == lst2
    return cond1 or cond2

def total_match_spec(lst1, lst2, output):
    return bool(_orig_total_match_spec(lst1, lst2, output))
