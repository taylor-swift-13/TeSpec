def concatenate(strings):
    """
    Concatenates a list of strings into a single string.
    Equivalent to the Coq Fixpoint concatenate.
    """
    output = ""
    for s in strings:
        output += s
    return output

def _orig_concatenate_spec(strings, output):
    """
    Returns True if the output is equal to the concatenation of the strings.
    Equivalent to the Coq Definition concatenate_spec.
    """
    return output == concatenate(strings)

def concatenate_spec(strings, output):
    return bool(_orig_concatenate_spec(strings, output))
