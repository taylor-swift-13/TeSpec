def choose_num_spec(x: int, y: int, res: int) -> bool:
    """
    Executable Python implementation of the Coq choose_num_spec.
    Returns True if the given (x, y, res) satisfies the specification.
    """
    
    # Term A: (x > y /\ res = -1)
    term_a = (x > y and res == -1)
    
    # Term B: (x = y /\ ((Z.even y = true /\ res = y) \/ (Z.even y = false /\ res = -1)))
    # In Python, n % 2 == 0 is equivalent to Z.even n = true for all integers.
    term_b_inner = (y % 2 == 0 and res == y) or (y % 2 != 0 and res == -1)
    term_b = (x == y and term_b_inner)
    
    # Term C: (x < y /\ ((Z.even y = true /\ res = y) \/ (Z.even y = false /\ res = y - 1)))
    term_c_inner = (y % 2 == 0 and res == y) or (y % 2 != 0 and res == y - 1)
    term_c = (x < y and term_c_inner)
    
    # Term D: (res = -1 \/ (x <= res /\ res <= y /\ Z.even res = true))
    term_d = (res == -1 or (x <= res and res <= y and res % 2 == 0))
    
    # The Coq specification structure is: A \/ B \/ (C /\ D)
    # Precedence: /\ (level 80) binds tighter than \/ (level 85).
    return term_a or term_b or (term_c and term_d)
