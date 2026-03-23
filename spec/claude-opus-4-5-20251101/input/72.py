def sum_list(l):
    """
    Calculates the sum of elements in a list of integers.
    """
    s = 0
    for x in l:
        s += x
    return s

def is_palindrome(l):
    """
    Checks if a list is a palindrome (equal to its reverse).
    """
    return l == l[::-1]

def _orig_will_it_fly_spec(q, w, output):
    """
    Specification for will_it_fly.
    Returns True if the boolean 'output' correctly reflects whether 
    the list 'q' is a palindrome and its sum is less than or equal to 'w'.
    """
    condition = is_palindrome(q) and sum_list(q) <= w
    return output == condition

def will_it_fly_spec(q, w, output):
    return bool(_orig_will_it_fly_spec(q, w, output))
