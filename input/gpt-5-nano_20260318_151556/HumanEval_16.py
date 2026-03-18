
def count_distinct_characters(string: str) -> int:
    """
    Given a string, find out how many distinct characters (regardless of case) does it consist of
    3
    4
    """
    return len(set(string.lower()))
