from itertools import combinations

def _orig_triples_sum_to_zero_spec(l, output):
    """
    Implements the logic for triples_sum_to_zero_spec.
    
    The Coq spec states:
      output = true <-> exists distinct indices i, j, k such that l[i] + l[j] + l[k] = 0
      output = false <-> forall distinct indices i, j, k, l[i] + l[j] + l[k] <> 0
      
    This Python function returns True if 'output' matches the actual existence of such a triple in 'l',
    and False otherwise.
    """

    def has_zero_sum_triple(lst):
        for triple in combinations(lst, 3):
            if sum(triple) == 0:
                return True
        return False
    actual_res = has_zero_sum_triple(l)
    return output == actual_res

def triples_sum_to_zero_spec(l, output):
    return bool(_orig_triples_sum_to_zero_spec(l, output))
