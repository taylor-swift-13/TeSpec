def nth_char(n, s):
    if n < 0 or n >= len(s):
        return None
    return s[n]

def is_vowel(c):
    if c is None:
        return False
    return c in "aeiouAEIOU"

def between_consonants(w, i, ch):
    if nth_char(i, w) != ch:
        return False
    if not is_vowel(ch):
        return False
    
    # In Coq, Nat.pred 0 is 0.
    pred_i = i - 1 if i > 0 else 0
    a = nth_char(pred_i, w)
    if a is None or is_vowel(a):
        return False
        
    c_next = nth_char(i + 1, w)
    if c_next is None or is_vowel(c_next):
        return False
        
    return True

def get_closest_vowel_spec(word, res):
    best_i = -1
    best_ch = None
    
    # Find the largest index `i` that satisfies `between_consonants`
    for i in range(len(word)):
        ch = word[i]
        if between_consonants(word, i, ch):
            best_i = i
            best_ch = ch
            
    if best_i != -1:
        return res == best_ch
    else:
        return res == ""

def _impl(word):
    def is_vowel(ch: str) -> bool:
        return ch in "aeiouAEIOU"
    for i in range(len(word) - 2, 0, -1):
        if is_vowel(word[i]) and not is_vowel(word[i-1]) and not is_vowel(word[i+1]):
            return word[i]
    return ""

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(get_closest_vowel_spec(*input, output))

def get_closest_vowel(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
