from itertools import combinations

def triples_sum_to_zero_spec(l, res):
    """
    Implements the logic for triples_sum_to_zero_spec.
    
    The Coq spec states:
      res = true <-> exists distinct indices i, j, k such that l[i] + l[j] + l[k] = 0
      res = false <-> forall distinct indices i, j, k, l[i] + l[j] + l[k] <> 0
      
    This Python function returns True if 'res' matches the actual existence of such a triple in 'l',
    and False otherwise.
    """
    def has_zero_sum_triple(lst):
        # itertools.combinations returns subsequences of length 3 based on position,
        # which ensures we are looking at distinct indices (i != j != k).
        for triple in combinations(lst, 3):
            if sum(triple) == 0:
                return True
        return False

    actual_res = has_zero_sum_triple(l)
    return res == actual_res
