def _orig_choose_num_spec(x: int, y: int, output: int) -> bool:
    """
    Executable Python implementation of the Coq choose_num_spec.
    Returns True if the given (x, y, output) satisfies the specification.
    """
    term_a = x > y and output == -1
    term_b_inner = y % 2 == 0 and output == y or (y % 2 != 0 and output == -1)
    term_b = x == y and term_b_inner
    term_c_inner = y % 2 == 0 and output == y or (y % 2 != 0 and output == y - 1)
    term_c = x < y and term_c_inner
    term_d = output == -1 or (x <= output and output <= y and (output % 2 == 0))
    return term_a or term_b or (term_c and term_d)

def choose_num_spec(x, y, output):
    return bool(_orig_choose_num_spec(x, y, output))
