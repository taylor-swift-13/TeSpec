def max_list(l, default):
    """
    Fixpoint max_list (l : list Z) (default : Z) : Z :=
      match l with
      | [] => default
      | x :: xs => Z.max x (max_list xs x)
      end.
    """
    if not l:
        return default
    
    # The Coq function computes the maximum of the list elements.
    # If the list is non-empty, the initial 'default' is effectively ignored
    # because the recursion uses the head of the list as the new default.
    current_max = l[0]
    for x in l:
        if x > current_max:
            current_max = x
    return current_max

def firstn(n, l):
    """
    Fixpoint firstn {A : Type} (n : nat) (l : list A) : list A
    """
    return l[:n]

def rolling_max_aux(numbers, idx):
    """
    Fixpoint rolling_max_aux (numbers : list Z) (idx : nat) : list Z
    """
    res = []
    # Coq: match idx with O => [] | S n => rolling_max_aux ... ++ [ ... ]
    # This builds the list recursively from 0 to idx-1.
    # In Python, we iterate from 1 to idx to build the list in the same order.
    for i in range(1, idx + 1):
        # max_list (firstn idx numbers) 0
        # Note: in the loop, 'i' corresponds to the current 'idx' in the recursive step
        val = max_list(firstn(i, numbers), 0)
        res.append(val)
    return res

def rolling_max(numbers):
    """
    Definition rolling_max (numbers : list Z) : list Z :=
      rolling_max_aux numbers (length numbers).
    """
    return rolling_max_aux(numbers, len(numbers))

def rolling_max_spec(numbers, result):
    """
    Definition rolling_max_spec (numbers : list Z) (result : list Z) : Prop
    """
    if len(result) != len(numbers):
        return False
    
    for i in range(len(numbers)):
        # nth i result 0
        # Since we checked lengths, result[i] is valid.
        val_at_i = result[i]
        
        # max_list (firstn (S i) numbers) 0
        # S i is i+1
        expected = max_list(firstn(i + 1, numbers), 0)
        
        if val_at_i != expected:
            return False
            
    return True
