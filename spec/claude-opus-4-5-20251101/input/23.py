def _orig_strlen_spec(s: str, output: int) -> bool:
    """
    Returns True if the provided output matches the length of the string s.
    This corresponds to the Coq specification: output = String.length s.
    """
    return output == len(s)

def strlen_spec(string, output):
    return bool(_orig_strlen_spec(string, output))
