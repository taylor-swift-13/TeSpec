def nat_to_string(n):
    """
    Converts a natural number (0-9) to its string representation.
    Returns '?' for numbers greater than 9 as per the Coq spec.
    """
    if n == 0:
        return "0"
    elif n == 1:
        return "1"
    elif n == 2:
        return "2"
    elif n == 3:
        return "3"
    elif n == 4:
        return "4"
    elif n == 5:
        return "5"
    elif n == 6:
        return "6"
    elif n == 7:
        return "7"
    elif n == 8:
        return "8"
    elif n == 9:
        return "9"
    else:
        return "?"

def range_coq(n):
    """
    Equivalent to the Coq Fixpoint range (n : nat) : list nat.
    Returns a list [0, 1, ..., n-1].
    """
    res = []
    for i in range(n):
        res.append(i)
    return res

def range_inclusive(n):
    """
    Equivalent to the Coq Definition range_inclusive (n : nat) : list nat.
    Returns a list [0, 1, ..., n].
    """
    return range_coq(n + 1)

def join_with_space(l):
    """
    Equivalent to the Coq Fixpoint join_with_space (l : list string) : string.
    Joins a list of strings with a single space.
    """
    if not l:
        return ""
    return " ".join(l)

def string_sequence_spec(n, result):
    """
    Equivalent to the Coq Definition string_sequence_spec.
    Checks if the result matches the space-separated string of numbers from 0 to n.
    """
    # map nat_to_string (range_inclusive n)
    mapped_list = [nat_to_string(x) for x in range_inclusive(n)]
    # join_with_space (...)
    expected_result = join_with_space(mapped_list)
    # result = ...
    return result == expected_result
