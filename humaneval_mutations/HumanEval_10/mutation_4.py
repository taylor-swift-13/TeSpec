def is_palindrome(string: str) -> bool:
    return string == string[::-1]


def make_palindrome(string: str) -> str:
    """Find a palindrome that begins with the supplied string."""
    if not string:
        return ""
    beginning_of_suffix = 0
    while beginning_of_suffix < len(string) and not is_palindrome(string[beginning_of_suffix:]):
        beginning_of_suffix += 1
    return string + string[: beginning_of_suffix + 1][::-1]
