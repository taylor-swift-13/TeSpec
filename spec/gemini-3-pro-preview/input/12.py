def longest_spec(strings, result):
    if not strings:
        return result is None
    
    longest = strings[0]
    for s in strings[1:]:
        if len(s) > len(longest):
            longest = s
            
    return result == longest
