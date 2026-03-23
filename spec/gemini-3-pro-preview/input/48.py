def string_rev(s):
    return s[::-1]

def _orig_is_palindrome_spec(text, output):
    return output == (text == string_rev(text))

def is_palindrome_spec(text, output):
    return bool(_orig_is_palindrome_spec(text, output))
