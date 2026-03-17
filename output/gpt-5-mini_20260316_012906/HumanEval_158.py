
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    words = input[0]
    if not isinstance(words, list):
        return False
    if len(words) == 0:
        return False
    for w in words:
        if not isinstance(w, str):
            return False
    try:
        if len(set(words)) != len(words):
            return False
    except TypeError:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    words = input[0]
    if not isinstance(output, str):
        return False
    if output not in words:
        return False
    counts = [len(set(w)) for w in words]
    maxcount = max(counts)
    if len(set(output)) != maxcount:
        return False
    candidates = [w for w, c in zip(words, counts) if c == maxcount]
    if output != min(candidates):
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
