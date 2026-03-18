
def is_palindrome(text: str):
    """
    Checks if given string is a palindrome
    True
    True
    True
    False
    """
    return text == text[::-1]
