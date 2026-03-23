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
