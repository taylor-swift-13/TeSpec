def char_string(c: str) -> str:
    return c

def sep_char(c: str) -> bool:
    return c == " " or c == ","

def not_sep_char(c: str) -> bool:
    return not sep_char(c)

def all_chars(P, s: str) -> bool:
    for c in s:
        if not P(c):
            return False
    return True

def only_seps(s: str) -> bool:
    return all_chars(sep_char, s)

def word(s: str) -> bool:
    return len(s) > 0 and all_chars(not_sep_char, s)

def components(comps: list, words: list) -> bool:
    curr_comps = comps
    curr_words = words
    while True:
        if len(curr_comps) == 1 and len(curr_words) == 0:
            return only_seps(curr_comps[0])
        if len(curr_comps) >= 2 and len(curr_words) >= 1:
            sep = curr_comps[0]
            w = curr_comps[1]
            if not only_seps(sep): return False
            if not word(w): return False
            if curr_words[0] != w: return False
            curr_comps = curr_comps[2:]
            curr_words = curr_words[1:]
            continue
        return False

def concat(xs: list) -> str:
    return "".join(xs)

def words_string_spec(s: str, out: list) -> bool:
    for w in out:
        if not word(w):
            return False
            
    comps = []
    current_s = s
    
    for w in out:
        sep_len = 0
        while sep_len < len(current_s) and sep_char(current_s[sep_len]):
            sep_len += 1
            
        sep = current_s[:sep_len]
        comps.append(sep)
        current_s = current_s[sep_len:]
        
        if not current_s.startswith(w):
            return False
            
        comps.append(w)
        current_s = current_s[len(w):]
        
    comps.append(current_s)
    
    return components(comps, out) and concat(comps) == s
