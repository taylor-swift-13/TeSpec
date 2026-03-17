from typing import List

def filter_by_substring(strings: List[str], substring: str) -> List[str]:
    """Filter an input list of strings only for ones that contain given substring
    []
    ['abc', 'bacd', 'array']"""
    return list(filter(lambda s: substring in s, strings))
