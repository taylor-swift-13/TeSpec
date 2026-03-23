def rev_string(s: str) -> str:
    return s[::-1]

def is_palindrome_spec(text: str, result: bool) -> bool:
    is_pal = (text == rev_string(text))
    return result == is_pal
