def _orig_eat_spec(number, need, remaining, output):
    """
    Python implementation of the Coq eat_spec.
    Returns True if the inputs satisfy the specification, False otherwise.
    """
    range_check = 0 <= number <= 1000 and 0 <= need <= 1000 and (0 <= remaining <= 1000)
    if not range_check:
        return False
    if need <= remaining:
        expected_result = [number + need, remaining - need]
    else:
        expected_result = [number + remaining, 0]
    return output == expected_result

def eat_spec(number, need, remaining, output):
    return bool(_orig_eat_spec(number, need, remaining, output))
