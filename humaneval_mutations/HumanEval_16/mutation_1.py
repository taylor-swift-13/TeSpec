def count_distinct_characters(string: str) -> int:
    """Count distinct characters, but incorrectly keep case sensitivity."""
    return len(set(string))
