def string_rev(s):
    return s[::-1]

def is_palindrome_spec(text, result):
    return result == (text == string_rev(text))
