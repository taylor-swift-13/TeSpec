from collections import Counter

def count_set_bits_pos(p):
    """
    Fixpoint count_set_bits_pos (p : positive) : nat :=
      match p with
      | xH => 1%nat
      | xO p' => count_set_bits_pos p'
      | xI p' => S (count_set_bits_pos p')
      end.
    """
    # In Coq, 'positive' corresponds to strictly positive integers.
    # The recursive definition counts the number of set bits (1s) in the binary representation.
    return bin(p).count('1')

def count_set_bits(z):
    """
    Definition count_set_bits (z : Z) : nat :=
      match z with
      | Z0 => 0%nat
      | Zpos p => count_set_bits_pos p
      | Zneg p => count_set_bits_pos p
      end.
    """
    # Zneg p represents the negative integer -p. The Coq definition applies 
    # count_set_bits_pos to p, effectively counting bits of the absolute value.
    return bin(abs(z)).count('1')

def sort_criteria(x, y):
    """
    Definition sort_criteria (x y : Z) : Prop :=
      let cx := count_set_bits x in
      let cy := count_set_bits y in
      (cx < cy)%nat \/ (cx = cy /\ x <= y).
    """
    cx = count_set_bits(x)
    cy = count_set_bits(y)
    return (cx < cy) or (cx == cy and x <= y)

def sort_array_spec(arr, res):
    """
    Definition sort_array_spec (arr : list Z) (res : list Z) : Prop :=
      Permutation arr res /\ StronglySorted sort_criteria res.
    """
    # Check Permutation: arr and res must contain the same elements with the same multiplicities.
    if Counter(arr) != Counter(res):
        return False
    
    # Check StronglySorted: res must be sorted according to sort_criteria.
    # Since sort_criteria is a transitive relation (lexicographical order),
    # checking adjacent elements is sufficient to ensure the list is StronglySorted.
    for i in range(len(res) - 1):
        if not sort_criteria(res[i], res[i+1]):
            return False
            
    return True

def _impl(arr):
    from functools import cmp_to_key
    def cmp(x: int, y: int) -> int:
        x1 = len(list(filter(lambda ch: ch == "1", bin(x))))
        y1 = len(list(filter(lambda ch: ch == "1", bin(y))))
        if x1 != y1: return x1 - y1
        return x - y
    return sorted(arr, key=cmp_to_key(cmp))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(sort_array_spec(*input, output))

def sort_array(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
