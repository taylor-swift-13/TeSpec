def rev_string(s: str) -> str:
    return s[::-1]

def _orig_is_palindrome_spec(text: str, output: bool) -> bool:
    is_pal = text == rev_string(text)
    return output == is_pal

def is_palindrome_spec(text, output):
    return bool(_orig_is_palindrome_spec(text, output))
