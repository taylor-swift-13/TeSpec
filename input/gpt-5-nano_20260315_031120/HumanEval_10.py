
def is_palindrome(string: str) -> bool:
    """Test if given string is a palindrome"""
    if is_palindrome(string):
        return string
    for i in range(len(string)):
        if is_palindrome(string[i:]):
            return string + string[i-1::-1]
