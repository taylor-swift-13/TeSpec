
def encode_shift(s: str):
    """returns encoded string by shifting every character by 5 in the alphabet."""
    return "".join([chr((ord(ch) - ord("a") - 5 + 26) % 26 + ord("a")) for ch in s])
