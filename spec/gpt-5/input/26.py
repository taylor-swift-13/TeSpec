def remove_duplicates_spec(numbers, result):
    """
    Implements the logic for:
    Definition remove_duplicates_spec (numbers : list Z) (result : list Z) : Prop :=
      result = filter (fun x => Nat.eqb (count_occ Z.eq_dec numbers x) 1) numbers.
      
    This specification asserts that 'result' is equal to the list 'numbers' filtered
    to keep only those elements that occur exactly once.
    """
    # In Python, list comprehensions preserve order, similar to Coq's filter.
    # numbers.count(x) corresponds to count_occ.
    expected = [x for x in numbers if numbers.count(x) == 1]
    return result == expected
