def choose_num_spec(x: int, y: int, result: int) -> bool:
    """
    Implementation of the Coq specification:
    Definition choose_num_spec (x y result : Z) : Prop :=
      (result = -1 <-> (forall n : Z, x <= n <= y -> Z.Odd n)) /\
      (result <> -1 -> 
         Z.Even result /\ 
         x <= result <= y /\ 
         (forall n : Z, x <= n <= y -> Z.Even n -> n <= result)).
    """
    
    # Helper to check if a number is even or odd
    def is_even(n: int) -> bool:
        return n % 2 == 0

    def is_odd(n: int) -> bool:
        return n % 2 != 0

    # The range of integers [x, y]
    # If x > y, the range is empty.
    integers_in_range = range(x, y + 1)
    
    # Condition: forall n : Z, x <= n <= y -> Z.Odd n
    # This is true if there are no even numbers in the range.
    all_odd = all(is_odd(n) for n in integers_in_range)
    
    # Part 1: (result = -1 <-> (forall n : Z, x <= n <= y -> Z.Odd n))
    if (result == -1) != all_odd:
        return False
        
    # Part 2: (result <> -1 -> ...)
    if result != -1:
        # Z.Even result
        if not is_even(result):
            return False
        
        # x <= result <= y
        if not (x <= result <= y):
            return False
            
        # (forall n : Z, x <= n <= y -> Z.Even n -> n <= result)
        # This means result must be the maximum even number in the range.
        for n in integers_in_range:
            if is_even(n):
                if n > result:
                    return False
                    
    return True
