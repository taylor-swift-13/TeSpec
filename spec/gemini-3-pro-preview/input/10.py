def is_palindrome(l):
    return l == l[::-1]

def make_palindrome_spec(s, res):
    for i in range(len(s) + 1):
        p = s[:i]
        q = s[i:]
        if is_palindrome(q):
            return res == s + p[::-1]
    return False
