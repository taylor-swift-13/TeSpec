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

def make_palindrome_spec(s, t):
    if not palindrome(t):
        return False
    if not begins_with(s, t):
        return False
    
    cond4 = False
    for i in range(len(s) + 1):
        v = s[:i]
        w = s[i:]
        if palindrome(w) and t == s + strrev(v):
            all_v_w = True
            for j in range(len(s) + 1):
                v_prime = s[:j]
                w_prime = s[j:]
                if palindrome(w_prime):
                    if not (strlen(v) <= strlen(v_prime)):
                        all_v_w = False
                        break
            if all_v_w:
                cond4 = True
                break
                
    return cond4
