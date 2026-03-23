from typing import List

def concatenate_spec(strings: List[str], result: str) -> bool:
    """
    Checks if the result string is the concatenation of the list of strings.
    Equivalent to Coq's String.concat "" strings.
    """
    return result == "".join(strings)
