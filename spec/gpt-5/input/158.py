def chars_of_string(s: str) -> list:
    return list(s)

def unique_char_count(s: str, n: int) -> bool:
    return len(set(s)) == n

def find_max_spec(words: list, ans: str) -> bool:
    if not words:
        return ans == ""
    
    if ans not in words:
        return False
        
    n = len(set(ans))
    
    # Check if there is any word with more unique characters
    for w in words:
        if len(set(w)) > n:
            return False
            
    # Check if there is any word with the same number of unique characters
    # that is lexicographically strictly smaller than ans
    for w in words:
        if len(set(w)) == n:
            if w < ans:
                return False
                
    return True
