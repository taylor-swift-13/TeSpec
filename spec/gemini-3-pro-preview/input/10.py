def is_palindrome(l):
    return l == l[::-1]

def _orig_make_palindrome_spec(s, output):
    for i in range(len(s) + 1):
        p = s[:i]
        q = s[i:]
        if is_palindrome(q):
            expected_res = s + p[::-1]
            return output == expected_res
    return False

def make_palindrome_spec(string, output):
    return bool(_orig_make_palindrome_spec(string, output))
