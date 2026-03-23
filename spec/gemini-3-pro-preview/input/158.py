def list_of_string(s: str) -> list:
    return list(s)

def count_unique(s: str) -> int:
    return len(set(s))

def string_lt(s1: str, s2: str) -> bool:
    return s1 < s2

def find_max_spec(words: list, res: str) -> bool:
    if not words:
        return res == ""
    
    if res not in words:
        return False
        
    for w in words:
        cw = count_unique(w)
        cres = count_unique(res)
        
        condition_met = (cw < cres) or (cw == cres and (string_lt(res, w) or res == w))
        if not condition_met:
            return False
            
    return True
