
def string_sequence(n: int) -> str:
    """Return a string containing space-delimited numbers starting from 0 upto n inclusive.
    '0'
    '0 1 2 3 4 5'"""
    return " ".join(map(str, range(n + 1)))
