def total_chars(l):
    """
    Definition total_chars (l : list string) : nat :=
      fold_right (fun s acc => String.length s + acc) 0 l.
    """
    return sum(len(s) for s in l)

def _orig_total_match_spec(lst1, lst2, output):
    """
    Definition total_match_spec (lst1 lst2 output : list string) : Prop :=
      (total_chars lst1 <= total_chars lst2 /\\ output = lst1) \\/
      (total_chars lst2 < total_chars lst1 /\\ output = lst2).
    """
    tc1 = total_chars(lst1)
    tc2 = total_chars(lst2)
    return tc1 <= tc2 and output == lst1 or (tc2 < tc1 and output == lst2)

def total_match_spec(lst1, lst2, output):
    return bool(_orig_total_match_spec(lst1, lst2, output))
