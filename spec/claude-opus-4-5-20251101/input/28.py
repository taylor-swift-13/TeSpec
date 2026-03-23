def concatenate(strings):
    """
    Concatenates a list of strings into a single string.
    Equivalent to the Coq Fixpoint concatenate.
    """
    result = ""
    for s in strings:
        result += s
    return result

def concatenate_spec(strings, result):
    """
    Returns True if the result is equal to the concatenation of the strings.
    Equivalent to the Coq Definition concatenate_spec.
    """
    return result == concatenate(strings)
