
def precondition(inp):
    if not isinstance(inp, tuple) or len(inp) != 1:
        return False
    words = inp[0]
    if not isinstance(words, list):
        return False
    if len(words) == 0:
        return False
    if not all(isinstance(w, str) for w in words):
        return False
    return True

def postcondition(inp, out):
    words = inp[0]
    if not isinstance(out, str):
        return False
    if out not in words:
        return False
    out_unique = len(set(out))
    for w in words:
        w_unique = len(set(w))
        if w_unique > out_unique:
            return False
        if w_unique == out_unique and w < out:
            return False
    return True

def _impl(words):
    """Write a function that accepts a list of strings.
    The list contains different words. Return the word with maximum number
    of unique characters. If multiple strings have maximum number of unique
    characters, return the one which comes first in lexicographical order.

    find_max(["name", "of", "string"]) == "string"
    find_max(["name", "enam", "game"]) == "enam"
    find_max(["aaaaaaa", "bb" ,"cc"]) == ""aaaaaaa"
    """
    mx_ch_cnt, ans = 0, ""
    for word in words:
        ch_cnt = len(set(word)) 
        if ch_cnt > mx_ch_cnt or (ch_cnt == mx_ch_cnt and word < ans):
            mx_ch_cnt, ans = ch_cnt, word
    return ans

def find_max(words):
    _input = (words,)
    assert precondition(_input)
    _output = _impl(words)
    assert postcondition(_input, _output)
    return _output
