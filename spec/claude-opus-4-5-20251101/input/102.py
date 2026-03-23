def _orig_choose_num_spec(x: int, y: int, output: int) -> bool:
    """
    Python implementation of the Coq specification choose_num_spec.
    Returns True if the given output satisfies the specification for inputs x and y.
    """
    if x > y:
        if output != -1:
            return False
    if x <= y:
        first_even = x if x % 2 == 0 else x + 1
        exists_k = first_even <= y
        if exists_k:
            max_even = y if y % 2 == 0 else y - 1
            cond_even = output % 2 == 0
            cond_range = x <= output <= y
            cond_max = output >= max_even
            if not (cond_even and cond_range and cond_max):
                return False
        elif output != -1:
            return False
    return True

def choose_num_spec(x, y, output):
    return bool(_orig_choose_num_spec(x, y, output))
