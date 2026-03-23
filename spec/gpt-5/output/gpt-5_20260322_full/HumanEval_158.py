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

def _impl(words):
    mx_ch_cnt, ans = 0, ""
    for word in words:
        ch_cnt = len(set(word))
        if ch_cnt > mx_ch_cnt or (ch_cnt == mx_ch_cnt and word < ans):
            mx_ch_cnt, ans = ch_cnt, word
    return ans

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(find_max_spec(*input, output))

def find_max(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
