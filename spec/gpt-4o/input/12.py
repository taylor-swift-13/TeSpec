def longest_spec(strings, result):
    if not strings:
        return result is None
    
    maxlen = max(len(x) for x in strings)
    
    max_strings = [x for x in strings if len(x) == maxlen]
    
    if not max_strings:
        return False
        
    s = max_strings[0]
    for t in max_strings:
        if t != s:
            return False
            
    return result == s
