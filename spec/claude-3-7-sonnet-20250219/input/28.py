from typing import List

def _orig_concatenate_spec(strings: List[str], output: str) -> bool:
    """
    Checks if the output string is the concatenation of the list of strings.
    Equivalent to Coq's String.concat "" strings.
    """
    return output == ''.join(strings)

def concatenate_spec(strings, output):
    return bool(_orig_concatenate_spec(strings, output))
