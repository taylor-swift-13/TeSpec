def eat_spec(number, need, remaining, result):
    """
    Python implementation of the Coq eat_spec.
    Returns True if the inputs satisfy the specification, False otherwise.
    """
    # Check the range constraints: 0 <= x <= 1000
    # In Coq, nat is non-negative by definition, but we check 0 <= x for completeness.
    range_check = (0 <= number <= 1000 and 
                   0 <= need <= 1000 and 
                   0 <= remaining <= 1000)
    
    if not range_check:
        return False

    # Nat.leb need remaining is equivalent to need <= remaining
    if need <= remaining:
        expected_result = [number + need, remaining - need]
    else:
        expected_result = [number + remaining, 0]

    # Check if the provided result matches the expected result
    return result == expected_result
