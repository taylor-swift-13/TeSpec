def strlen_spec(s: str, result: int) -> bool:
    """
    Returns True if the provided result matches the length of the string s.
    This corresponds to the Coq specification: result = String.length s.
    """
    return result == len(s)
