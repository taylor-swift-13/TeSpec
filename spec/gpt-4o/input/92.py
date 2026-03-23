def any_int_spec(x: int, y: int, z: int, result: bool) -> bool:
    """
    Implementation of the Coq any_int_spec.
    Returns True if 'result' matches the condition that one of the integers 
    is the sum of the other two.
    """
    # Calculate the boolean expression: (x == y + z) || (y == x + z) || (z == x + y)
    condition = (x == y + z) or (y == x + z) or (z == x + y)
    
    # The Coq spec is result = (condition), which in Python is result == condition
    return result == condition
