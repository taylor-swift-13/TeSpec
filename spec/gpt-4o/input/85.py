def _orig_add_spec(lst, s):
    """
    Implements the logic of the Coq definition add_spec:
    s = fold_left Nat.add (filter (fun x => Nat.even x) (map (fun i => nth i lst 0) (seq 1 (length lst / 2)))) 0
    """
    limit = len(lst) // 2
    total = 0
    for i in range(1, limit + 1):
        if 0 <= i < len(lst):
            val = lst[i]
        else:
            val = 0
        if val % 2 == 0:
            total += val
    return s == total

def add_spec(lst, output):
    return bool(_orig_add_spec(lst, output))
