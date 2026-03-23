def add_spec(lst, s):
    """
    Implements the logic of the Coq definition add_spec:
    s = fold_left Nat.add (filter (fun x => Nat.even x) (map (fun i => nth i lst 0) (seq 1 (length lst / 2)))) 0
    """
    # Calculate the upper bound for the sequence: length lst / 2
    # In Python integer division is //
    limit = len(lst) // 2
    
    # The fold_left starts with an accumulator of 0
    total = 0
    
    # seq 1 limit generates indices: 1, 2, ..., limit
    # In Python, range(1, limit + 1) generates 1, 2, ..., limit
    for i in range(1, limit + 1):
        # map (fun i => nth i lst 0)
        # nth i lst 0 returns the element at index i, or 0 if out of bounds.
        # Note: Coq lists are 0-indexed.
        if 0 <= i < len(lst):
            val = lst[i]
        else:
            val = 0
            
        # filter (fun x => Nat.even x)
        # Check if the value is even
        if val % 2 == 0:
            # fold_left Nat.add ...
            # Accumulate the sum
            total += val
            
    # The spec asserts that s equals the computed sum
    return s == total
