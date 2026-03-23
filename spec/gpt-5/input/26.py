def _orig_remove_duplicates_spec(numbers, output):
    """
    Implements the logic for:
    Definition remove_duplicates_spec (numbers : list Z) (output : list Z) : Prop :=
      output = filter (fun x => Nat.eqb (count_occ Z.eq_dec numbers x) 1) numbers.
      
    This specification asserts that 'output' is equal to the list 'numbers' filtered
    to keep only those elements that occur exactly once.
    """
    expected = [x for x in numbers if numbers.count(x) == 1]
    return output == expected

def remove_duplicates_spec(numbers, output):
    return bool(_orig_remove_duplicates_spec(numbers, output))
