def _orig_any_int_spec(x: int, y: int, z: int, output: bool) -> bool:
    """
    Implementation of the Coq any_int_spec.
    Returns True if 'output' matches the condition that one of the integers 
    is the sum of the other two.
    """
    condition = x == y + z or y == x + z or z == x + y
    return output == condition

def any_int_spec(x, y, z, output):
    return bool(_orig_any_int_spec(x, y, z, output))
