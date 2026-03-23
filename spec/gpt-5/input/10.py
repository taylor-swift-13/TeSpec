def strlen(s):
    return len(s)

def strrev(s):
    return s[::-1]

def palindrome(s):
    return s == strrev(s)

def begins_with(pref, s):
    return s.startswith(pref)

def is_palindrome_spec(s, b):
    return b == palindrome(s)

def _orig_make_palindrome_spec(s, t):
    n = len(s)
    split_idx = n
    for i in range(n + 1):
        if palindrome(s[i:]):
            split_idx = i
            break
    v = s[:split_idx]
    expected_t = s + strrev(v)
    return t == expected_t

def make_palindrome_spec(string, output):
    return bool(_orig_make_palindrome_spec(string, output))
