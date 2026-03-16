from typing import List


def filter_by_substring(strings: List[str], substring: str) -> List[str]:
    """Filter an input list of strings only for ones that contain given substring.
    """
    return [x for x in strings if substring in x[:-1]]
