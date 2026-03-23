def maximum_spec(arr, k, res):
    """
    Implements the logic for maximum_spec:
    maximum_spec (arr : list Z) (k : Z) (res : list Z) : Prop :=
      Sorted Z.le res /\
      Z.of_nat (length res) = k /\
      exists (others : list Z),
        Permutation arr (res ++ others) /\
        (forall x y, In x res -> In y others -> x >= y).
    
    This specification asserts that 'res' is a sorted list containing the 'k' largest
    elements from 'arr'.
    """
    # Check if k is a valid integer for length (must be non-negative)
    if not isinstance(k, int) or k < 0:
        return False

    # Check condition: Z.of_nat (length res) = k
    if len(res) != k:
        return False

    # Check if k is within the bounds of arr.
    # Permutation arr (res ++ others) implies length arr = length res + length others.
    # Since length others >= 0, length res <= length arr.
    if k > len(arr):
        return False

    # The specification requires res to be:
    # 1. Sorted in ascending order (Sorted Z.le res)
    # 2. A permutation of a subset of arr (Permutation arr (res ++ others))
    # 3. Consisting of elements greater than or equal to the remaining elements (dominance condition)
    #
    # These conditions uniquely determine res as the list of the k largest elements of arr,
    # sorted in ascending order.
    
    # Construct the expected result
    sorted_arr = sorted(arr)
    
    # Take the last k elements from the sorted array
    # If k == 0, len(arr) - k == len(arr), so the slice is empty [], which is correct.
    expected = sorted_arr[len(arr) - k :]
    
    return res == expected

def _impl(arr, k):
    return sorted(sorted(arr)[::-1][:k])

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(maximum_spec(*input, output))

def maximum(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
