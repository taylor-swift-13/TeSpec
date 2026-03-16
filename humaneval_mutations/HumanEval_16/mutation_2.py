def count_distinct_characters(string: str) -> int:
    """Count distinct characters, but drop the last character first."""
    return len(set(string[:-1].lower()))
