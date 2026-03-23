def longest_spec(strings, res):
    if not strings:
        return res is None
    
    max_len = -1
    longest_str = None
    for s in strings:
        if len(s) > max_len:
            max_len = len(s)
            longest_str = s
            
    return res == longest_str
