
def pairs_sum_to_zero(l):
    """pairs_sum_to_zero takes a list of integers as an input.
    it returns True if there are two distinct elements in the list that
    sum to zero, and False otherwise.
    False
    False
    False
    True
    False"""
    for i in range(len(l)):
        for j in range(len(l)):
            if i != j and l[i] + l[j] == 0:
                return True
    return False
