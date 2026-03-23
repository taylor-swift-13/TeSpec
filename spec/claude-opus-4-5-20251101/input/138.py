def _orig_is_equal_to_sum_even_spec(n: int, output: bool) -> bool:
    """
    Implementation of the Coq specification:
    output = true <-> (n >= 8 /\\ Z.even n = true /\\ 
      exists a b c d : Z, a > 0 /\\ b > 0 /\\ c > 0 /\\ d > 0 /                          Z.even a = true /\\ Z.even b = true /\\ 
                          Z.even c = true /\\ Z.even d = true /                          n = a + b + c + d)
    """
    condition = n >= 8 and n % 2 == 0
    return output == condition

def is_equal_to_sum_even_spec(n, output):
    return bool(_orig_is_equal_to_sum_even_spec(n, output))
