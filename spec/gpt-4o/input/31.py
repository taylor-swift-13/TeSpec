def is_prime_spec(n, result):
    """
    Executable Python implementation of the Coq is_prime_spec.
    
    The Coq spec is defined as:
    Definition is_prime_spec (n : nat) (result : bool) : Prop :=
      (n <= 1 -> result = false) /\
      (n > 1 ->
       (exists i, 2 <= i < n /\ n mod i = 0 -> result = false) /\
       (forall i, 2 <= i < n -> n mod i <> 0 -> result = true)).
    """
    
    # (n <= 1 -> result = false)
    # In logic, A -> B is equivalent to (not A) or B.
    # For concrete inputs, if n <= 1, then result must be False.
    if n <= 1:
        if result != False:
            return False
            
    # (n > 1 -> ...)
    if n > 1:
        # Part 1: (exists i, 2 <= i < n /\ n mod i = 0 -> result = false)
        # In Coq, the precedence of /\ is higher than ->, so this is:
        # exists i, (2 <= i < n /\ n mod i = 0) -> result = false.
        # This condition is always True for any n > 1 because we can pick a witness i
        # that is outside the range [2, n-1] (e.g., i = 0 or i = n).
        # For such an i, the antecedent (2 <= i < n /\ n mod i = 0) is False,
        # making the implication True.
        exists_cond = True
        
        # Part 2: (forall i, 2 <= i < n -> n mod i <> 0 -> result = true)
        # This is equivalent to: forall i, (2 <= i < n -> (n mod i <> 0 -> result = true)).
        # For i outside [2, n-1], the implication is vacuously True.
        # For i inside [2, n-1], we must check (n mod i <> 0 -> result = true).
        forall_cond = True
        for i in range(2, n):
            # Implication: (n % i != 0) -> (result == True)
            if n % i != 0:
                if result != True:
                    forall_cond = False
                    break
        
        # The conjunction of Part 1 and Part 2 must be True.
        if not (exists_cond and forall_cond):
            return False
            
    # If all implications in the spec are satisfied, return True.
    return True
