def problem_83_pre(n: int) -> bool:
    """
    Checks the precondition for problem 83: n must be a positive integer.
    """
    return n > 0

def problem_83_spec(n: int, count: int) -> bool:
    """
    Checks if the given count is the number of n-digit positive integers 
    that start or end with 1, according to the Coq specification.
    """
    # The Coq spec is an implication: n > 0 -> ( (n = 1 /\ count = 1) \/ (n > 1 /\ count = 18 * 10^(n-2)) )
    if not (n > 0):
        # If the precondition n > 0 is false, the implication is vacuously true.
        return True
    
    # If n > 0, we check the two possible cases for n.
    if n == 1:
        # For n = 1, the only 1-digit number starting or ending with 1 is '1'.
        return count == 1
    elif n > 1:
        # For n > 1, the count is given by the formula 18 * 10^(n-2).
        # This formula accounts for numbers starting with 1, ending with 1, 
        # and subtracts the intersection (starting and ending with 1).
        return count == 18 * (10 ** (n - 2))
    
    # This part is unreachable for natural numbers n > 0.
    return False
