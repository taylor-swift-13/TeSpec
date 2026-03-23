def _orig_maximum_spec(arr, k, output):
    """
    Implements the logic for maximum_spec:
    maximum_spec (arr : list Z) (k : Z) (output : list Z) : Prop :=
      Sorted Z.le output /      Z.of_nat (length output) = k /      exists (others : list Z),
        Permutation arr (output ++ others) /        (forall x y, In x output -> In y others -> x >= y).
    
    This specification asserts that 'output' is a sorted list containing the 'k' largest
    elements from 'arr'.
    """
    if not isinstance(k, int) or k < 0:
        return False
    if len(output) != k:
        return False
    if k > len(arr):
        return False
    sorted_arr = sorted(arr)
    expected = sorted_arr[len(arr) - k:]
    return output == expected

def maximum_spec(arr, k, output):
    return bool(_orig_maximum_spec(arr, k, output))
