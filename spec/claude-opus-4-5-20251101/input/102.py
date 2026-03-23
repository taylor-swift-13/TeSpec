def choose_num_spec(x: int, y: int, result: int) -> bool:
    """
    Python implementation of the Coq specification choose_num_spec.
    Returns True if the given result satisfies the specification for inputs x and y.
    """
    
    # Condition 1: (x > y -> result = -1)
    if x > y:
        if result != -1:
            return False
            
    # Condition 2: (x <= y -> ...)
    if x <= y:
        # Check if there exists an even integer k such that x <= k <= y
        # Smallest even integer k >= x
        first_even = x if x % 2 == 0 else x + 1
        exists_k = (first_even <= y)
        
        # Subcondition 2a: (exists k, x <= k <= y /\ k mod 2 = 0) ->
        # (result mod 2 = 0 /\ x <= result <= y /\ (forall k, x <= k <= y -> k mod 2 = 0 -> k <= result))
        if exists_k:
            # Largest even integer k <= y
            max_even = y if y % 2 == 0 else y - 1
            
            # result must be even
            cond_even = (result % 2 == 0)
            # result must be in the range [x, y]
            cond_range = (x <= result <= y)
            # result must be greater than or equal to all even integers in the range [x, y]
            # This is equivalent to result being greater than or equal to the maximum even integer in the range.
            cond_max = (result >= max_even)
            
            if not (cond_even and cond_range and cond_max):
                return False
                
        # Subcondition 2b: (~exists k, x <= k <= y /\ k mod 2 = 0) -> result = -1
        else:
            if result != -1:
                return False
                
    # If all applicable conditions are satisfied, return True
    return True
