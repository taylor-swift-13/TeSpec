import hashlib

from typing import Optional

def md5_hash(text: str) -> str:
    """
    Returns the MD5 hash of the input string as a hex string.
    This corresponds to the Parameter md5_hash in the Coq specification.
    """
    return hashlib.md5(text.encode('utf-8')).hexdigest()

def string_to_md5(text: str) -> Optional[str]:
    """
    Given a string 'text', return its md5 hash equivalent string.
    If 'text' is an empty string, return None.

    >>> string_to_md5('Hello world') == '3e25960a79dbc69b674cd4ec67a72c62'
    """
    if text == "":
        return None
    return md5_hash(text)

def _orig_problem_162_pre(text: str) -> bool:
    """
    Precondition for problem_162.
    """
    return True

def _orig_problem_162_spec(text: str, output: Optional[str]) -> bool:
    """
    Specification for problem_162.
    Defines the relationship between input 'text' and output 'output'.
    """
    if text == '':
        return output is None
    else:
        return output == md5_hash(text)

def problem_162_pre(text):
    return bool(_orig_problem_162_pre(text))

def problem_162_spec(text, output):
    return bool(_orig_problem_162_spec(text, output))
