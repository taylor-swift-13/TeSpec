def count_occurrences(n: int, l: list) -> int:
    """
    Counts the number of occurrences of n in list l.
    Equivalent to Coq's count_occurrences.
    """
    return len([x for x in l if x == n])

def occurs_once(n: int, l: list) -> bool:
    """
    Returns True if n occurs exactly once in list l.
    Equivalent to Coq's occurs_once Prop.
    """
    return count_occurrences(n, l) == 1

def _orig_remove_duplicates_spec(numbers: list, output: list) -> bool:
    """
    Checks if output is equal to the list of elements from numbers that appear exactly once.
    Equivalent to Coq's remove_duplicates_spec.
    Note: Despite the name 'remove_duplicates', the Coq spec specifically filters 
    for elements that have a count of exactly 1.
    """
    expected = [n for n in numbers if count_occurrences(n, numbers) == 1]
    return output == expected

def remove_duplicates_spec(numbers, output):
    return bool(_orig_remove_duplicates_spec(numbers, output))
