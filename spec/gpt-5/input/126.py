from collections import Counter

def is_sorted_spec(lst, res):
    # Check if the list is sorted in non-decreasing order (Sorted le lst)
    is_sorted = all(lst[i] <= lst[i+1] for i in range(len(lst) - 1))
    
    # Check if every element appears at most 2 times
    # (forall x : nat, le (count_occ Nat.eq_dec lst x) 2)
    # We only need to check elements present in the list, as count is 0 for others.
    counts = Counter(lst)
    counts_ok = all(count <= 2 for count in counts.values())
    
    # The spec states: res = true <-> (is_sorted /\ counts_ok)
    return res == (is_sorted and counts_ok)
